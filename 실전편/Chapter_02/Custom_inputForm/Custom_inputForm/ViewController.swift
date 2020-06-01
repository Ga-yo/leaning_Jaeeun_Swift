//
//  ViewController.swift
//  Custom_inputForm
//
//  Created by 이가영 on 2020/05/31.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var paramEmail: UITextField!
    var paramUpdate: UISwitch!
    var paramInterval: UIStepper!
    var textUpdate: UILabel!
    var textInterval: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "설정"
        
        let lblEmail = UILabel()
        
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblEmail)
        
        let lblUpdate = UILabel()
        
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblUpdate)
        
        let lblInterval = UILabel()
        
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblInterval)
        
        self.paramEmail = UITextField()
        
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        self.paramEmail.placeholder = "예) 1234@naver.com"
        self.paramEmail.autocapitalizationType = .none
        self.view.addSubview(paramEmail)
        
        self.paramUpdate = UISwitch()
        
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        self.paramUpdate.setOn(true, animated: true)
        
        self.view.addSubview(paramUpdate)
        
        self.paramInterval = UIStepper()
        
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0 //스테퍼가 가질 수 있는 최소값
        self.paramInterval.maximumValue = 100 //스테퍼가 가질 수 있는 최대값
        self.paramInterval.stepValue = 1 //스테퍼의 값 변경 단위
        self.paramInterval.value = 0 //초기값
        
        self.view.addSubview(self.paramInterval)
        
        self.textUpdate = UILabel()
        
        self.textUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.textUpdate.font = UIFont.systemFont(ofSize: 12)
        self.textUpdate.textColor = UIColor.red
        self.textUpdate.text = "갱신함"
        
        self.view.addSubview(textUpdate)
        
        self.textInterval = UILabel()
        
        self.textInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.textInterval.font = UIFont.systemFont(ofSize: 12)
        self.textInterval.textColor = UIColor.red
        self.textInterval.text = "0분마다"
        
        self.view.addSubview(self.textInterval)
        
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        
        self.navigationItem.rightBarButtonItem = submitBtn
    }

    @objc func presentUpdateValue(_ sender: UISwitch){
        self.textUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }

    @objc func presentIntervalValue(_ sender: UIStepper){
        self.textInterval.text = ("\(Int(sender.value))분마다")
    }
    
    @objc func submit(_ sender: Any){
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}

