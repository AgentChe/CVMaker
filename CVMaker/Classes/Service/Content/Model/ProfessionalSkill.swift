//
//  ProfessionalSkill.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.05.2024.
//

struct ProfessionalSkill: Codable {
    let name: String
}

extension ProfessionalSkill {
    static func map(apilayerResponse: Any) -> [ProfessionalSkill] {
        guard let array = apilayerResponse as? [String] else { return [] }
        return array.map { ProfessionalSkill(name: $0) }
    }
}
