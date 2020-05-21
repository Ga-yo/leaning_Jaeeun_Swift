//
//  ViewController.swift
//  Custom_button
//
//  Created by 이가영 on 2020/05/20.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        btn.setTitle("커스텀 코드", for: .normal)
        
        self.view.addSubview(btn)
    }

}

