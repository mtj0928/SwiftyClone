import SwiftSyntax

public protocol Visitor: SyntaxVisitor {
    var chunks: [CodeChunk] { get }
}
