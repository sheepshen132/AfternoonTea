import UIKit

class GrandController: UITabBarController {

    @IBOutlet weak var myTabar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
}
