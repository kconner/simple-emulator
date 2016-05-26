#!/usr/bin/env swift

import Foundation

private enum Command: String {
    case run = "run"
    case runAndShowRegisters = "run-and-show-registers"
    case disassemble = "disassemble"
    case benchmark = "benchmark"
}

func main(arguments: [String]) throws {
    let (command, programPath) = try interpret(arguments: arguments)
    let program = try Program(contentsOfFile: programPath)

    switch command {
    case .run:
        var machine = Machine(program: program)
        print(try machine.execute())
    case .runAndShowRegisters:
        var machine = Machine(program: program)
        print(try machine.execute())
        print()
        print(machine.registerState)
    case .disassemble:
        print(try program.disassembled())
    case .benchmark:
        for _ in 0..<100000 {
            var machine = Machine(program: program)
            try machine.execute()
        }
    }
}

private func interpret(arguments: [String]) throws -> (command: Command, programPath: String) {
    guard arguments.count == 3,
        let command = Command(rawValue: arguments[1])
        else
    {
        throw NSError(
            se_message: "Usage: simple-emulator <command> <program-file>\n\n"
                + "Available commands:\n\n"
                + "   run                       Execute, then show the count of instructions run\n"
                + "   run-and-show-registers    Also show the final register state\n"
                + "   disassemble               Disassemble the program\n"
                + "   benchmark                 Run 100,000 times, for use with the time command"
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
