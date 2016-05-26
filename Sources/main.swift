#!/usr/bin/env swift

func main(arguments: [String]) {
    guard arguments.count == 2,
        let filename = arguments.last
        else
    {
        print("Usage: simple-emulator <input file>")
        return
    }
    
    // TODO
    print(filename)
}

main(Process.arguments)
