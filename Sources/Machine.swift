struct Machine {

    static let registerCount = 10
    static let wordCount = 1000

    var registers: [Word]
    var words: [Word]
    var instructionPointer: Int = 0

    init(program: Program) {
        registers = Array(repeating: Word(), count: Machine.registerCount)

        var words: [Word] = Array(repeating: Word(), count: Machine.wordCount)
        let programWords = program.words
        let range = 0..<programWords.count
        words[range] = programWords[range]
        self.words = words
    }

    mutating func execute() throws {
        repeat {} while perform(instruction: try currentInstruction())
    }

    private mutating func perform(instruction: Instruction) -> Bool {
        switch instruction {
        case .halt:
            return false
        case let .move(destination, source):
            write(to: destination, value: read(from: source))
            instructionPointer += 1
        case let .add(destination, source):
            write(to: destination, value: read(from: destination.asSource) + read(from: source))
            instructionPointer += 1
        case let .multiply(destination, source):
            write(to: destination, value: read(from: destination.asSource) * read(from: source))
            instructionPointer += 1
        case let .jump(addressRegisterIndex, flagRegisterIndex):
            if read(from: .register(flagRegisterIndex)) != Word() {
                instructionPointer = read(from: .register(addressRegisterIndex)).value
            } else {
                instructionPointer += 1
            }
        }

        instructionPointer %= 1000
        return true
    }

    private func read(from source: Instruction.Source) -> Word {
        switch source {
        case let .value(value):
            return Word(value: value)
        case let .register(registerIndex):
            return registers[registerIndex]
        case let .address(registerIndex):
            return words[registers[registerIndex].value]
        }
    }

    private mutating func write(to destination: Instruction.Destination, value: Word) {
        switch destination {
        case let .register(registerIndex):
            registers[registerIndex] = value
        case let .address(registerIndex):
            words[registers[registerIndex].value] = value
        }
    }

    private func currentInstruction() throws -> Instruction {
        return try Instruction(word: words[instructionPointer])
    }

}
