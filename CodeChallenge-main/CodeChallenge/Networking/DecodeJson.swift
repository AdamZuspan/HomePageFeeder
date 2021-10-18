//
//  DecodeJson.swift
//  CodeChallenge
//
//  Created by Adam Zuspan on 10/18/21.
//

import Foundation

protocol DecodeJson {
    func decodeObject<T:Decodable>(input:Data, type:T.Type)-> T?
    func decodeArray<T:Decodable>(input:Data, type:T.Type)-> [T]?
}

extension DecodeJson {
    func decodeObject<T:Decodable>(input:Data, type:T.Type)-> T? {
        return try? JSONDecoder().decode(T.self, from: input)
    }
    func decodeArray<T:Decodable>(input:Data, type:T.Type)-> [T]? {
        return try? JSONDecoder().decode([T].self, from: input)
    }
}
