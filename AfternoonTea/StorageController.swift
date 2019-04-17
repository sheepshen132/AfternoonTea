import UIKit

class StorageController: BaseViewController {


    private var changeFont: UILabel = {
        let button = UILabel()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 40
        button.text = "I just suibian kangkang"
        button.textAlignment = .center
        button.textColor = .white
        button.isUserInteractionEnabled = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
        self.view.addSubview(changeFont)
        changeFont.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(change)))
        changeFont.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            changeFont.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            changeFont.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            changeFont.widthAnchor.constraint(equalToConstant: 200),
            changeFont.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private let fonts = UIFont.familyNames
    private var count = 0
    @objc func change() {
        if fonts.count > count {
            let fontName = UIFont.fontNames(forFamilyName: fonts[count])
            if fontName.count > 0 {
                print("这一次是\(fontName[0])")
                changeFont.font = UIFont.init(name: fontName[0], size: 18)
            }
            print("轮空")
            count += 1
        }
    }
}
