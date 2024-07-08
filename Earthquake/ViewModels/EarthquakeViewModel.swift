//Add your imports here
import Foundation
import RxSwift
import RxCocoa

class EarthquakeViewModel {
    //declare variables here
    let earthquakes = BehaviorRelay<[Earthquake]>(value: [])
    let errorMessage = PublishRelay<String?>()
    
    private let earthquakeService = EarthquakeService()
    private let disposeBag = DisposeBag()
    
    // Fetch earthquakes from service
    func fetchEarthquakes() {
        earthquakeService.fetchEarthquakes()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] earthquakes in
                // Update earthquakes observable with fetched data
                self?.earthquakes.accept(earthquakes)
            }, onError: { [weak self] error in
                // Publish error messages if fetching fails
                self?.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

