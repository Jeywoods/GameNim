internal protocol OutputRenderer {
    func showMessage(_ text: String)
    func showError(_ text: String)
    func showPiles(_ piles: [Pile])
    func showTurn(_ player: Player)
    func showMove(player: Player, move: Move, remaining: [Int])
    func showWinner(_ player: Player)
}
