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
    
    public var highSchools = [SchoolData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchools()
    }
    
    private func getSchools() {
        SchoolAPI.getSchools { (result) in
            switch result {
            case .failure(_):
                print("no data")
            case .success(let allSchools):
                DispatchQueue.main.async {
                    self.highSchools = allSchools
                    self.loadMap()
                }
            }
        }
    }
    
    private func loadMap() {
        let annotations = makeAnnotations()
        schoolView.addAnnotations(annotations)
        schoolView.showAnnotations(annotations, animated: true)
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for school in highSchools {
            let annotation = MKPointAnnotation()
            annotation.title = school.school_name
            let coordinate = CLLocationCoordinate2DMake(Double(school.latitude)!, Double(school.longitude)!)
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        return annotations
    }
}
