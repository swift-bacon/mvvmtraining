//
//  PeopleViewModel.swift
//  mvvmtraining
//
//  Created by Unit27 on 07/08/2025.
//

import Foundation

protocol PeopleViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}

class PeopleViewModel {
    
    private(set) var people = [PersonResponse]()
    
    weak var delegate: PeopleViewModelDelegate?
    
    @MainActor
    func getUsers() {
        Task { [weak self] in
            do {
                var request = URLRequest(url: URL(string: "https://reqres.in/api/users")!)
                request.httpMethod = "GET"
                request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")

                let (data, _) = try await URLSession.shared.data(for: request)

                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                self?.people = try jsonDecoder.decode(UsersResponse.self, from: data).data
                self?.delegate?.didFinish()
            } catch {
                self?.delegate?.didFail(error: error)
            }
        }
    }
    
}
