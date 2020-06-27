public protocol CloneDetector {
    func detect(for chunks: [CodeChunk]) -> [CodeClone]
}
