//
//  NetworkService.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import Foundation

final class NetworkService {
    
    //MARK: - Properties
    static let shared = NetworkService()
    
    private let companyListURL = "https://us-central1-fbconfig-90755.cloudfunctions.net/getAllCompanies"
    
    
    //MARK: - Init
    private init() {}
    
    
    //MARK: - Helpers
    
    func getCompanyData(completion: @escaping (Result<[CompanyResponse], NetworkError>) -> ()) {
        //  unwrap url
        guard let url = URL(string: companyListURL) else {
            completion(.failure(.invalidURL))
            return
        }
        //  url session to fetch data
        URLSession.shared.dataTask(with: url) { companyData, response, error in
            guard let companyData = companyData, error == nil else {
                print("DEBUG: Error Fetching Data: \(error?.localizedDescription ?? "Check getCompanyData()")")
                completion(.failure(.dataFetchFailed))
                return
            }
            //  convert data
            do {
                let companyData = try JSONDecoder().decode([CompanyResponse].self, from: companyData)
                completion(.success(companyData))
            } catch let error {
                print("DEBUG: Error Decoding Company Data: \(error.localizedDescription)")
                completion(.failure(.decodeError))
            }
        }.resume()
    }
    
    
}
