//
//  CoreDataManager.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    //MARK: - Properties
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    //MARK: - Init
    private init() {}
    
    
    //MARK: - Helper
    
    //MARK: - Fetch Helper Functions
    
    
    
    /// Fetches all companies from core data
    /// - Returns: Array of company response objects
    func fetchAllCompanys() -> [CDCompanyResponse] {
        do {
            let companys = try context.fetch(CDCompanyResponse.fetchRequest())
            return companys
        } catch let error {
            print("DEBUG: Error getting all companys from Core data: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
    
    
    
    /// Fetches all favourited companies from Core Data
    /// - Returns: Array of company response objects
    func getFavouritedCompanys() -> [CDCompanyResponse] {
        let fetchRequest: NSFetchRequest<CDCompanyResponse> = CDCompanyResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["isFavourited", true])
        do {
            let companys = try context.fetch(fetchRequest)
            return companys
        } catch let error {
            print("DEBUG: Error fetching favourited companies: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
    
    
    
    /// Fetches a Single Company Details Object from Core Data
    /// - Parameter company: Company Object
    /// - Returns: Core Data Company Response Object
    func fetchSingleCompanyDetails(_ company: CompanyResponse) -> CDCompanyResponse? {
        let fetchRequest: NSFetchRequest<CDCompanyResponse> = CDCompanyResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["symbol", company.symbol])
        do {
            return try context.fetch(fetchRequest).first
        } catch let error {
            print("DEBUG: Error Fetching Single Company Detail: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    
    
    
    
    
    /// Returns the company's favourited property
    /// - Parameter company: Company Object
    /// - Returns: isFavourited Bool value
    func getIsFavouritedProperty(_ company: CompanyResponse) -> Bool {
        let companyDetail = fetchSingleCompanyDetails(company)
        if let companyDetail = companyDetail {
            return companyDetail.isFavourited
        } else {
            return false
        }
    }
    
    
    
    
    
    
    /// Fetches & Checks if the company object already exists in Core Data
    /// - Parameter symbol: Company Symbol "identifier"
    /// - Returns: True if exists else False
    func checkIfExists(_ symbol: String) -> Bool {
        let fetchRequest: NSFetchRequest<CDCompanyResponse> = CDCompanyResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["symbol", symbol])
        do {
            if let _ = try context.fetch(fetchRequest).first {
                return true
            } else {
                return false
            }
        } catch let error {
            print("DEBUG: Error checking if Company Exists in core data: \(error.localizedDescription)")
            return false
        }
    }
    
    
    
    
    
    
    //MARK: - Save or Update Helper Functions
    
    
    /// Saves or Updates company object based on whether it already exists
    /// - Parameters:
    ///   - company: Company Response Object
    ///   - isFavourited: Bool - Default is False for new Objects
    ///   - completion: Bool or void
    func saveUpdateCompanyDetails(_ company: CompanyResponse, _ isFavourited: Bool, _ completion: @escaping (Bool) -> ()) {
        if checkIfExists(company.symbol) {
            //  fetch & update company details
            updateCompanyDetails(company, isFavourited, completion)
        } else {
            //  save
            saveCompanyDetails(company, isFavourited, completion)
        }
    }
    
    
    
    
    
    
    
    /// Updates the company object on core data since it already exists
    /// - Parameters:
    ///   - companyResponse: Company Object
    ///   - isFavourited: Bool
    ///   - completion: Bool or Void
    func updateCompanyDetails(_ companyResponse: CompanyResponse, _ isFavourited: Bool, _ completion: @escaping (Bool) -> ()) {
        let fetchRequest: NSFetchRequest<CDCompanyResponse> = CDCompanyResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["symbol", companyResponse.symbol])
        do {
            if let cdCompanyResponse = try context.fetch(fetchRequest).first {
                cdCompanyResponse.symbol        = companyResponse.symbol
                cdCompanyResponse.name          = companyResponse.name
                cdCompanyResponse.raw           = "\(companyResponse.marketCap.raw)"
                cdCompanyResponse.longFmt       = companyResponse.marketCap.longFmt
                cdCompanyResponse.fmt           = companyResponse.marketCap.fmt
                cdCompanyResponse.isFavourited  = isFavourited
                do {
                    try context.save()
                    completion(true)
                } catch let error {
                    print("DEBUG: Error Updating Company Details in core data: \(error.localizedDescription)")
                    completion(false)
                }
            }
        } catch let error {
            print("DEBUG: Error Fetching Company Details from Core Data: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    
    
    
    
    
    /// Saves the company object in core data as it doesn't already exists
    /// - Parameters:
    ///   - companyResponse: Company response object
    ///   - isFavourited: Bool
    ///   - completion: Bool or Void
    func saveCompanyDetails(_ companyResponse: CompanyResponse, _ isFavourited: Bool, _ completion: @escaping (Bool) -> ()) {
        let cdCompanyResponse               = CDCompanyResponse(context: context)
        cdCompanyResponse.name              = companyResponse.name
        cdCompanyResponse.symbol            = companyResponse.symbol
        cdCompanyResponse.isFavourited      = isFavourited
        cdCompanyResponse.raw               = "\(companyResponse.marketCap.raw)"
        cdCompanyResponse.fmt               = companyResponse.marketCap.fmt
        cdCompanyResponse.longFmt           = companyResponse.marketCap.longFmt
        do {
            try context.save()
            completion(true)
        } catch let error {
            print("DEBUG: Failed to save to Core Data: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Updates the isFavourite Property for a company object in core data
    /// - Parameters:
    ///   - symbol: Company "Identifier"
    ///   - isFavourite: Bool
    ///   - completion: Bool or Void
    func updateIsFavourite(_ symbol: String, _ isFavourite: Bool, _ completion: @escaping (Bool) -> ()) {
        let fetchRequest: NSFetchRequest<CDCompanyResponse> = CDCompanyResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: ["symbol", symbol])
        do {
            if let company = try context.fetch(fetchRequest).first {
                company.isFavourited = isFavourite
                do {
                    try context.save()
                    completion(true)
                } catch let error {
                    print("DEBUG: Error updating isFavourites Property in Core Data: \(error.localizedDescription)")
                    completion(false)
                }
            }
        } catch let error {
            print("DEBUG: Error Fetching Company: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    

    
}














