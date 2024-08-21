//
//  NetworkManager.swift
//  InterviewTest
//
//  Created by Surendra P on 22/08/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://anapioficeandfire.com/"
    
    func fetchHouseList(completion: @escaping (Result<[HouseResponse], Error>) -> Void) {
        let urlString = "\(baseURL)api/houses"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Data"])
                completion(.failure(error))
                return
            }
            
            do {
                let houseResponse = try JSONDecoder().decode([HouseResponse].self, from: data)
                completion(.success(houseResponse))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
