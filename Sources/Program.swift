import Foundation

struct Program {

    typealias Instruction = Int

    let instructions: [Instruction] 

    init(contentsOfFile path: String) throws {
        instructions = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            .components(separatedBy: NSCharacterSet.whitespacesAndNewlines())
            .enumerated()
            .filter { _, line in
                !line.isEmpty
            }
            .map { index, line in
                guard let instruction = Instruction(line) where instruction.isValid else {
                    throw NSError(se_message: "Bad instruction on line \(index + 1): \(line)")
                }

                return instruction
            }
    }

}

private extension Program.Instruction {

    var isValid: Bool {
        return 0..<1000 ~= self
    }

}
