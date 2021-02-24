//
//  spotYourLocationVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/1/21.
//

import UIKit
import GoogleMaps

class spotYourLocationVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomPopupView: bottomPopupView!
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var userLocationBtn: UIButton!
    @IBOutlet weak var userPositionOnMap: basicTextView!
    
    var guestFlag: Bool = false
    let region : Double = 1000
    var previousLocation : CLLocation?
    var locationManager = CLLocationManager()
    var cameraIsOnUserLocation = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
        cameraIsOnUserLocation = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUpFrontViews()
        mapView.delegate = self
        locationManager.distanceFilter = 100
        locationManager.delegate = self
        //locationManager.requestAlwaysAuthorization()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
            
    }
    
    func settingUpFrontViews(){
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/3.7))
        self.view.bringSubviewToFront(pinImage)
        self.view.bringSubviewToFront(bottomPopupView)
        userLocationBtn.layer.cornerRadius = userLocationBtn.frame.size.height/2
        self.view.bringSubviewToFront(userLocationBtn)
    }
    
    func getCenterlocation(mapView: GMSMapView) -> CLLocation{
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func checkLocationAuthorization(){
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTrackingUserLocation(){
        //locationManager.startUpdatingLocation()
        let location = locationManager.location
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        cameraIsOnUserLocation = true
        self.mapView?.animate(to: camera)
        previousLocation = getCenterlocation(mapView: mapView)
    }
    
    @IBAction func userLocationBtnPressed(_ sender: Any) {
        startTrackingUserLocation()
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if guestFlag == false {
            if #available(iOS 13.0, *) {
                let addAddressView : addAddressVC = self.storyboard?.instantiateViewController(identifier: "AAVC") as! addAddressVC
                addAddressView.userLocationOnMap = userPositionOnMap.text
                let coordinates = getCenterlocation(mapView: mapView)
                addAddressView.latitude = coordinates.coordinate.latitude
                addAddressView.longitude = coordinates.coordinate.longitude
                self.navigationController?.pushViewController(addAddressView, animated: true)
            } else {
                let addAddressView : addAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AAVC") as! addAddressVC
                addAddressView.userLocationOnMap = userPositionOnMap.text
                let coordinates = getCenterlocation(mapView: mapView)
                addAddressView.latitude = coordinates.coordinate.latitude
                addAddressView.longitude = coordinates.coordinate.longitude
                self.navigationController?.pushViewController(addAddressView, animated: true)
            }
        }else{
            performSegue(withIdentifier: "GLGN", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GLGN"{
            let homeTabBar = segue.destination as! UITabBarController
            let laundriesNav = homeTabBar.viewControllers?.first as! UINavigationController
            let laundriesVC = laundriesNav.viewControllers.first as! laundriesVC
            let coordinates = getCenterlocation(mapView: mapView)
            laundriesVC.guestFlag = true
            laundriesVC.latitude = "\(coordinates.coordinate.latitude)"
            laundriesVC.longitude = "\(coordinates.coordinate.longitude)"
            
        }
    }

}

extension spotYourLocationVC: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//
//        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
//
//        self.mapView?.animate(to: camera)
//        self.locationManager.stopUpdatingLocation()
        
    }
}

extension spotYourLocationVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let centerLocation = getCenterlocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        
        guard  let previousLocation = self.previousLocation else {return}
        
        guard centerLocation.distance(from: previousLocation) > 50 else{return}
        self.previousLocation = centerLocation
        if self.cameraIsOnUserLocation == true {
            geoCoder.reverseGeocodeLocation(centerLocation) { [weak self] (placemarks, error) in
                guard let self = self else {return}

                if let error = error{
                    debugPrint(error.localizedDescription)
                }

                guard let placemark = placemarks?.first else {return}
                let country = placemark.country ?? ""
                let streetNumber = placemark.subThoroughfare ?? ""
                let streetName = placemark.thoroughfare ?? ""
                let province = placemark.subLocality ?? ""
                let city = placemark.locality ?? ""
                
                DispatchQueue.main.async {
                        if streetNumber == ""{
                            self.userPositionOnMap.text = "\(streetName), \(province), \(city), \(country)"
                        }else if streetName == ""{
                            self.userPositionOnMap.text = "\(streetNumber), \(province), \(city), \(country)"
                        }else if province == ""{
                            self.userPositionOnMap.text = "\(streetNumber), \(streetName),  \(city), \(country)"
                        }else if city == ""{
                            self.userPositionOnMap.text = "\(streetNumber), \(streetName), \(province), \(country)"
                        }else if country == ""{
                            self.userPositionOnMap.text = "\(streetNumber), \(streetName), \(province), \(city)"
                        }
                }
            }
        }
    }
}
