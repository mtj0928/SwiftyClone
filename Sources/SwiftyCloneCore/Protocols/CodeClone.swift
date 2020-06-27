public protocol CodeClone {
    var type: CodeCloneType { get }
    var chunks: [CodeChunk] { get }
    var description: String { get }
}
