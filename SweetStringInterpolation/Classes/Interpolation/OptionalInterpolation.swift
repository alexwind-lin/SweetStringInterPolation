import Foundation

extension DefaultStringInterpolation {
    public mutating func appendInterpolation<T>(opt: T?, printOptionalPrefix: Bool = false) {
        if printOptionalPrefix == false, let opt = opt {
            appendInterpolation(opt)
        } else {
            appendInterpolation(String(describing: opt))
        }
    }
}
