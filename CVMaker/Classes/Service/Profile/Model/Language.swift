//
//  Language.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import Foundation

struct Language: Codable {
    enum Level: Codable {
        case beginner
        case preIntermediate
        case intermediate
        case upperIntermediate
        case advanced
        case proficient
    }
    
    let name: String
    let level: Level
}
