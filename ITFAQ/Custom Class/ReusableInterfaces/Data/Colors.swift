//
//  Colors.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var BlackColor : UIColor = colorFromHex(hex: "000000") //2
var AppColor : UIColor = UIColor.init(named: "App")!  //colorFromHex(hex: "056AAD") //4
var GrayBorderColor : UIColor = colorFromHex(hex: "9E9E9E") //5
var RedColor = colorFromHex(hex: "CF0031") //6

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case Black = 2
    case App = 4
    case GrayBorder = 5
    case Red = 6
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear: //0
                    return ClearColor
                case .White: //1
                    return WhiteColor
                case .Black: //2
                    return BlackColor
                case .App: //9
                    return AppColor
                case .GrayBorder: //12
                    return GrayBorderColor
                case .Red: //12
                    return RedColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    colorFromHex(hex: "307AF9").cgColor,
                    colorFromHex(hex: "2651B7").cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
//                gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
//                gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}


extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    colorFromHex(hex: "#00AF80").cgColor,
                    colorFromHex(hex: "#06BD8C").cgColor,
                    colorFromHex(hex: "#08969C").cgColor
                ]
                gradient.locations = [0.0, 0.5, 1.0]
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            }
            
            return gradient
        }
    }
}

