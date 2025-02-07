//
//  ImageTagScreenViewModel.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 05.02.2025.
//

import Foundation
import Combine


class TagViewModel: ObservableObject {
    @Published var imageTags: ImageTags?
    @Published var simpleTags: [String]?
    
    func fetchImageTags() {
//        imageTags = MockStore.tags
        ArtRemoteService.shared.fetchImageTags()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Ошибка получения данных: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { tags in
                self.imageTags = tags
            })
            .store(in: &cancellables)
    }
    
    private var cancellables: Set<AnyCancellable> = []
}
