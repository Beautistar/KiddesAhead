//
//  Constants.swift
//  KiddesAhead
//
//  Created by JIS on 6/25/17.
//  Copyright © 2017 JIS. All rights reserved.
//

import UIKit

let k1Lang1Month = "1Lang1Month"
let k2Lang1Month = "2Lang1Month"
let k3Lang1Month = "3Lang1Month"
let k4Lang1Month = "4Lang1Month"
let k1Lang1Year = "1Lang1Year"
let k2Lang1Year = "2Lang1Year"
let k3Lang1Year = "3Lang1Year"
let k4Lang1Year = "4Lang1Year"

struct Constants {
    
    static let SAVE_ROOT_PATH = "KiddesAhead"
    
    static let BASE_URL = "http://35.178.55.98/index.php/api/"
    static let REQ_LOGIN = BASE_URL + "login"
    static let REQ_SIGNUP = BASE_URL + "register"
    static let REQ_SAVEPROFILE = BASE_URL + "saveProfile"
    static let REQ_SUBSCRIBE = BASE_URL + "subscribe"
    static let REQ_RESETPASSWORD = BASE_URL + "resetPassword"
    static let REQ_SETPASSWORD = BASE_URL + "setPassword"
    static let REQ_SAVESPENT = BASE_URL + "saveSpent"
    
    static let RES_RESULTCODE = "result_code"
    static let RES_USERID = "user_id"
    static let RES_EMAIL = "email"
    static let RES_USERNAME = "username"
    static let RES_USERINFO = "user_info"
    static let RES_AGE = "age"
    static let RES_ATTEND = "attend"
    static let RES_ENEND = "en_end"
    static let RES_ESEND = "es_end"
    static let RES_FREND = "fr_end"
    static let RES_YBEND = "yb_end"
    static let RES_SPENT = "spent"
    static let RES_LASTSPENT = "last_spent"
    
    static let CODE_SUCESS = 200
    
    static let HOURSWEEK = 14
    
    static let YEARLY_PRICE = [0, 9.99, 19.99, 29.99, 39.99]
    static let MONTHY_PRICE = [0, 0.99, 1.99, 2.99, 3.99]
    
    static let CARD_NUMBERS = [5, 10, 20, 0]
    
    static let MIN_IMAGE_SIZE :CGFloat = 36
}

enum GAME_MODE : Int {
    case AUDIO
    case TOUCH
    case AFTERME
    case MUSIC
}

enum TOUCH_GAME : String, EnumCollection {
    case BEACH = "beach"
    case CLASSROOM = "classroom"
    case BEDROOM = "bedroom"
    case GARDEN = "garden"
    case LIVINGROOM = "livingroom"
    case KITCHEN = "kitchen"
    case PLAYGROUND = "playground"
    case BATHROOM = "bathroom"
    case STREET = "street"
    case ZOO = "zoo"
    case PETSHOP = "petshop"
    case DINNER = "dinner"
    case RESTAURANT = "restaurant"
    case RAINY = "rainy"
    case SNOWY = "snowy"
    case SUPERMARKET = "supermarket"
    case AIRPORT = "airport"
}

enum WORD_CATEGORIES : Int, EnumCollection {

    case CATEGORY_1
    case CATEGORY_2
    case CATEGORY_3
    case CATEGORY_4
    case CATEGORY_5
    case CATEGORY_6
    case CATEGORY_7
    case CATEGORY_8
    case CATEGORY_9
    case CATEGORY_10
    case CATEGORY_11
    case CATEGORY_12
    case CATEGORY_13
    case CATEGORY_14
    case CATEGORY_15
    case CATEGORY_16
    case CATEGORY_17
    
}

enum LANGUAGE : Int {
    
    case ENGLISH = 1
    case FRENCH = 2
    case SPANISH = 3
    case YORUBA = 4
}

enum SCORE : String {
    
    case PERFECT = "perfect"
    case GOOD = "good"
    case BAD = "bad"
}


struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7_8      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P_8P   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
}







