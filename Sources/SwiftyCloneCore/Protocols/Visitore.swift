import Foundation
import SwiftSyntax

public protocol Visitor: SyntaxVisitor {
    var chunks: [CodeChunk] { get }

    init(source: String, at path: URL) 
}
