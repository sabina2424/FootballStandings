//
//  MainModel.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

struct Standing: Codable {
    let id, name, slug, abbr: String?
    let logos: Logos?
    
    struct Logos: Codable {
        let light: String?
        let dark: String?
    }
}
