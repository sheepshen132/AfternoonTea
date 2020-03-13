import UIKit
import Speech

class CustomController: BaseViewController {

    private var speaker: AVSpeechSynthesizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green

        let tableC = TableViewController()
        tableC.delegate = self
        
        speaker = AVSpeechSynthesizer()
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 50, y: 100, width: 100, height: 40)
        button.setTitle("点播", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc private func tap() {
        transToSpeech(by: "一寸金")
    }
    
    private func transToSpeech(by content: String) {
        let voice = AVSpeechSynthesisVoice(language: "zh_CN")
        let utterance = AVSpeechUtterance(string: content)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        speaker.speak(utterance)
    }
    
    private func stopVoice() {
        speaker.stopSpeaking(at: .immediate)
    }
    
    private func pauseVoice() {
        speaker.pauseSpeaking(at: .immediate)
    }
    
    private func continueVoice() {
        speaker.continueSpeaking()
    }
}

extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}

extension CustomController: TableDelegate {

}
