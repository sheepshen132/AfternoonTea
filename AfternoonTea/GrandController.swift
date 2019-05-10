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
    }
}
