//
//  UIFont+extension.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let descriptor = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        
        return self
    }
    
    var bold: UIFont {
        return withTraits(traits: .traitBold)
    }
}
