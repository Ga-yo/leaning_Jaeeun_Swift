//
//  WebViewController.swift
//  MoveMovie
//
//  Created by 이가영 on 2020/04/29.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var wv: WKWebView!
    var mvo: MovieVO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wv.navigationDelegate = self
        self.wv.uiDelegate = self
        
        let navibar = self.navigationItem
        navibar.title = self.mvo.title
        
        if let url = self.mvo.detail{
            if let urlObj = URL(string: url){
                let req = URLRequest(url: urlObj)
                self.wv.load(req)
            }else{
                let alert = UIAlertController(title: "오류", message: "잘못된 URL입니다", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: { (_) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
            }
            
        }else{
            let alert = UIAlertController(title: "오류", message: "필수 파라미터가 누락되었습니다.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: { (_) in
                _ = self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        }
        
        NSLog("linkurl = \(self.mvo.detail!), title = \(self.mvo.title!)")
        let url = URL(string: (self.mvo.detail)!)
        let req = URLRequest(url: url!)
        
        self.wv.load(req)
        // Do any additional setup after loading the view.
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

extension WebViewController: WKNavigationDelegate, WKUIDelegate{
    
    //웹 뷰가 html 페이즈의 콘텐츠를 읽어 들이기 시작할 때
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
}

extension UIViewController{
    func alert(_ message: String, onClick: (() -> Void)? = nil){
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_) in
            onClick?()
        }))
        DispatchQueue.main.async {
            self.present(controller, animated: false)
        }
    }
}
