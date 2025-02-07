//
//  CharacteristicResponse.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 07.02.2025.
//

import Foundation


struct CharacteristicResponse: Decodable{
    let characteristics: [CharacteristicsNode]
    
    init(_  characteristics: [CharacteristicsNode]){
        self.characteristics = characteristics
    }
    
    private enum CodingKeys: String, CodingKey {
        case characteristics
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var characteristicsContainer = try container.nestedUnkeyedContainer(forKey: .characteristics)
        var characteristicsArray: [CharacteristicsNode] = []
        
        
        while !characteristicsContainer.isAtEnd {
            if let animal = try? characteristicsContainer.decode(ChainNode.self) {
                characteristicsArray.append(animal)
            } else if let animal = try? characteristicsContainer.decode(MultiSelectNode.self) {
                characteristicsArray.append(animal)
            } else if let animal = try? characteristicsContainer.decode(ValueNode.self) {
                characteristicsArray.append(animal)
            } else {
                
            }
        }
            self = CharacteristicResponse(characteristicsArray)
    }}
