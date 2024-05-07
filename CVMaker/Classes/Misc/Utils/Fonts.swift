//
//  Fonts.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: Bitter
    struct Bitter {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "Bitter-Bold", size: size)!
        }
        
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "Bitter-Medium", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "Bitter-SemiBold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "Bitter-Regular", size: size)!
        }
        
        static func extraBold(size: CGFloat) -> UIFont {
            UIFont(name: "Bitter-ExtraBold", size: size)!
        }
    }
    
    // MARK: Nunito
    struct Nunito {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "Nunito-Bold", size: size)!
        }
        
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "Nunito-Medium", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "Nunito-SemiBold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "Nunito-Regular", size: size)!
        }
        
        static func extraBold(size: CGFloat) -> UIFont {
            UIFont(name: "Nunito-ExtraBold", size: size)!
        }
    }
    
    // MARK: SFPro
    struct SFPro {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "SFProText-Bold", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "SFProText-Semibold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "SFProText-Regular", size: size)!
        }
    }
}
