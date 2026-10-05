import Foundation

internal protocol InputProvider {
    func requestLine(message: String) -> String
}

extension InputProvider {
    internal func requestInt(message: String) -> Int? {
        let line = requestLine(message: message)
        return Int(line.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
