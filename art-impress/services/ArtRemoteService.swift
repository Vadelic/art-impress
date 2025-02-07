//
//  RemoteService.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 03.02.2025.
//


import Foundation
import Combine

class ArtRemoteService {
//    private var host =  "http://144.21.37.189:35035"
    private var host =  "http:/localhost:8080"
    static let shared = ArtRemoteService()
    
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
    
    func fetchImageProperties() -> AnyPublisher<CharacteristicResponse, Error> {
        guard let url = URL(string: host+"/v1/tags/properties") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CharacteristicResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func uploadImage(imageData: Data, uploadRequest: UploadImageRequest) -> AnyPublisher<Data, URLError> {
    
        // Создание JSON-данных для тела запроса
        guard let jsonData = try? JSONEncoder().encode(uploadRequest) else {
            fatalError("Invalid request")
        }
        
        guard let url = URL(string: host + "/v1/images/upload") else {
            fatalError("Invalid URL")
        }
      
        let boundary = UUID().uuidString
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        // Добавление JSON-данных
        body.append("Content-Disposition: form-data; name=\"request\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        body.append(jsonData)
        
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        // Добавление файла
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
       
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Выполнение запроса
      
      return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()

           
          
    }
}
