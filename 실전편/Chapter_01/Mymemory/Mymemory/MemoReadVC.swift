//
//  MemoReadVC.swift
//  Mymemory
//
//  Created by 이가영 on 2020/04/21.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contents.numberOfLines = 0
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        print(contents!)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
//        let dateString = formatter.string(from: (param?.regdate)!)
//
//        self.navigationItem.title = dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
