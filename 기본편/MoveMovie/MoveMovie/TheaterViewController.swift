//
//  TheaterViewController.swift
//  MoveMovie
//
//  Created by 이가영 on 2020/05/01.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var param: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = self.param["상영관명"] as? String

        //위도와 경도를 추출하여 Double 값으로 캐스팅
        let lat = (param["위도"] as! NSString).doubleValue
        let lng = (param["경도"] as! NSString).doubleValue
        
        //위도와 경도를 인수로 하는 2D 위치 정보 객체 정의
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        //지도에 표현될 거리: 값의 단위는 m
        let regionRadius: CLLocationDistance = 50
        
        //거리를 반영한 지역 정보를 조합한 지도 데이터를 생성
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        //map 변수에 연결된 지도 객체에 데이터를 전달하여 화면에 표시
        self.mapView?.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = location
        self.mapView?.addAnnotation(point)
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
