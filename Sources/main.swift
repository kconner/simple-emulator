#!/usr/bin/env swift

import Foundation

private let errorDomain = "simple-emulator"

func main(arguments: [String]) throws {
    let path = try inputFilePath(arguments: arguments)
    let program = try Program(contentsOfFile: path)
    print(program.instructions)
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
