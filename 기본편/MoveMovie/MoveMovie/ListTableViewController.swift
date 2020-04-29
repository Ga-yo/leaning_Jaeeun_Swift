//
//  ListTableViewController.swift
//  MoveMovie
//
//  Created by 이가영 on 2020/04/27.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var page = 1
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        
        return datalist
    }()
    
    //MARK: IBOutle, IBAction
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBAction func more(_ sender: Any){
            self.page += 1
            cellMovieAPI()
            self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellMovieAPI()
    }

    // MARK: movie_func
    func cellMovieAPI(){
        
        let url = "http://115.68.183.178:2029/hoppin/movies?order=releasedateasc&count=10&page=\(self.page)&version=1&genreId="
        let apiURL: URL! = URL(string: url)
        
        //REST API 호출
        let apidata = try! Data(contentsOf: apiURL)
        
        //데이터 전송 결과를 로그로 출력(필수 x)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result = \(log)")
        
        do{
            //JSON 객체를 파싱하여 NSDictionary 객체로 받음
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            //데이터구조에 따라 차례대로 캐스팅하며 읽음
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            //Iterator 처리를 하면서 API 데이터를 저장
            for row in movie {
                //순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                //테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                //movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
               
                
                //배열에 추가
                self.list.append(mvo)
                
                //웹상에 있는 이미지를 읽어와 UIImage객체로 생성
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                //totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 숨긴다.
                let totalCount = (hoppin["totalCount"] as? NSString)! .integerValue
                if (self.list.count >= totalCount){
                    self.moreBtn.isHidden = true
                }
            }
        } catch{ }
    }
    
    func getThumbnailImage(_ index: Int) -> UIImage{
        let mvo = self.list[index]
        
        if let savedImage = mvo.thumbnailImage{
            return savedImage
        }else{
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData)
            
            return mvo.thumbnailImage!
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        NSLog("호출된 행 : \(indexPath.row), 제목 : \(row.title)")
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! ListTableViewCell
        
        cell.title?.text = row.title
        cell.subtitle?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
//        let url: URL! = URL(string: row.thumbnail ?? "")
//        let imageData = try! Data(contentsOf: url)
//        cell.thumblenail.image = UIImage(data: imageData)

        //이미지 객체 대입
//        cell.thumblenail.image = row.thumbnailImage
        
        DispatchQueue.main.async {
            cell.thumblenail.image = self.getThumbnailImage(indexPath.row)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



// MARK: Segue
extension ListTableViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //설정된 세그 아이덴티파이가 segue_detail이라면
        if segue.identifier == "segue_detail"{
            
            let cell = sender as! ListTableViewCell
            
            //사용자가 클랙한 행을 나타낸다.
            let path = self.tableView.indexPath(for: cell)
            
            //API 영화 데이터 배열 중에서 선택된 행에 대한 데이터를 추출
            let movieinfo = self.list[path!.row]
            
            //행 정보를 통해 선택된 영화 데이터를 찾고 목적지 뷰 컨트롤러의 mvo 변수에 대입
            let detailVC = segue.destination as? WebViewController
            detailVC?.mvo = movieinfo
        }
    }
}
