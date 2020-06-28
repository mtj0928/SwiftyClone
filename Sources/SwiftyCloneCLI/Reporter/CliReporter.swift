import SwiftyCloneCore

struct CliReporter: Reporter {

    func report(about clone: CodeClone) {
        if let type1Clone = clone as? Type1CodeClone{
            reportForType1Clone(type1Clone)
        } else if let type2Clone = clone as? Type2CodeClone {
            reportForType2Clone(type2Clone)
        }
    }

    private func reportForType1Clone(_ clone: Type1CodeClone) {
        var text = "Count: \(clone.chunks.count)\n"
        text += clone.chunks[0]
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
        print()
        print(text)
    }

    private func reportForType2Clone(_ clone: Type2CodeClone) {
        var text = "Count: \(clone.chunks.count)\n"
        clone.chunks.forEach { chunk in
            text += "-------\n\(chunk.description)\n"
        }
        print(text)
    }
}
