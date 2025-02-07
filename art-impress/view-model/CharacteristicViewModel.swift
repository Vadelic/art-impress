//
//  ImageTagScreenViewModel.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 05.02.2025.
//

import Foundation
import Combine


class CharacteristicViewModel: ObservableObject {
    @Published var characteristics: CharacteristicResponse?
   
    func fetchImageTags() {
//        imageTags = MockStore.characteristics
        ArtRemoteService.shared.fetchImageProperties()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Ошибка получения данных: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { characteristics in
                self.characteristics = characteristics
            })
            .store(in: &cancellables)
    }
    
    private var cancellables: Set<AnyCancellable> = []
}
