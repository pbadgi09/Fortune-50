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
    
    
    func saveUpdateCompanyDetails(_ company: CompanyResponse, _ isFavourited: Bool, _ completion: @escaping (Bool) -> ()) {
        if checkIfExists(company.symbol) {
            //  fetch & update company details
            updateCompanyDetails(company, isFavourited, completion)
        } else {
            //  save
            saveCompanyDetails(company, isFavourited, completion)
        }
    }
    
    
    
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
    
    
    
    
    
    
    
    
    
    func fetchAllCompanys() -> [CDCompanyResponse] {
        do {
            let companys = try context.fetch(CDCompanyResponse.fetchRequest())
            return companys
        } catch let error {
            print("DEBUG: Error getting all companys from Core data: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
    
    
    
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
    
    
    
    
    
    func getIsFavouritedProperty(_ company: CompanyResponse) -> Bool {
        let companyDetail = fetchSingleCompanyDetails(company)
        if let companyDetail = companyDetail {
            return companyDetail.isFavourited
        } else {
            return false
        }
    }
    
    
    
    
}














