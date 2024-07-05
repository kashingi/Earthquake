

import Foundation
import RxSwift

class EarthquakeService {
    private let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    func fetchEarthquakes() -> Observable<[Earthquake]> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: self.url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(EarthquakeResponse.self, from: data)
                        let earthquakes = response.features.map { feature in
                            Earthquake(
                                place: feature.properties.place,
                                magnitude: feature.properties.mag,
                                latitude: feature.geometry.coordinates[1],
                                longitude: feature.geometry.coordinates[0]
                            )
                        }
                        observer.onNext(earthquakes)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

