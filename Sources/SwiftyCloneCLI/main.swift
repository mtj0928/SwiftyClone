import Foundation
import Commander
import SwiftyCloneCore
import SwiftSyntax

let main = command(
    Argument<URL>("path", description: "a file or a target directory including target Swift source files."),
    Option<CodeCloneType>("type", default: .type1, description: "code clone type. (type1, type2, typ3)")
    )
{ url, type in
    let visitor = type.visitor
    let node = try SyntaxParser.parse(url)
    visitor.walk(node)
    let cloneDetector = type.cloneDetector
    let clones = cloneDetector.detect(for: visitor.chunks)
    clones.forEach { printClone($0) }
}

main.run()

private func printClone(_ clone: CodeClone) {
    let text = clone.chunks[0]
        .original
        .description
        .split(separator: "\n")
        .map { $0.trimmingCharacters(in: .whitespaces) }
        .reduce("") { (result, line) -> String in
            if result.isEmpty {
                return line
            }
            return "\(result)\n\(line)"
    }
    if text.isEmpty {
        return
    }
    print("Count: \(clone.chunks.count)")
    print(text)
    print("")
}
