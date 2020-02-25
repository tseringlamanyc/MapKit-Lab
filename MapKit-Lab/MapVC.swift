//
//  ViewController.swift
//  MapKit-Lab
//
//  Created by Tsering Lama on 2/24/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var schoolView: MKMapView!
    
    private let locationSession = CoreLocationSession()
    
     var highSchools = [SchoolData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        schoolView.delegate = self
        getSchools()
//        loadMap()
        
    }
    
    private func getSchools() {
        SchoolAPI.getSchools { [weak self] (result) in
            switch result {
            case .failure(_):
                print("no data")
            case .success(let allSchools):
                DispatchQueue.main.async {
                    self?.highSchools = allSchools
                    dump(allSchools)
                }
            }
        }
    }
    
//    private func loadMap() {
//        let annotations = makeAnnotations()
//        schoolView.addAnnotations(annotations)
//    }
//
//    private func makeAnnotations() -> [MKPointAnnotation] {
//        var annotations = [MKPointAnnotation]()
//        for school in highSchools {
//            let annotation = MKPointAnnotation()
//            annotation.title = school.school_name
//            locationSession.placemarkToCoordinate(address: school.location) { (result) in
//                switch result {
//                case .failure(_):
//                    print("no address")
//                case .success(let coordinate):
//                    DispatchQueue.main.async {
//                        annotation.coordinate = coordinate
//                        dump(coordinate)
//                    }
//                }
//            }
//            annotations.append(annotation)
//        }
//        return annotations
//    }
}

//extension MapVC: MKMapViewDelegate {
//
//}

