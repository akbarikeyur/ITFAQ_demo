//
//  Fonts.swift
//  Cozy Up
//
//  Created by Keyur on 22/05/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_REGULAR = "Calibri"
let APP_BOLD = "Calibri-Bold"
let APP_ITALIC = "Calibri-Italic"
let APP_LIGHT = "Calibri-Light"
let APP_BOLD_ITALIC = "Calibri-BoldItalic"
let APP_LIGHT_ITALIC = "Calibri-LightItalic"

enum FontType : String {
    case Clear = ""
    case ARegular = "ar"
    case ABold = "ab"
    case AItalic = "ai"
    case ALight = "al"
    case ABoldItalic = "abi"
    case ALightItalic = "ali"
}

extension FontType {
    var value: String {
        get {
            switch self {
                case .Clear:
                    return APP_REGULAR
                case .ARegular:
                    return APP_REGULAR
                case .ABold:
                    return APP_BOLD
                case .AItalic:
                    return APP_ITALIC
                case .ALight:
                    return APP_LIGHT
                case .ABoldItalic:
                    return APP_BOLD_ITALIC
                case .ALightItalic:
                    return APP_LIGHT_ITALIC
            }
        }
    }
}

