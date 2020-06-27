import SwiftSyntax

public struct CodeChunk {
    public let tokens: [Token]
    public let original: Syntax

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
