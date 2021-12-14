//
//  GlobalConstant.swift
//  CollectionApp
//
//  Created by MACBOOK on 17/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

let CURRENCY = "INR"


//MARK: - STORYBOARD
struct STORYBOARD {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
    static var HOME = UIStoryboard(name: "Home", bundle: nil)
    static var PROFILE = UIStoryboard(name: "Profile", bundle: nil)
    
}

struct NOTIFICATION {
    static var REDICT_TAB_BAR               =   "REDICT_TAB_BAR"
    static var UPDATE_USER_DATA             =   "UPDATE_USER_DATA"
    static var UPDATE_USER_LOCATION         =   "UPDATE_USER_LOCATION"
}

struct DEVICE {
    static var IS_IPHONE_X = (fabs(Double(SCREEN.HEIGHT - 812)) < Double.ulpOfOne)
}

struct RAZORPAY {
    static var MID = "FfdqnYfXWp2bpC"
    //Test
    static var KEY = "rzp_test_JOC0wRKpLH1cVW"
    static var SECRET = "9EzSlxvJbTyQ2Hg0Us5ZX4VD"
    //Live
//    static var KEY = "rzp_live_Sdu5m3u79pOMfl"
//    static var SECRET = "an4Jps7aIV2tH4n8tWJu9jiy"
}

//MARK: - SCREEN
struct SCREEN
{
    static var WIDTH = UIScreen.main.bounds.size.width
    static var HEIGHT = UIScreen.main.bounds.size.height
}

let monthArr = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]

let CARD_NUMBER_CHAR = 16
let CARD_NUMBER_DASH_CHAR = 3

//MARK:- DocumentDefaultValues
struct DocumentDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}

//MARK:- AppColors
struct AppColors{
    static let LoaderColor =  #colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1)
}

//MARK: - KEY_CHAIN
enum KEY_CHAIN:String{
    case apple
}

//MARK: - PLACEHOLDER
enum PLACEHOLDER:String{
    case DOCTOR_IMAGE = "temp_doctor"
    case USER_IMAGE = "ic_user_placeholder"
}
