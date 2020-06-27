import Foundation
import SwiftSyntax

public struct CodeChunk {
    public let tokens: [Token]
    public let original: Syntax
    public let source: String
    public let path: URL

    public var description: String {
        original
            .description
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .reduce("") { (result, line) -> String in
                if result.isEmpty {
                    return line
                }
                return "\(result)\n\(line)"
        }
    }

    public init(tokens: [Token], original: Syntax, source: String, at path: URL) {
        self.tokens = tokens
        self.original = original
        self.source = source
        self.path = path
    }
}

extension CodeChunk: Hashable {
    public static func == (lhs: CodeChunk, rhs: CodeChunk) -> Bool {
        lhs.tokens == rhs.tokens
    }

    public func hash(into hasher: inout Hasher) {
        tokens.hash(into: &hasher)
    }
}
