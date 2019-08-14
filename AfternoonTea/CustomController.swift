import UIKit

class CustomController: BaseViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green

        let tableC = TableViewController()
        tableC.delegate = self
    }
}

extension CustomController: TableDelegate {

}
