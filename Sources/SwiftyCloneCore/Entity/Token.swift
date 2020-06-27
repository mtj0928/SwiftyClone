import Foundation
import SwiftSyntax

public struct Token {
    public let original: Syntax
    public let value: String
}

extension Token: Hashable {

    public func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}
