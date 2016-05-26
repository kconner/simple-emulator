import Foundation

struct Program {

    let words: [Int] 

    init(contentsOfFile path: String) throws {
        let lines = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            .components(separatedBy: NSCharacterSet.whitespacesAndNewlines())
            .filter { !$0.isEmpty }

        guard lines.count <= Machine.wordCount else {
            throw NSError(se_message: "Program is too long for memory: \(lines.count) words out of \(Machine.wordCount) available.")
        }

        words = try lines.map(Int.init(se_programLine:))
    }

    func disassembled() throws -> String {
        return try words.map { "\(try Instruction(word: $0))\t// \($0)" }.joined(separator: "\n")
    }

}
