import Foundation

enum Instruction {

    enum Destination {
        case register(index: Int)
        case address(registerIndex: Int)

        var asSource: Source {
            switch self {
            case let .register(index):
                return .register(index: index)
            case let .address(index):
                return .address(registerIndex: index)
            }
        }
    }

    enum Source {
        case value(Int)
        case register(index: Int)
        case address(registerIndex: Int)
    }

    case halt
    case move(to: Destination, from: Source)
    case add(to: Destination, with: Source)
    case multiply(to: Destination, with: Source)
    case jump(toAddress: Int, ifNonzero: Int)

    init(word: Word) throws {
        switch (word.function, word.operand1, word.operand2) {
        case (1, 0, 0):
            self = .halt
        case let (2, index, value):
            self = .move(to: .register(index: index), from: .value(value))
        case let (3, index, value):
            self = .add(to: .register(index: index), with: .value(value))
        case let (4, index, value):
            self = .multiply(to: .register(index: index), with: .value(value))
        case let (5, destinationIndex, sourceIndex):
            self = .move(to: .register(index: destinationIndex), from: .register(index: sourceIndex))
        case let (6, destinationIndex, sourceIndex):
            self = .add(to: .register(index: destinationIndex), with: .register(index: sourceIndex))
        case let (7, destinationIndex, sourceIndex):
            self = .multiply(to: .register(index: destinationIndex), with: .register(index: sourceIndex))
        case let (8, destinationIndex, sourceIndex):
            self = .move(to: .register(index: destinationIndex), from: .address(registerIndex: sourceIndex))
        case let (9, sourceIndex, destinationIndex):
            self = .move(to: .address(registerIndex: destinationIndex), from: .register(index: sourceIndex))
        case let (0, addressIndex, flagIndex):
            self = .jump(toAddress: addressIndex, ifNonzero: flagIndex)
        default:
            throw NSError(se_message: "Invalid instruction: \(word)")
        }
    }

}

extension Instruction: CustomStringConvertible {

    var description: String {
        switch self {
        case .halt:
            return "return"
        case let .move(destination, source):
            return "\(destination) = \(source)"
        case let .add(destination, source):
            return "\(destination) = \(destination) + \(source)"
        case let .multiply(destination, source):
            return "\(destination) = \(destination) * \(source)"
        case let .jump(addressIndex, flagIndex):
            return "if r\(flagIndex) != 0 {\n"
                + "    goto *r\(addressIndex)\n"
                + "}"
        }
    }

}

extension Instruction.Destination: CustomStringConvertible {

    var description: String {
        switch self {
        case let .register(index):
            return "r\(index)"
        case let .address(registerIndex):
            return "*r\(registerIndex)"
        }
    }
    
}

extension Instruction.Source: CustomStringConvertible {

    var description: String {
        switch self {
        case let .value(value):
            return value.description
        case let .register(index):
            return "r\(index)"
        case let .address(registerIndex):
            return "*r\(registerIndex)"
        }
    }
    
}
