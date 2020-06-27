import SwiftyCloneCore
import SwiftSyntax

struct XcodeReporter: Reporter {
    func report(with clone: CodeClone) {
        var chunks = clone.chunks
        let first = chunks.removeFirst()
        guard let firstSource = first.original.root.as(SourceFileSyntax.self) else {
            return
        }
        let firstConverter = SourceLocationConverter(file: first.source, tree: firstSource)
        let firstLocation = first.original.startLocation(converter: firstConverter)

        clone.chunks.forEach { chunk in
            guard let sourceFile = chunk.original.root.as(SourceFileSyntax.self) else {
                return
            }
            let converter = SourceLocationConverter(file: chunk.source, tree: sourceFile)
            let location = chunk.original.startLocation(converter: converter)

            print("\(chunk.path.path):\(location.line ?? 0):\(location.column ?? 0): warning: This code may be \(clone.type) code clode with \(first.path.path) at \(firstLocation.line ?? 0)")
        }
    }
}
