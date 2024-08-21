//
//  HouseViewModel.swift
//  InterviewTest
//
//  Created by Surendra P on 22/08/24.
//

import Foundation

class HouseViewModel {

    func fetchHouseList(completion: @escaping (Result<[HouseResponse], Error>) -> Void) {
        NetworkManager.shared.fetchHouseList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let houseList):
                    completion(.success(houseList))
                case .failure(let error):
                    // Handle the error (e.g., update UI with an error message)
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
