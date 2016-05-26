import Foundation

enum Instruction {

    typealias RegisterIndex = Int

    enum Destination {
        case register(RegisterIndex)
        case address(RegisterIndex)
    }

    enum Source {
        case value(Int)
        case register(RegisterIndex)
        case address(RegisterIndex)
    }

    case halt
    case move(to: Destination, from: Source)
    case add(to: Destination, with: Source)
    case multiply(to: Destination, with: Source)
    case jump(toAddress: RegisterIndex, ifNonzero: RegisterIndex)

    init(word: Word) throws {
        switch (word.function, word.operand1, word.operand2) {
        case (1, 0, 0):
            self = .halt
        case (2, let destination, let value):
            self = .move(to: .register(destination), from: .value(value))
        case (3, let destination, let value):
            self = .add(to: .register(destination), with: .value(value))
        case (4, let destination, let value):
            self = .multiply(to: .register(destination), with: .value(value))
        case (5, let destination, let registerIndex):
            self = .move(to: .register(destination), from: .register(registerIndex))
        case (6, let destination, let registerIndex):
            self = .add(to: .register(destination), with: .register(registerIndex))
        case (7, let destination, let registerIndex):
            self = .multiply(to: .register(destination), with: .register(registerIndex))
        case (8, let destination, let source):
            self = .move(to: .register(destination), from: .address(source))
        case (9, let source, let destination):
            self = .move(to: .address(destination), from: .register(source))
        case (0, let addressRegister, let flagRegister):
            self = .jump(toAddress: addressRegister, ifNonzero: flagRegister)
        default:
            throw NSError(se_message: "Invalid instruction word: \(word)")
        }
    }

}
