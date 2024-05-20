//
//  Profile.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import Foundation

struct Profile: Codable {
    let generalInfo: GeneralInfo?
    let workExperience: [WorkExperience]?
    let education: Education?
    let professionalSkills: [String]?
    let languages: [Language]?
    let interests: [String]?
    let certificates: [Certificate]?
    let socialMedia: SocialMedia?
    let references: [Reference]?
}
