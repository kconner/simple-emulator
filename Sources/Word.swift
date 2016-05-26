import Foundation

struct Word {
    
    let function: Int
    let operand1: Int
    let operand2: Int

    init() {
        function = 0
        operand1 = 0
        operand2 = 0
    }

    init(value: Int) {
        function = value % 1000
        operand1 = value % 100
        operand2 = value % 10
    }

    init(programLine: String) throws {
        let scalars = programLine.unicodeScalars
        guard scalars.count == 3 else {
            throw NSError(se_message: "Invalid instruction: \(programLine)")
        }
        
        var index = scalars.startIndex
        function = Int(scalars[index].value) - 0x30 // Offset from zero character
        index = scalars.index(after: index)
        operand1 = Int(scalars[index].value) - 0x30
        index = scalars.index(after: index)
        operand2 = Int(scalars[index].value) - 0x30

        guard 0..<10 ~= function && 0..<10 ~= operand1 && 0..<10 ~= operand2 else {
            throw NSError(se_message: "Invalid instruction: \(programLine)")
        }
    }
    
}

extension Word: CustomStringConvertible {

    var description: String {
        return "\(function)\(operand1)\(operand2)"
    }

}
