struct Type2CloneDetetor: CloneDetector {

    func detect(for chunks: [CodeChunk]) -> [CodeClone] {
        Dictionary(grouping: chunks, by: { $0.hashValue })
            .map { $0.value }
            .filter { $0.count >= 2 }
            .map { Type2CodeClone(chunks: $0) }
            .sorted(by: { $0.chunks.count >= $1.chunks.count })
    }
}
