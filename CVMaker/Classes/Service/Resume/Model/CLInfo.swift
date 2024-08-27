//
//  CLInfo.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.08.2024.
//

struct CLInfo: Codable {
    let company: CLCompany?
    let hiringManager: CLHiringManager?
    let vacancy: CLVacancy?
    let textBlocks: [CLTextBlock]?
}
