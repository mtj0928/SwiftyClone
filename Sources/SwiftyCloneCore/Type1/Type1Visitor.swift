import Foundation
import SwiftSyntax

public class Type1Visitor: SyntaxVisitor, Visitor {

    public private(set) var chunks = [CodeChunk]()
    private let source: String
    private let path: URL

    public required init(source: String, at path: URL) {
        self.source = source
        self.path = path
    }

    public override func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
        push(node.statements)
        return super.visit(node)
    }

    public override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
        push(node.statements)
        return super.visit(node)
    }

    private func push(_ statements: CodeBlockItemListSyntax) {
        let tokens = statements.tokens.map { Token(original: $0._syntaxNode, value: $0.text) }
        let codeChunk = CodeChunk(tokens: tokens, original: statements._syntaxNode, source: source, at: path)
        chunks.append(codeChunk)
    }
}
