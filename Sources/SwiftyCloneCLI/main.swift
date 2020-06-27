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

    let visitor = type.visitor
    try urls.forEach { (url: URL) in
        let node = try SyntaxParser.parse(url)
        visitor.walk(node)
    }
    let cloneDetector = type.cloneDetector
    let clones = cloneDetector.detect(for: visitor.chunks)
    clones.forEach { print($0.description) }
}

main.run()

private func searchURL(url: URL, where condition: (URL) -> Bool) -> [URL] {
    return FileManager.default.subpaths(atPath: url.relativePath)?
        .compactMap {
            url.appendingPathComponent($0)

    }
        .filter(condition) ?? [url]
}
