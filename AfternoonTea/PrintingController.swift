import UIKit

class PrintingController: BaseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow

        self.navigationController?.pushViewController(OrderDetailController(),
                                                      animated: true)
    }
}
