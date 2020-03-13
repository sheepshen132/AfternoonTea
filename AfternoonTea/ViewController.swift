import UIKit


class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .red

        guard let imageV = UIImageView.fromGif(frame: CGRect(origin: .zero, size: self.view.frame.size),
                                               resourceName: "test") else { return }
        UIApplication.shared.keyWindow!.addSubview(imageV)
        imageV.animationDuration = 2.0
        imageV.animationRepeatCount = 3
        imageV.startAnimating()
    }


}

