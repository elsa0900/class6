//
//  ViewController.swift
//  class6
//
//  Created by 劉美君 on 2024/4/15.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var warningMsg: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var returnBtn: UIButton!
    @IBOutlet weak var playSoundBtn: UIButton!
    
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.layer.borderWidth = 2
        resultLabel.layer.borderColor = CGColor(red: 20, green: 97, blue: 117, alpha: 0.5)
        resultLabel.backgroundColor = UIColor(red: 20/255, green: 97/255, blue: 117/255, alpha:1)
        resultLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//       起始藏於畫面
        resultLabel.isHidden = true
        returnBtn.isHidden = true
        playSoundBtn.isHidden = true
    }

//送出結果
    @IBAction func submitInputText(_ sender: Any) {
        let keywords = ["我","兔子","鑰匙","橋"]
        let resultText = inputTextView.text ?? ""
        let resultTextString = String(resultText)
        var containsKeyword = true
        for keyword in keywords {
            if !resultTextString.contains(keyword) {
                containsKeyword = false
                break
            }
        }
        
        let finalResultText = resultText.replacingOccurrences(of: "兔子", with: "愛人")
                                 .replacingOccurrences(of: "鑰匙", with: "金錢")
                                 .replacingOccurrences(of: "橋", with: "人生旅途")
        
        if resultText == "" {
            warningMsg.text = "請輸入！"
        }else if !containsKeyword {
            warningMsg.text = "檢查輸入是否包含我、兔子、鑰匙、橋"
        }
        else{
            inputTextView.isHidden = true
            submitBtn.isHidden = true
            resultLabel.isHidden = false
            returnBtn.isHidden = false
            playSoundBtn.isHidden = false
            resultLabel.text = finalResultText
        }
        
    }
    
//返回輸入框
    @IBAction func returnInputText(_ sender: Any) {
        inputTextView.isHidden = false
        submitBtn.isHidden = false
        resultLabel.isHidden = true
        returnBtn.isHidden = true
        playSoundBtn.isHidden = true
    }
  

    @IBAction func speakResultText(_ sender: Any) {
        let resultText = resultLabel.text ?? ""
        let utterance = AVSpeechUtterance(string: resultText )
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        synthesizer.speak(utterance)
    }
    
}

