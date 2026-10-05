import Foundation

internal struct ConsoleInput: InputProvider {
    internal init() {}

    internal func requestLine(message: String) -> String {
        print(message, terminator: "")
        fflush(stdout)
        guard let line = readLine() else {
            print("")
            print("Ввод завершён. Выход.")
            exit(0)
        }
        return line
    }
}
