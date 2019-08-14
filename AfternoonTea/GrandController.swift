import UIKit

class GrandController: UITabBarController {

    @IBOutlet weak var myTabar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        myTabar.shadowImage = UIImage()
        myTabar.backgroundImage = UIImage()
        myTabar.isTranslucent = false
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title

        let a = Devices.Iphone5s
        let b = a.rawValue
        print("the phone size string is \(a), width is \(b.width), height is \(b.height)")

        guard let index = self.tabBar.items?.index(of: item) else { return }
        for ele in tabBar.subviews where ele .isKind(of: NSClassFromString("UITabBarButton")!) {
            for elr in ele.subviews where elr .isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                animateViewByIndex(index, view: elr)
            }
        }
    }

    func animateViewByIndex(_ index: Int, view: UIView) {
        switch index {
        case 0:
            gravityAnimationBy(view: view)
        case 1:
            scaleAnimationBy(view: view)
        case 2:
            rotationAnimationBy(view: view)
        case 3:
            bigAnimationBy(view: view)
        default:
            translationAnimationBy(view: view)
        }
    }

    // 重力动画
    func gravityAnimationBy(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [0.0, -4.15, -7.26, -9.34, -10.37, -9.34,
                            -7.26, -4.15, 0.0, 2.0, -2.9, -4.94, -6.11,
                            -6.42, -5.86, -4.44, -2.16, 0.0]
        animation.duration = 0.8
        animation.beginTime = CACurrentMediaTime() + 1
        view.layer.add(animation, forKey: nil)
    }

    // 放大-缩小
    func scaleAnimationBy(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = 0.7
        animation.toValue = 1.3
        view.layer.add(animation, forKey: nil)
    }

    // Z轴旋转
    func rotationAnimationBy(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fromValue = 0
        animation.toValue = Double.pi
        view.layer.add(animation, forKey: nil)
    }

    // Y轴位移
    func translationAnimationBy(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fromValue = 0
        animation.toValue = -10
        view.layer.add(animation, forKey: nil)
    }

    // 放大并保持
    func bigAnimationBy(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.fromValue = 1.0
        animation.toValue = 1.15
        view.layer.add(animation, forKey: nil)
    }
}
