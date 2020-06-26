import SwiftSyntax

public class Visitor: SyntaxVisitor {

    public override func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
        print(node.description)
        print("=====================================================================")
        return super.visit(node)
    }

    public override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
        print(node.description)
        print("=====================================================================")
        return super.visit(node)
    }
}
