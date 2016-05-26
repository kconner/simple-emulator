import Foundation

extension NSError {

    convenience init(se_message message: String) {
        self.init(
            domain: "simple-emulator",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey as NSString: message as NSString]
        )
    }

}
