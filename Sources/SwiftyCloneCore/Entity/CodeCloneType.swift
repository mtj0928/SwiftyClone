import Foundation

public enum CodeCloneType: String {
    case type1, type2, type3

    public var visitor: Visitor {
        switch self {
        case .type1:
            return Type1Visitor()
        default:
            break
        }
        fatalError()
    }

    public var cloneDetector: CloneDetector {
        return Type1CloneDetetor()
    }
}
