internal struct HumanStrategy: MoveStrategy {
    private let input: any InputProvider
    private let output: any OutputRenderer

    internal init(input: any InputProvider, output: any OutputRenderer) {
        self.input = input
        self.output = output
    }

    internal func chooseMove(in state: GameState) -> Move {
        while true {
            guard let pileNumber = input.requestInt(message: "Номер кучки: ") else {
                output.showError("Введите целое число.")
                continue
            }
            guard pileNumber >= 1, pileNumber <= state.piles.count else {
                output.showError("Кучки с таким номером нет. Допустимо: от 1 до \(state.piles.count).")
                continue
            }
            let pile = state.piles[pileNumber - 1]
            guard !pile.isEmpty else {
                output.showError("Эта кучка пуста.")
                continue
            }
            guard let count = input.requestInt(message: "Сколько камней взять (от 1 до \(pile.stones)): ") else {
                output.showError("Введите целое число.")
                continue
            }
            guard count >= 1, count <= pile.stones else {
                output.showError("Из этой кучки можно взять от 1 до \(pile.stones) камней.")
                continue
            }
            return Move(pileIndex: pileNumber - 1, count: count)
        }
    }
}
