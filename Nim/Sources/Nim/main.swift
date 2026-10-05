import Foundation

func askMode(input: any InputProvider, output: any OutputRenderer) -> Int {
    output.showMessage("Выберите режим:")
    output.showMessage("  1) Игра на двоих (hot-seat)")
    output.showMessage("  2) Игра против компьютера")
    while true {
        if let value = input.requestInt(message: "Ваш выбор (1 или 2): "), value == 1 || value == 2 {
            return value
        }
        output.showError("Введите 1 или 2.")
    }
}

func askName(message: String, input: any InputProvider, output: any OutputRenderer) -> String {
    while true {
        let name = input.requestLine(message: message).trimmingCharacters(in: .whitespacesAndNewlines)
        if !name.isEmpty {
            return name
        }
        output.showError("Имя не может быть пустым.")
    }
}

func askPileCount(input: any InputProvider, output: any OutputRenderer) -> Int {
    while true {
        if let value = input.requestInt(message: "Сколько кучек? (от 3 до 10): "), (3...10).contains(value) {
            return value
        }
        output.showError("Введите целое число от 3 до 10.")
    }
}

func makePlayers(mode: Int, input: any InputProvider, output: any OutputRenderer) -> [Player] {
    if mode == 1 {
        let firstName = askName(message: "Имя первого игрока: ", input: input, output: output)
        let secondName = askName(message: "Имя второго игрока: ", input: input, output: output)
        return [
            Player(name: firstName, strategy: HumanStrategy(input: input, output: output)),
            Player(name: secondName, strategy: HumanStrategy(input: input, output: output))
        ]
    }
    let name = askName(message: "Ваше имя: ", input: input, output: output)
    return [
        Player(name: name, strategy: HumanStrategy(input: input, output: output)),
        Player(name: "Компьютер", strategy: RandomComputerStrategy())
    ]
}

func runApplication() {
    let input: any InputProvider = ConsoleInput()
    let output: any OutputRenderer = ConsoleOutput()

    output.showMessage("=== Игра «Ним» ===")
    let mode = askMode(input: input, output: output)
    let players = makePlayers(mode: mode, input: input, output: output)
    let pileCount = askPileCount(input: input, output: output)
    let state = GameState.makeRandom(players: players, pileCount: pileCount)
    let game = Game(state: state, output: output)
    game.run()
}

runApplication()
