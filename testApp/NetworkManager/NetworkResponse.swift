//
//  NetworkResponse.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    let status: Bool?
    let data: T?
}
