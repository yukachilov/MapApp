//
//  ViewController.swift
//  MyMap
//
//  Created by 安部学 on 2020/02/19.
//  Copyright © 2020 Manabu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inputText.delegate = self
        
    }

    @IBOutlet weak var inputText: UITextField!
   
    
    @IBOutlet weak var disMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if let searchKey = textField.text {
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks,errpr) in
                
                if let unwrapPlacemarks = placemarks {
                    
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        if let location = firstPlacemark.location {
                            
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoordinate
                            
                            pin.title = searchKey
                            
                            self.disMap.addAnnotation(pin)
                            
                            self.disMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                            
                            
                            
                        }
                    }
                }
                
                
            })
            
        }
        return true
    }
    
    
    
    @IBAction func changeMapButton(_ sender: Any) {
        if disMap.mapType == .standard {
            disMap.mapType = .satellite
        } else if disMap.mapType == .satellite {
            disMap.mapType = .hybrid
        } else if disMap.mapType == .hybrid {
            disMap.mapType = .satelliteFlyover
        } else if disMap.mapType == .satelliteFlyover {
            disMap.mapType = .hybridFlyover
        } else if disMap.mapType == .hybridFlyover {
            disMap.mapType = .mutedStandard
        } else {
            disMap.mapType = .standard
        }
        
    }
    
}

