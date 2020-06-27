import Foundation

public enum CodeCloneType: String {
    case type1, type2, type3

    public var visitor: Visitor {
        switch self {
        case .type1:
            return Type1Visitor()
        case .type2:
            return Type2Visitor()
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
