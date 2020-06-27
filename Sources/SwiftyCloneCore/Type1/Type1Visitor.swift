import SwiftSyntax

public class Type1Visitor: SyntaxVisitor, Visitor {

    public private(set) var chunks = [CodeChunk]()

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
        let codeChunk = CodeChunk(tokens: tokens, original: statements._syntaxNode)
        chunks.append(codeChunk)
    }
}
