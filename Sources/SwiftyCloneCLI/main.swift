import Foundation
import Commander
import SwiftyCloneCore
import SwiftSyntax
import Logging

let main = command(
    Argument<URL>("path", description: "a file or a target directory including target Swift source files."),
    Option<CodeCloneType>("type", default: .type1, description: "code clone type. (type1, type2, typ3)")
    )
{ url, type in
    let startDate = Date()
    let urls = searchURL(url: url) { (u: URL) -> Bool in
        u.pathExtension == "swift"
    }

    var logger = Logger(label: "SwityCloneCLI")
    logger.logLevel = Logger.Level.debug

    let chunks = try urls.flatMap { (url: URL) -> [CodeChunk] in
        let source = try loadFile(of: url)
        let node = try SyntaxParser.parse(source: source)
        let visitor = type.createVisitor(source: source, at: url)
        
        logger.debug("Walking \(url.path)")
        visitor.walk(node)
        return visitor.chunks
    }

    let cloneDetector = type.cloneDetector
    let clones = cloneDetector.detect(for: chunks)
    let reporter = CliReporter()
    clones.forEach { reporter.report(about: $0) }

    let elapsed = Date().timeIntervalSince(startDate)
    logger.debug(Logger.Message.init(stringLiteral: "Time: \(elapsed)"))
}

main.run()

private func loadFile(of url: URL) throws -> String {
    try Data(contentsOf: url).withUnsafeBytes { buf in
      return String.fromBuffer(buf.bindMemory(to: UInt8.self))
    }
}

private func searchURL(url: URL, where condition: (URL) -> Bool) -> [URL] {
    return FileManager.default.subpaths(atPath: url.relativePath)?
        .compactMap {
            url.appendingPathComponent($0)

    }
        .filter(condition) ?? [url]
}
