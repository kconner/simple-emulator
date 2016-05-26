struct Machine {

    static let registerCount = 10
    static let wordCount = 1000

    private var registers: [Int]
    private var words: [Int]
    private var instructionAddress: Int = 0

    init(program: Program) {
        registers = Array(repeating: 0, count: Machine.registerCount)

        var words: [Int] = Array(repeating: 0, count: Machine.wordCount)
        let programWords = program.words
        let range = 0..<programWords.count
        words[range] = programWords[range]
        self.words = words
    }

    var registerState: String {
        return registers.enumerated().map { "r\($0): \($1)" }.joined(separator: "\n")
    }

    mutating func execute() throws -> Int {
        var count = 1
        while perform(instruction: try currentInstruction()) {
            count += 1
        } 
        return count
    }

    private mutating func perform(instruction: Instruction) -> Bool {
        switch instruction {
        case .halt:
            return false
        case let .move(destination, source):
            write(to: destination, value: read(from: source))
            instructionAddress += 1
        case let .add(destination, source):
            write(to: destination, value: (read(from: destination.asSource) + read(from: source)) % 1000)
            instructionAddress += 1
        case let .multiply(destination, source):
            write(to: destination, value: (read(from: destination.asSource) * read(from: source)) % 1000)
            instructionAddress += 1
        case let .jump(addressIndex, flagIndex):
            if read(from: .register(index: flagIndex)) != 0 {
                instructionAddress = read(from: .register(index: addressIndex))
            } else {
                instructionAddress += 1
            }
        }

        instructionAddress %= 1000
        return true
    }

    private func read(from source: Instruction.Source) -> Int {
        switch source {
        case let .value(value):
            return value
        case let .register(registerIndex):
            return registers[registerIndex]
        case let .address(registerIndex):
            return words[registers[registerIndex]]
        }
    }

    private mutating func write(to destination: Instruction.Destination, value: Int) {
        switch destination {
        case let .register(registerIndex):
            registers[registerIndex] = value
        case let .address(registerIndex):
            words[registers[registerIndex]] = value
        }
    }

    private func currentInstruction() throws -> Instruction {
        return try Instruction(word: words[instructionAddress])
    }

}
