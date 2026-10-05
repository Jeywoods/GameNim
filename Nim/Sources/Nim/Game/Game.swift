internal final class Game {
    private var state: GameState
    private let output: any OutputRenderer

    internal init(state: GameState, output: any OutputRenderer) {
        self.state = state
        self.output = output
    }

    internal func run() {
        while true {
            output.showPiles(state.piles)
            let player = state.currentPlayer
            output.showTurn(player)

            let move = player.strategy.chooseMove(in: state)
            guard state.isValid(move) else {
                output.showError("Недопустимый ход.")
                continue
            }

            state.apply(move)
            let remaining = state.piles.map { $0.stones }
            output.showMove(player: player, move: move, remaining: remaining)

            if state.isOver {
                output.showWinner(player)
                return
            }
            state.advanceTurn()
        }
    }
}
