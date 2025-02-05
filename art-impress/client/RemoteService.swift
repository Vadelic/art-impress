//
//  RemoteService.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 03.02.2025.
//


import Foundation
import Combine

class RemoteService {
    private var host =  "http://144.21.37.189:35035"
    static let shared = RemoteService()
    
    private init() {}
    
    func fetchImageTags() -> AnyPublisher<ImageTags, Error> {
        guard let url = URL(string: host+"/v1/tags/available") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ImageTags.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func uploadImage() -> AnyPublisher<ImageTags, Error> {
        guard let url = URL(string: host+"/v1/tags/available") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ImageTags.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class ImageTagScreenViewModel: ObservableObject {
    @Published var imageTags: ImageTags?
    @Published var simpleTags: [String]?
    
    func fetchImageTags() {
        imageTags = MockStore.tags
//        RemoteService.shared.fetchImageTags()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Ошибка получения данных: \(error)")
//                case .finished:
//                    break
//                }
//            }, receiveValue: { tags in
//                self.imageTags = tags
//            })
//            .store(in: &cancellables)
    }
    
    private var cancellables: Set<AnyCancellable> = []
}
