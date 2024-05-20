//
//  Certificate.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import Foundation

struct Certificate: Codable {
    let organizationName: String?
    let startDate: Date?
    let endDate: Date?
    let description: String?
}
