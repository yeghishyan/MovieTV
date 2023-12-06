//
//  ResponseModel.swift
//  BritaliansTV-tvOS
//
//  Created by miqo on 23.11.23.
//

import Foundation

struct Response<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}

struct ErrorResponse: Codable { 
    let message: String
}

