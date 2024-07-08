

import Foundation
import RxSwift

class EarthquakeService {
    private let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    // Fetch earthquakes data from API
    func fetchEarthquakes() -> Observable<[Earthquake]> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: self.url) { data, response, error in
                if let error = error {
                    // Handle networking errors
                    observer.onError(error)
                } else if let data = data {
                    do {
                        // Decode JSON response into EarthquakeResponse
                        let response = try JSONDecoder().decode(EarthquakeResponse.self, from: data)
                        // Map features to Earthquake objects
                        let earthquakes = response.features.map { feature in
                            Earthquake(
                                place: feature.properties.place,
                                magnitude: feature.properties.mag,
                                latitude: feature.geometry.coordinates[1],
                                longitude: feature.geometry.coordinates[0]
                            )
                        }
                        // Emit earthquakes to observer
                        observer.onNext(earthquakes)
                        observer.onCompleted()
                    } catch {
                        // Handle JSON decoding errors
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

