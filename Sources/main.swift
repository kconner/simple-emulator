#!/usr/bin/env swift

import Foundation

func main(arguments: [String]) throws {
    let path = try inputFilePath(arguments: arguments)
    let program = try Program(contentsOfFile: path)
    var machine = Machine(program: program)
    print(machine.words[0..<100])
    print(machine.registers)
    try machine.execute()
    print(machine.words[0..<100])
    print(machine.registers)
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
