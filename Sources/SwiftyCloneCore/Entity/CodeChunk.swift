import SwiftSyntax

public struct CodeChunk {
    public let tokens: [Token]
    public let original: Syntax

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

    public init(tokens: [Token], original: Syntax) {
        self.tokens = tokens
        self.original = original
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
