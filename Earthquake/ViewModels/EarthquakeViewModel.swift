

import Foundation
import RxSwift
import RxCocoa

class EarthquakeViewModel {
    let earthquakes = BehaviorRelay<[Earthquake]>(value: [])
    let errorMessage = PublishRelay<String?>()
    
    private let earthquakeService = EarthquakeService()
    private let disposeBag = DisposeBag()
    
    func fetchEarthquakes() {
        earthquakeService.fetchEarthquakes()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] earthquakes in
                self?.earthquakes.accept(earthquakes)
            }, onError: { [weak self] error in
                self?.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

