import Foundation
import Commander
import SwiftyCloneCore
import SwiftSyntax

let main = command(
    Argument<URL>("path", description: "a file or a target directory including target Swift source files."),
    Option<CodeCloneType>("type", default: .type1, description: "code clone type. (type1, type2, typ3)")
    )
{ url, type in
    let urls = searchURL(url: url) { (u: URL) -> Bool in
        u.pathExtension == "swift"
    }

    let chunks = try urls.flatMap { (url: URL) -> [CodeChunk] in
        let source = try loadFile(of: url)
        let node = try SyntaxParser.parse(source: source)
        let visitor = type.createVisitor(source: source, at: url)
        visitor.walk(node)
        return visitor.chunks
    }

    let cloneDetector = type.cloneDetector
    let clones = cloneDetector.detect(for: chunks)
    let reporter = XcodeReporter()
    clones.forEach { reporter.report(with: $0) }
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
