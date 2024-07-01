//
//  EarthquakeMapViewController.swift
//  Earthquake
//
//  Created by EMTECH MAC on 01/07/2024.
//
import UIKit
import Combine
import MapKit

class EarthquakeMapViewController: UIViewController {
    private let viewModel = EarthquakeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchEarthquakes()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.$earthquakes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] earthquakes in
                self?.updateMap(with: earthquakes)
            }
            .store(in: &cancellables)
    }

    private func updateMap(with earthquakes: [Earthquake]) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = earthquakes.map { earthquake -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: earthquake.latitude, longitude: earthquake.longitude)
            annotation.title = earthquake.place
            annotation.subtitle = "Magnitude: \(earthquake.magnitude)"
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        
        if let firstAnnotation = annotations.first {
            mapView.setRegion(MKCoordinateRegion(center: firstAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)), animated: true)
        }
    }
}
