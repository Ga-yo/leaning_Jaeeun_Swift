//
//  ViewController.swift
//  Custom_button
//
//  Created by 이가영 on 2020/05/20.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet
    var subject: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.subject = UILabel()
        self.subject.frame = CGRect(x: 50, y: 150, width: 100, height: 30)
        
        self.view.addSubview(subject)
        
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        btn.setTitle("커스텀 코드", for: .normal)
        btn.center = CGPoint(x: self.view.frame.size.width / 2, y: 100) // 센터값 계산
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    //IBA 형식을 코드로
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event)
    {
        //target은 호출할 대상 메소드가 있는 인스턴스를 가리킨다.
        //action은 호출할 메소드를 지정하는 매개변수
        //for은 액션 메소드의 실행 조건을 지정하는 매개변수이다.
        // + Seletor는 오브젝티브-C에서 클래스 메소드의 이름을 가리키는데 사용되는 참조타입으로 @obj 어트리뷰트를 붙여서 오브젝티브-C와의 호환성을 위한 것으로 인식할 수 있게 해준다.
        
    }
    
    @objc func btnOnClick(_ sender: Any){
        if let btn = sender as? UIButton{
            btn.setTitle("클릭 on", for: UIControl.State.normal)
        }
    }
    
    @objc func sayHello(_ sender: Any){
        self.subject.text = "굿바이, IB~"
    }

}

