//
//  RedditApiController.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

enum RequestResult: Error {
    case ServerError
    case UserError
}

protocol ApiController {
}

extension ApiController {
    func performGetRequest(url: String, result: (Result<Array<String>, RequestResult>) -> Void) {
        if !url.isEmpty {
            result(.success(["Result was successful"]))
        } else {
            result(.failure(RequestResult.ServerError))
        }
    }
    
    func decode<T: Decodable>(jsonString: String) -> T? {
        guard !jsonString.isEmpty else {
            return nil
        }
        
        let jsonData: Data? = jsonString.data(using: .utf8)
        
        guard let data = jsonData else {
            return nil
        }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

class RedditApiController: ApiController {
    func getTheThing() {
        performGetRequest(url: "loginUrl") { (result) in
            switch result {
            case .success(let response):
                print(response)
                break
            case .failure(_):
                print("There was an error")
                break
            }
        }
    }
}
