//
//  importDog.swift
//  dog_api
//
//  Created by spark-03 on 2024/02/19.
//

import Foundation

struct DogResponse : Codable {
    let message:[String: [String]]
}

struct DogImageResponse : Codable {
    let message:[String]
}

enum dogError : Error {
    case invalidError
    case decodingError
}

class Dog {
    func getBreeds() async -> Result<DogResponse,dogError> {      //クラスの処理の成功失敗を区別するためのResult型
        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all")
        else {
            return .failure(.invalidError)
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let dogResponse = try decoder.decode(DogResponse.self, from: data)
            //print(dogResponse)
            return
                .success(dogResponse)
        }catch{
            return .failure(dogError.decodingError)
        }
    }
}
