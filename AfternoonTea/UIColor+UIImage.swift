import UIKit

extension UIColor {
    func createImage(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        self.setFill()
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    func getColorType() -> String {
        return String(describing: type(of: self))
    }

    func getColorName() -> String {
        return String(describing: self)
    }
}
