import Foundation

struct Type1CloneDetetor: CloneDetector {

    func detect(for chunks: [CodeChunk]) -> [CodeClone] {
        Dictionary(grouping: chunks, by: { $0.hashValue })
            .filter { $0.value.count >= 2 }
            .map { $0.value }
            .map { Type1CodeClone(chunks: $0) }
            .sorted(by: { $0.chunks.count >= $1.chunks.count })
    }
}
