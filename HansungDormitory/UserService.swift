//
//  UserService.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/18/24.
//

import Foundation
class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func fetchUserInfo(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "http://3.145.59.24:3000/student/me") else { return }
        
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            let error = NSError(domain: "No token", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    let error = NSError(domain: "Parsing error", code: -1, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Failed to fetch user info", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
}
