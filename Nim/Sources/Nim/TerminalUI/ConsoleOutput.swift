import Foundation

internal struct ConsoleOutput: OutputRenderer {
    private let labelWidth = 9
    private let dotsWidth = 13

    internal init() {}

    internal func showMessage(_ text: String) {
        print(text)
    }

    internal func showError(_ text: String) {
        print("Ошибка: \(text)")
    }

    internal func showPiles(_ piles: [Pile]) {
        print("")
        for (offset, pile) in piles.enumerated() {
            let label = padded("Кучка \(offset + 1):", to: labelWidth)
            let dots = padded(Array(repeating: "●", count: pile.stones).joined(separator: " "), to: dotsWidth)
            print("\(label) \(dots)  (\(pile.stones))")
        }
        print("")
    }

    internal func showTurn(_ player: Player) {
        print("Ход: \(player.name)")
    }

    internal func showMove(player: Player, move: Move, remaining: [Int]) {
        let left = remaining.map { String($0) }.joined(separator: ", ")
        let word = stoneWord(for: move.count)
        print("\(player.name) берёт \(move.count) \(word) из кучки \(move.pileIndex + 1). Осталось: \(left)")
    }

    internal func showWinner(_ player: Player) {
        print("")
        print("Все кучки пусты. Победитель: \(player.name)!")
    }

    private func padded(_ text: String, to width: Int) -> String {
        if text.count >= width {
            return text
        }
        return text + String(repeating: " ", count: width - text.count)
    }

    private func stoneWord(for count: Int) -> String {
        let lastTwo = count % 100
        let last = count % 10
        if lastTwo >= 11 && lastTwo <= 14 {
            return "камней"
        }
        if last == 1 {
            return "камень"
        }
        if last >= 2 && last <= 4 {
            return "камня"
        }
        return "камней"
    }
}
