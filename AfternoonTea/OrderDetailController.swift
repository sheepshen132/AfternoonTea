import UIKit
import Speech
import AVFoundation

class OrderDetailController: BaseViewController {
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var recordBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("开始录音", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(recordAction(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var recordRequest: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recordTask: SFSpeechRecognitionTask?
    fileprivate let audioEngine = AVAudioEngine()
    fileprivate lazy var recognizer: SFSpeechRecognizer = {
        let recognize = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
        recognize?.delegate = self
        return recognize!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "订单详情"
        self.view.backgroundColor = .white
        
        textView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(textView)
        
        recordBtn.frame = CGRect(x: 100, y: 250, width: 100, height: 40)
        recordBtn.isUserInteractionEnabled = true
        self.view.addSubview(recordBtn)
        
        addSpeechRecordLimit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopRecognize()
    }
    
    @objc private func recordAction(_ sender: UIButton) {
        let isStart = sender.currentTitle!.contains("开始")
        recordBtn.setTitle(isStart ? "停止录音" : "开始录音", for: .normal)
        isStart ? startRecognize() : stopRecognize()
    }
    
    //开始识别
    fileprivate func startRecognize(){
        //1. 停止当前任务
        stopRecognize()
        
        //2. 创建音频会话
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.record)
            try session.setMode(AVAudioSession.Mode.measurement)
            //激活Session
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            print("Throws：\(error)")
        }
        
        //3. 创建识别请求
        recordRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        //开始识别获取文字
        recordTask = recognizer.recognitionTask(with: recordRequest!, resultHandler: { (result, error) in
            if result != nil {
                var text = ""
                for trans in result!.transcriptions{
                    text += trans.formattedString
                }
                self.textView.text = text
                
                if result!.isFinal{
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recordRequest = nil
                    self.recordTask = nil
                    self.recordBtn.isEnabled = true
                }
            }
        })
        let recordFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFormat, block: { (buffer, time) in
            self.recordRequest?.append(buffer)
        })
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Throws：\(error)")
        }
    }
    
    //停止识别
    fileprivate func stopRecognize(){
        if recordTask != nil{
            recordTask?.cancel()
            recordTask = nil
        }
        removeTask()
    }
    
    //销毁录音任务
    fileprivate func removeTask(){
        self.audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        self.recordRequest = nil
        self.recordTask = nil
        self.recordBtn.isEnabled = true
    }
    
    ///语音识别权限认证
    fileprivate func addSpeechRecordLimit(){
        SFSpeechRecognizer.requestAuthorization { (state) in
            var isEnable = false
            switch state {
            case .authorized:
                isEnable = true
                print("已授权语音识别")
            case .notDetermined:
                isEnable = false
                print("没有授权语音识别")
            case .denied:
                isEnable = false
                print("用户已拒绝访问语音识别")
            case .restricted:
                isEnable = false
                print("不能在该设备上进行语音识别")
            }
            DispatchQueue.main.async {
                self.recordBtn.isEnabled = isEnable
                self.recordBtn.backgroundColor = isEnable ? UIColor(red: 255/255.0, green: 64/255.0, blue: 64/255.0, alpha: 1) : UIColor.lightGray
            }
        }
    }
}

extension OrderDetailController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        recordBtn.isUserInteractionEnabled = available
    }
}
