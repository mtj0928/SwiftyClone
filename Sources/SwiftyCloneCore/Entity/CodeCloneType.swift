import Foundation

public enum CodeCloneType: String {
    case type1, type2, type3

    public func createVisitor(source: String, at path: URL) -> Visitor {
        switch self {
        case .type1:
            return Type1Visitor(source: source, at: path)
        case .type2:
            return Type2Visitor(source: source, at: path)
        default:
            break
        }
        fatalError()
    }

    public var cloneDetector: CloneDetector {
        switch self {
        case .type1:
            return Type1CloneDetetor()
        case .type2:
            return Type2CloneDetetor()
        default:
            break
        }
        fatalError()
    }
}
