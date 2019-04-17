import UIKit

class BaseViewController: UIViewController {


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationItem.leftBarButtonItem?.title = ""
    }
}
