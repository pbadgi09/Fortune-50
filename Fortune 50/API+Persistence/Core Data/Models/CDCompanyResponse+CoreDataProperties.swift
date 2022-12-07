//
//  CDCompanyResponse+CoreDataProperties.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//
//

import Foundation
import CoreData


extension CDCompanyResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCompanyResponse> {
        return NSFetchRequest<CDCompanyResponse>(entityName: "CDCompanyResponse")
    }

    @NSManaged public var fmt: String?
    @NSManaged public var longFmt: String?
    @NSManaged public var raw: String?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var isFavourited: Bool

}

extension CDCompanyResponse : Identifiable {

}
