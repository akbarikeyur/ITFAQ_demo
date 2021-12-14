//
//  Preference.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

struct Preference{
    
    static let ACCESS_TOKEN_KEY       =   "ACCESS_TOKEN_KEY"
    static let USER_LOGIN_KEY       =   "USER_LOGIN_KEY"
    
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: MD5(key))
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: MD5(key)) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

func setProductData(_ data: [ProductModel])
{
    UserDefaults.standard.set(encodable: data, forKey: "PRODUCT_DATA")
    UserDefaults.standard.synchronize()
}

func getProductData() -> [ProductModel] {
    if let savedPerson = UserDefaults.standard.object(forKey: "PRODUCT_DATA") as? Data {
        let decoder = JSONDecoder()
        if let loadedData = try? decoder.decode([ProductModel].self, from: savedPerson) {
            return loadedData
        }
    }
    return [ProductModel]()
}


