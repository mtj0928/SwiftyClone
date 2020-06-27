import SwiftyCloneCore
import Commander

extension CodeCloneType: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        guard let string = parser.shift(),
            let type = CodeCloneType(rawValue: string) else {
            throw ArgumentParserError("Failed parse as colde clone type")
        }
        self = type
    }

    public var description: String {
        return self.rawValue
    }
}
