//
//  MemoFormmVC.swift
//  Mymemory
//
//  Created by 이가영 on 2020/04/21.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class MemoFormmVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate  {

    var subject: String! //제목 저장
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contents.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //저장 버튼
    @IBAction func save(_ sender: Any){
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject//제목
        data.contents = self.contents.text //내용
        data.image = self.preview.image //이미지
        data.regdate = Date() //작성시각
        
        //Appdelegate 객체를 일겅온 다음, memolist 배열에 memoData를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //카메라 버튼
    @IBAction func pick(_ sender: Any){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true //이미지 편집 허용
        
        self.present(picker, animated: true)
    }
    
    //이미지 선택 완료시
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        picker.dismiss(animated: false)
        
    }

    //문자가 바꼈을 때
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString //일부내용을 추출하기 위해선 NSString 필요(substring(with))
        let length = ( (contents.length > 15 ) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
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
