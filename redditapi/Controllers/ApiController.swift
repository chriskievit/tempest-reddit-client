//
//  ApiController.swift
//  tempestclient
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case serverError
    case urlFormatError
    case parameterEncodingError
    case responseDecodingError
    case noDataError
}

protocol ApiController {
}

extension ApiController {
    static func performGetRequest<T: Decodable>(url: String, result: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url) else {
            result(.failure(.urlFormatError))
            return
        }
        
        performRequest(request: createRequest(url: url, method: "GET"), result: result)
    }
    
    static func performPostRequest<Tresult: Decodable, Tparam: Encodable>(url: String, data: Tparam, result: @escaping (Result<Tresult, RequestError>) -> Void) {
        guard let url = URL(string: url) else {
            result(.failure(.urlFormatError))
            return
        }
        
        guard let jsonData = encode(data: data) else {
            result(.failure(.parameterEncodingError))
            return
        }
        
        performRequest(request: createRequest(url: url, method: "POST", parameters: jsonData), result: result)
    }
    
    static func performFormPostRequest<Tresult: Decodable>(url: String, data: [String: String], additionalHeaders: [String: String]?, result: @escaping (Result<Tresult, RequestError>) -> Void) {
        guard let url = URL(string: url) else {
            result(.failure(.urlFormatError))
            return
        }
        
        let parsedData = parseFormData(formData: data)
        let postData: Data = parsedData.data(using: String.Encoding.utf8)!
        
        var request = createRequest(url: url, method: "POST", parameters: postData, contentType: "application/x-www-form-urlencoded")
        
        additionalHeaders?.forEach { (header, value) in
            if header != "Content-Type" {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }
        
        performRequest(request: request, result: result)
    }
    
    private static func performRequest<T: Decodable>(request: URLRequest, result: @escaping (Result<T, RequestError>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                result(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                result(.failure(.noDataError))
                return
            }
            
            let dataString = String(data: data, encoding: .utf8)
            guard let decodedResponse: T = self.decode(jsonString: dataString!) else {
                result(.failure(.responseDecodingError))
                return
            }
            
            result(.success(decodedResponse))
        }.resume()
    }
    
    private static func createRequest(url: URL, method: String, parameters: Data? = nil, contentType: String = "application/json") -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let parameters = parameters {
            request.httpBody = parameters
        }
        
        // Set default headers
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if ApplicationContext.shared.session.isAuthenticated() {
            request.addValue("bearer \(ApplicationContext.shared.session.getAuthToken()!.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private static func parseFormData(formData: [String: String]) -> String {
        var pairs: [String] = [String]()
        formData.forEach { (key, value) in
            pairs.append(String(format: "%@=%@", key, value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
        }
        
        return pairs.joined(separator: "&")
    }
    
    private static func encode<T: Encodable>(data: T) -> Data? {
        return try? JSONEncoder().encode(data)
    }
    
    private static func decode<T: Decodable>(jsonString: String) -> T? {
        guard !jsonString.isEmpty else {
            return nil
        }
        
        let jsonData: Data? = jsonString.data(using: .utf8)
        
        guard let data = jsonData else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            return nil
        }
    }
}
