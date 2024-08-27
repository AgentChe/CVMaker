//
//  PDFFactory.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.08.2024.
//

import Foundation

enum PDFFactory {
    static func create(cv: CV) -> Data {
        switch cv.template.identifier {
        case .template1:
            return PDF1Generator(profile: cv.profile).createPDF()
        case .template2:
            return PDF2Generator(profile: cv.profile).createPDF()
        case .template3:
            return PDF3Generator(profile: cv.profile).createPDF()
        case .template4:
            return PDF4Generator(profile: cv.profile).createPDF()
        case .template5:
            return PDF5Generator(profile: cv.profile).createPDF()
        case .template6:
            return PDF6Generator(profile: cv.profile).createPDF()
        case .template7:
            return PDF7Generator(profile: cv.profile).createPDF()
        case .template8:
            return PDF8Generator(profile: cv.profile).createPDF()
        case .template9:
            return PDF9Generator(profile: cv.profile).createPDF()
        case .template10:
            return PDF10Generator(profile: cv.profile).createPDF()
        case .template11:
            return PDF11Generator(profile: cv.profile).createPDF()
        case .template12:
            return PDF12Generator(profile: cv.profile).createPDF()
        case .template13:
            return PDF13Generator(profile: cv.profile).createPDF()
        case .template14:
            return PDF14Generator(profile: cv.profile).createPDF()
        case .template15:
            return PDF15Generator(profile: cv.profile).createPDF()
        case .template16:
            return PDF16Generator(profile: cv.profile).createPDF()
        }
    }
}
