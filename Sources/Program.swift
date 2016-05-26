import Foundation

struct Program {

    let words: [Word] 

    init(contentsOfFile path: String) throws {
        words = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            .components(separatedBy: NSCharacterSet.whitespacesAndNewlines())
            .filter { !$0.isEmpty }
            .map(Word.init(programLine:))
    }

}
