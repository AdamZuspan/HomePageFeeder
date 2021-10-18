//
//  BaseRepository.swift
//  CodeChallenge
//
//  Created by Adam Zuspan on 10/18/21.
//

import Foundation

typealias Completion<T:Decodable> =  ((Result<T, NetworkError>) -> Void)
typealias CompletionData =  ((Result<Data, NetworkError>) -> Void)

class BaseRepository {
    var networkManager:Networkable
    
    init(networkManager:Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
}


