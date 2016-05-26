#!/usr/bin/env swift

import Foundation

func main(arguments: [String]) throws {
    let path = try inputFilePath(arguments: arguments)
    let program = try Program(contentsOfFile: path)
    let machine = Machine(program: program)
    print(program.words)
}

private func inputFilePath(arguments: [String]) throws -> String {
    guard arguments.count == 2,
        let path = arguments.last
        else
    {
        throw NSError(se_message: "Usage: simple-emulator <input file>")
    }

    return path
}

do {
    try main(arguments: Process.arguments)
} catch {
    print((error as NSError).localizedDescription)
    exit(1)
}
