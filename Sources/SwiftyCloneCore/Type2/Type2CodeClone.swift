struct Type2CodeClone: CodeClone {
    let type = CodeCloneType.type2
    let chunks: [CodeChunk]

    var description: String {
        var text = "Count: \(chunks.count)\n"
        chunks.forEach { chunk in
            text += "-------\n\(chunk.description)\n"
        }
        return text
    }
}
