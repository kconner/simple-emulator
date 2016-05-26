import Foundation

struct Program {

    let words: [Word] 

    init(contentsOfFile path: String) throws {
        let lines = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            .components(separatedBy: NSCharacterSet.whitespacesAndNewlines())
            .filter { !$0.isEmpty }

        guard lines.count <= Machine.wordCount else {
            throw NSError(se_message: "Program is too long for memory: \(lines.count) words out of \(Machine.wordCount).")
        }

        words = try lines.map(Word.init(programLine:))
    }

}
