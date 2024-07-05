
//imports
import UIKit
import RxSwift
import RxCocoa
import MapKit

class EarthquakeMapViewController: UIViewController {
    private let viewModel = EarthquakeViewModel()
    private let disposeBag = DisposeBag()
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()//To be implemented
        setupBindings()//To be implemented
        viewModel.fetchEarthquakes()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        // Add mapView
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
        
        // Bind the earthquakes data to update the map
        viewModel.earthquakes
            .subscribe(onNext: { [weak self] earthquakes in
                self?.updateMap(with: earthquakes)
            })
            .disposed(by: disposeBag)
    }

    //function to update the map
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
