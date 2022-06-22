//
//  SeasonsModel.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

struct Seasons: Codable {
    let name, desc, abbreviation: String?
    let seasons: [Season]?
}

struct Season: Codable {
    let year: Int?
    let startDate, endDate, displayName: String?
    let types: [TypeElement]?
    
    var onlyDate: String {
        guard let index = startDate?.firstIndex(of: "T") else  { return startDate ?? "" }
        let start = startDate?[..<index]
        let end = endDate?[..<index]
        return "\(start ?? "") - \(end ?? "")"
    }
}

struct TypeElement: Codable {
    let id, name, abbreviation, startDate: String?
    let endDate: String?
    let hasStandings: Bool?
}
