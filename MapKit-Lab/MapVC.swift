//
//  ViewController.swift
//  MapKit-Lab
//
//  Created by Tsering Lama on 2/24/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class MapVC: UIViewController {
    
    @IBOutlet weak var schoolView: MKMapView!
    
    private let locationSession = CoreLocationSession()
    
    public var highSchools = [SchoolData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchools()
        schoolView.delegate = self
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
            annotation.subtitle = school.city
            let coordinate = CLLocationCoordinate2DMake(Double(school.latitude)!, Double(school.longitude)!)
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        return annotations
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for school in highSchools {
            let str = school.website
            let url = URL(string: str)
            let safariSchool = SFSafariViewController(url: url!)
            present(safariSchool, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {return nil}
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .systemBlue
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}
