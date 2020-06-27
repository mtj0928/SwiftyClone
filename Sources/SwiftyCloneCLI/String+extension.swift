extension String {
    static func fromBuffer(_ textBuffer: UnsafeBufferPointer<UInt8>) -> String {
        return String(decoding: textBuffer, as: UTF8.self)
    }
}
