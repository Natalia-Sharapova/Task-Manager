//
//  ExtensionString.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 06.02.2022.
//

import Foundation
import UIKit

extension String {
    
    // MARK: - Properties
    
    // Make camel case is capitalized With Spaces
    var capitalizedWithSpaces: String {
        
        let withSpaces = reduce("") { result, character in
            return  character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
        }
        return withSpaces.capitalized
    }
    
    // MARK: - Methods
    
    // Taking the width of the selected font
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        
        return ceil(size.width)
    }
}
