struct Type1CodeClone: CodeClone {
    let type = CodeCloneType.type1
    let chunks: [CodeChunk]

    var description: String {
        var text = "Count: \(chunks.count)\n"
        text += chunks[0]
            .original
            .description
            .split(separator: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .reduce("") { (result, line) -> String in
                if result.isEmpty {
                    return line
                }
                return "\(result)\n\(line)"
        }
        return text
    }
}
