import UIKit

@objc protocol TableDelegate: class {
    @objc optional func select(_ index: Int)
}

class TableViewController: UITableViewController {

    weak var delegate: TableDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 44
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentify = "section\(indexPath.section)row\(indexPath.row)"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify, for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.select?(indexPath.row)
    }

    func setData() {

    }

}
