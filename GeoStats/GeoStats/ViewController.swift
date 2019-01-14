//
//  ViewController.swift
//  GeoStats
//
//  Created by Victor Hawley Jr. on 1/13/19.
//  Copyright © 2019 Victor Hawley Jr. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeValueLabel: UILabel!
    @IBOutlet weak var longitudeValueLabel: UILabel!
    @IBOutlet weak var altitudeValueLabel: UILabel!
    @IBOutlet weak var floorValueLabel: UILabel!
    @IBOutlet weak var hAccuracyValueLabel: UILabel!
    @IBOutlet weak var vAccuracyValueLabel: UILabel!
    @IBOutlet weak var timestampValueLabel: UILabel!
    @IBOutlet weak var speed1ValueLabel: UILabel!
    @IBOutlet weak var speed2ValueLabel: UILabel!
    @IBOutlet weak var directionValueLabel: UILabel!
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
        case .notDetermined:
                manager.requestAlwaysAuthorization()
            default:
                break
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorized")
            manager.startUpdatingLocation()
        default:
            print("not authorized")
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        for loc in locations {
            print(loc)

            latitudeValueLabel.text = "\(String(format: "%.1f", loc.coordinate.latitude))°"
            longitudeValueLabel.text = "\(String(format: "%.1f", loc.coordinate.longitude))°"
            
            if loc.verticalAccuracy < 0 { // vAccuracy >= 0 means altitude is valid
                altitudeValueLabel.text = ""
            } else {
                altitudeValueLabel.text = "\(String(format: "%.1f", loc.altitude * 3.28084)) ft (\(String(format: "%.1f", loc.altitude)) m)"
            }
            
            if let f = loc.floor {
                floorValueLabel.text = "\(f.level)"
            } else {
                floorValueLabel.text = ""
            }
            hAccuracyValueLabel.text = "±\(String(format: "%.1f", loc.horizontalAccuracy * 3.28084)) ft (\(String(format: "%.1f", loc.horizontalAccuracy)) m)"
            
            if loc.verticalAccuracy < 0 {
                vAccuracyValueLabel.text = "\(loc.verticalAccuracy)"
            } else {
                vAccuracyValueLabel.text = "±\(String(format: "%.1f", loc.verticalAccuracy * 3.28084)) ft (\(String(format: "%.1f", loc.verticalAccuracy)) m)"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .long
            timestampValueLabel.text = dateFormatter.string(from: loc.timestamp)
            timestampValueLabel.adjustsFontSizeToFitWidth = true
            
            if loc.speed < 0 {
                speed1ValueLabel.text = ""
                speed2ValueLabel.text = ""
            } else {
                speed1ValueLabel.text = "\(String(format: "%.1f", loc.speed * 2.2369362912)) mph"
                speed2ValueLabel.text = "\(String(format: "%.1f", loc.speed)) m/s"
            }
            
            if loc.course < 0 {
                directionValueLabel.text = ""
            } else {
                directionValueLabel.text = "\(String(format: "%.1f", loc.course))°"
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
    }
}

