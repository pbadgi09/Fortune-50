//
//  CompanyResponse.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import Foundation

struct CompanyResponse: Codable {
    let marketCap   : MarketCap
    let name        : String
    let symbol      : String
}


struct MarketCap: Codable {
    let fmt         : String
    let longFmt     : String
    let raw         : Int
}
