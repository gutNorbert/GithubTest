//
//  Typography.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 2/1/23.
//

import UIKit

extension String {
    
    func toCardTitle(color: UIColor = .white, textAlignment: NSTextAlignment = .center) -> NSAttributedString {
        return StringBuilder(string: self)
            .size(18.0)
            .color(color)
            .fontName(.optimaBold)
            .textAlignment(textAlignment)
            .build()
    }
    
    func toCardStandard(color: UIColor = .white, textAlignment: NSTextAlignment = .left) -> NSAttributedString {
        return StringBuilder(string: self)
            .size(14.0)
            .color(color)
            .fontName(.optimaRegular)
            .textAlignment(textAlignment)
            .build()
    }

}

final class StringBuilder {
    
    enum FontName: String {
        case optimaRegular = "Optima-Regular"
        case optimaBold = "Optima-Bold"
        
        fileprivate func font(of size: CGFloat) -> UIFont {
            return UIFont(name: rawValue, size: size)!
        }

    }
    
    private let string: String
    
    private var fontName: FontName = .optimaRegular

    private var size: CGFloat = 17.0

    private var color: UIColor = .black

    private var textAlignment: NSTextAlignment = .center

    init(string: String) {
        self.string = string
    }

    func fontName(_ fontName: FontName) -> StringBuilder {
        self.fontName = fontName
        return self
    }

    func size(_ size: CGFloat) -> StringBuilder {
        self.size = size
        return self
    }

    func color(_ color: UIColor) -> StringBuilder {
        self.color = color
        return self
    }

    func textAlignment(_ textAlignment: NSTextAlignment) -> StringBuilder {
        self.textAlignment = textAlignment
        return self
    }
    
    func build() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: fontName.font(of: size),
            .paragraphStyle: paragraphStyle
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
}
