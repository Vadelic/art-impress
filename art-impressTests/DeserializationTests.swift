//
//  User.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 07.02.2025.
//


import XCTest
@testable import art_impress
struct User: Codable {
    let name: String
    let age: Int
}

class DeserializationTests: XCTestCase {
    func loadFromFile(_ fileName:String) throws-> Data? {
        // Загружаем JSON файл из ресурсов проекта
        guard let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            XCTFail("Не удалось найти файл 'user.json'")
            return nil
        }
        
        do {
           return try Data(contentsOf: URL(fileURLWithPath: filePath))
        } catch {
            XCTFail("Ошибка при чтении файла: \(error)")
            return nil
        }
    }
    
    func testCharacteristicResponseDeserialization() throws {
        let jsonData = try? loadFromFile("characteristics")
        // Десериализуем данные из файла в объект User
        let decoder = JSONDecoder()
        let response = try? decoder.decode(CharacteristicResponse.self, from: jsonData!)
        
        // Проверяем, что десериализация прошла успешно
        XCTAssertNotNil(response, "Десериализация завершилась неудачно")
        print(response!)
        // Проверяем значения свойств
        if let response = response {
            XCTAssertEqual(response.characteristics.count, 4)
            
        }
    }
    
    func testValueeDeserialization() throws {
        let jsonData = try? loadFromFile("value")
        // Десериализуем данные из файла в объект User
        let decoder = JSONDecoder()
        let response = try? decoder.decode(ValueNode.self, from: jsonData!)
     
        // Проверяем, что десериализация прошла успешно
        XCTAssertNotNil(response, "Десериализация завершилась неудачно")
        print(response!)
        // Проверяем значения свойств
        if let response = response {
            XCTAssertEqual(response.nodeType, .value)
            
        }
    }
    
    func testValueIntDeserialization() throws {
        let jsonData = try? loadFromFile("value-int")
        // Десериализуем данные из файла в объект User
        let decoder = JSONDecoder()
        let response = try? decoder.decode(ValueNode.self, from: jsonData!)
     
        // Проверяем, что десериализация прошла успешно
        XCTAssertNotNil(response, "Десериализация завершилась неудачно")
//        print(response!)
        // Проверяем значения свойств
        if let response = response {
            XCTAssertEqual(response.nodeType, .value)
            
        }
    }
    
    func testMultiDeserialization() throws {
        let jsonData = try? loadFromFile("multi")
        // Десериализуем данные из файла в объект User
        let decoder = JSONDecoder()
        let response = try? decoder.decode(MultiSelectNode.self, from: jsonData!)
     
        // Проверяем, что десериализация прошла успешно
        XCTAssertNotNil(response, "Десериализация завершилась неудачно")
        print(response!)
        // Проверяем значения свойств
        if let response = response {
            XCTAssertEqual(response.nodeType, .multi)
            
        }
    }
    
    func testNodeDeserialization() throws {
        let jsonData = try? loadFromFile("node")
        // Десериализуем данные из файла в объект User
        let decoder = JSONDecoder()
        let response = try? decoder.decode(ChainNode.self, from: jsonData!)
     
        // Проверяем, что десериализация прошла успешно
        XCTAssertNotNil(response, "Десериализация завершилась неудачно")
        print(response!)
        // Проверяем значения свойств
        if let response = response {
            XCTAssertEqual(response.nodeType, .chain)
            
        }
    }
}
