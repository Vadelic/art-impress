//
//  NetworkError.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 07.02.2025.
//


//
//  ClientArt.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 24.01.2025.
//

import Foundation
import FirebaseAuth
import SwiftUICore
private var host =  "http://144.21.37.189:35035"
//private var host =  "http:/localhost:8080"
var mock = true
func requestLogin( email:String,  pass:String) async throws ->User?{

    let url = URL(string: host + "/art/auth/login")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let body: [String: String] = ["email": email, "password": pass]
    
    let jsonBody = try JSONSerialization.data(withJSONObject: body, options: [])
    request.httpBody = jsonBody
    
    let (_, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        print( "Ошибка при отправке данных. Пожалуйста, попробуйте позже.")
        return nil
    }
    
    print("Данные успешно отправлены!")
    return nil
}


func uploadImage(imageData: Data, request: UploadImageRequest, completionHandler: @escaping (Result<Image, Error>) -> Void) {
    // Создание JSON-данных для тела запроса
    guard let jsonData = try? JSONEncoder().encode(request) else {
        completionHandler(.failure(EncodingError.invalidRequest))
        return
    }
    
    
    let url = URL(string: host + "/v1/images/upload")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // Установка Content-Type для multipart/form-data
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    // Формирование multipart-тела запроса
    var body = Data()
    
    // Добавление файла
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n".data(using: .utf8)!)
    
    // Добавление JSON-данных
    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"request\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
    body.append(jsonData)
    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    request.httpBody = body
    
    // Выполнение запроса
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let error = error {
            completionHandler(.failure(error))
            print(error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {return}
        print(httpResponse)
        
        if !(200...299).contains(httpResponse.statusCode){
            completionHandler(.failure(NetworkError.badResponse))
            return
        }
        
        //        do {
        //            let decodedResponse = try JSONDecoder().decode(Image.self, from: data)
        //            completionHandler(.success(decodedResponse))
        //        } catch {
        //            completionHandler(.failure(DecodingError.failedToDecode))
        //        }
        
    }.resume()
}

enum NetworkError: Error {
    case badResponse
}

enum EncodingError: Error {
    case invalidRequest
}

enum DecodingError: Error {
    case failedToDecode
}