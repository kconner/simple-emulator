struct Machine {

    let words: [Word]

    init(program: Program) {
        var words: [Word] = Array(repeating: Word(), count: 1000)
        let programWords = program.words
        let range = 0..<programWords.count
        words[range] = programWords[range]
        self.words = words
    }

}
