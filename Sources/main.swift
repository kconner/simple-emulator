#!/usr/bin/env swift

import Foundation

private enum Command: String {
    case run = "run"
    case decode = "decode"
}

func main(arguments: [String]) throws {
    let (command, programPath) = try parse(arguments: arguments)
    let program = try Program(contentsOfFile: programPath)

    switch command {
    case .run:
        var machine = Machine(program: program)
        let instructionsExecuted = try machine.execute()
        print(instructionsExecuted)
        print(machine.registers)
    case .decode:
        print(try program.words.map { try Instruction(word: $0) })
    }
}

private func parse(arguments: [String]) throws -> (command: Command, programPath: String) {
    guard arguments.count == 3,
        let command = Command(rawValue: arguments[1])
        else
    {
        throw NSError(
            se_message: "Usage: simple-emulator <command> <program-file>\n"
                + "    simple-emulator run <program-file>       Execute the program\n"
                + "    simple-emulator decode <program-file>    Disassemble the program"
        )
    }

    let programPath = arguments[2]

    return (command: command, programPath: programPath)
}

do {
    try main(arguments: Process.arguments)
} catch {
    print((error as NSError).localizedDescription)
    exit(1)
}
