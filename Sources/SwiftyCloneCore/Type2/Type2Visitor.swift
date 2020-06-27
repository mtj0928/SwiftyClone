import Foundation
import SwiftSyntax

public class Type2Visitor: SyntaxVisitor, Visitor {

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
        let tokens = normalization(statements)
        let codeChunk = CodeChunk(tokens: tokens, original: statements._syntaxNode, source: source, at: path)
        chunks.append(codeChunk)
    }

    private func normalization(_ statements: CodeBlockItemListSyntax) -> [Token] {
        var identifierMap = [String: Int]()
        var counter = 0
        return statements.tokens.map { token -> Token in
            switch token.tokenKind {
            case .identifier(let text):
                if token.parent?.isProtocol(PatternSyntaxProtocol.self) ?? false {
                    let id: Int
                    if let cached = identifierMap[text] {
                        id = cached
                    } else {
                        id = counter
                        identifierMap[text] = id
                        counter += 1
                    }

                    return Token(original: token._syntaxNode, value: "replaced\(id)")
                } else if let expr = token.parent?.as(IdentifierExprSyntax.self),
                    expr.parent?.is(ArrayElementSyntax.self) == false,
                    expr.parent?.is(FunctionCallExprSyntax.self) == false
                {
                    let id: Int
                    if let cached = identifierMap[text] {
                        id = cached
                    } else {
                        id = counter
                        identifierMap[text] = id
                        counter += 1
                    }
                    return Token(original: token._syntaxNode, value: "replaced\(id)")
                }
            default:
                break
            }
            return Token(original: token._syntaxNode, value: token.text)
        }
    }
}
