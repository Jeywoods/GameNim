internal struct Player {
    internal let name: String
    internal let strategy: any MoveStrategy

    internal init(name: String, strategy: any MoveStrategy) {
        self.name = name
        self.strategy = strategy
    }
}
