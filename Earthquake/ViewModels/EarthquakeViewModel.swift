//
//  EarthquakeViewModel.swift
//  Earthquake
//
//  Created by EMTECH MAC on 20/06/2024.
//


import Foundation
import Combine

class EarthquakeViewModel: ObservableObject {
    @Published var earthquakes: [Earthquake] = []
    @Published var errorMessage: String?

    private let earthquakeService = EarthquakeService()
    private var cancellables = Set<AnyCancellable>()

    func fetchEarthquakes() {
        earthquakeService.fetchEarthquakes()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] earthquakes in
                self?.earthquakes = earthquakes
            })
            .store(in: &cancellables)
    }
}
