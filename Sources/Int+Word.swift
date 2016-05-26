import Foundation

extension Int {
    
    init(se_programLine line: String) throws {
        guard let value = Int(line) else {
            throw NSError(se_message: "Invalid instruction: \(line)")
        }

        self = value % 1000
    }
    
    var se_digits: (function: Int, operand1: Int, operand2: Int) {
        var remainder = self
        let operand2 = remainder % 10

        remainder = (remainder - operand2) / 10
        let operand1 = remainder % 10

        remainder = (remainder - operand1) / 10
        let function = remainder

        return (function: function, operand1: operand1, operand2: operand2)
    }

}
