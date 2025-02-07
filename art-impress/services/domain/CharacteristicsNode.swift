//
//  ChainNode 2.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 06.02.2025.
//

// Основная структура ChainNode

import Foundation
enum NodeType:Decodable{
    case chain
    case multi
    case value
   
    init?(rawValue: String) {
           switch rawValue {
           case "chain":
               self = .chain
           case "multi":
               self = .multi
           case "value":
               self = .value
           default:
               return nil
           }
       }

    init(from decoder: Decoder) throws {
          let container = try decoder.singleValueContainer()
          let rawValue = try container.decode(String.self)
          self = NodeType(rawValue: rawValue)!
      }

    
}

protocol CharacteristicsNode:Decodable{
    var  description: String {get}
    var nodeType: NodeType {get}
  
}

struct ChainNode :CharacteristicsNode,Decodable{
    var nodeType: NodeType
    
    let description: String
    let children: [ChainNode]?
    var selected: Bool = false
   
    // Ключи для декодирования
       private enum CodingKeys: String, CodingKey {
           case description, children, selected, nodeType
       }
       
       // Метод для декодирования
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           description = try container.decode(String.self, forKey: .description)
           children = try container.decodeIfPresent([ChainNode].self, forKey: .children)
           selected = try container.decode(Bool.self, forKey: .selected)
           nodeType = try container.decode(NodeType.self, forKey: .nodeType)
       }

    
    init(_ description: String, _ children: [ChainNode]) {
        self.description = description
        self.children = children
        self.nodeType = .chain
    }
    init(_ description: String) {
        self.nodeType = .chain
        self.description = description
        self.children = nil
    }
}

struct MultiSelectNode :CharacteristicsNode,Decodable{
    var nodeType: NodeType
    let description: String
    let list: [SelectableNode]
    
    init(_ description: String, _ list: [SelectableNode]) {
        self.description = description
        self.list = list
        self.nodeType = .multi }
    
    // Ключи для декодирования
        private enum CodingKeys: String, CodingKey {
            case description, list,nodeType
        }
        
        // Метод для декодирования
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            description = try container.decode(String.self, forKey: .description)
            list = try container.decode([SelectableNode].self, forKey: .list)
            nodeType = try container.decode(NodeType.self, forKey: .nodeType)
        }
}

struct SelectableNode:Decodable {
    let value: String
    var selected: Bool = false
    
    init( value: String) {
        self.value = value
    }
}

struct ValueNode: CharacteristicsNode,Decodable{
    var nodeType: NodeType
    let type: String
    let description: String
    let value: String
    let valueMax: String?
 
    // Ключи для декодирования
      private enum CodingKeys: String, CodingKey {
          case type, description, value, valueMax,nodeType
      }
      
      // Метод для декодирования
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(String.self, forKey: .type)
        description = try container.decode(String.self, forKey: .description)
        value = try container.decode(String.self, forKey: .value)
        valueMax = try container.decodeIfPresent(String.self, forKey: .valueMax)
        nodeType = try container.decode(NodeType.self, forKey: .nodeType)
    }

    
    init(_ description: String,_ valueMin: Int,_ valueMax: Int) {
        self.description = description
        self.value = String(valueMin)
        self.valueMax = String(valueMax)
        self.type = "INTEGER"
        self.nodeType = .value  }
    init(_ description: String,_ value: String) {
        self.description = description
        self.value = String(value)
        self.valueMax = nil
        self.type = "STRING"
        self.nodeType = .value  }
}

