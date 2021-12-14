//
//  AppModel.swift
//  ITFAQ
//
//  Created by Keyur on 13/12/21.
//

import Foundation

// MARK: - CategoryModel
struct HomeModel: Codable {
    let variationName: String
    let banner: String
    let subheader: String
    let slots: [ProductModel]

    enum CodingKeys: String, CodingKey {
        case variationName = "variation_name"
        case banner, subheader, slots
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        variationName = try values.decodeIfPresent(String.self, forKey: .variationName) ?? DocumentDefaultValues.Empty.string
        banner = try values.decodeIfPresent(String.self, forKey: .banner) ?? DocumentDefaultValues.Empty.string
        subheader = try values.decodeIfPresent(String.self, forKey: .subheader) ?? DocumentDefaultValues.Empty.string
        slots = try values.decodeIfPresent([ProductModel].self, forKey: .slots) ?? [ProductModel]()
    }
    
    init() {
        variationName = DocumentDefaultValues.Empty.string
        banner = DocumentDefaultValues.Empty.string
        subheader = DocumentDefaultValues.Empty.string
        slots = [ProductModel]()
    }
}

// MARK: - ProductModel
struct ProductModel: Codable {
    let saleText: String
    let rating: String
    let currency: String
    let sku, productHeading, name: String
    let brandURL: String
    var inventory: String
    let imageURL: String
    let price, appExclusive: String
    let publishTime: String
    var slotDescription, brand, variant, inStock: String
    let underSale: String
    let categories: [String]
    let productSlug, newArrival, productID: String
    let url: String
    let bestseller, dyDisplayPrice: String
    let currencySymbol: String
    let groupID: String
    let crossedPrice: String
    var cart: Int
    
    enum CodingKeys: String, CodingKey {
        case saleText = "sale_text"
        case rating, currency, sku
        case productHeading = "product_heading"
        case name
        case brandURL = "brand_url"
        case inventory
        case imageURL = "image_url"
        case price
        case appExclusive = "app_exclusive"
        case publishTime = "publish_time"
        case slotDescription = "description"
        case brand, variant
        case inStock = "in_stock"
        case underSale = "under_sale"
        case categories
        case productSlug = "product_slug"
        case newArrival = "new_arrival"
        case productID = "product_id"
        case url, bestseller
        case dyDisplayPrice = "dy_display_price"
        case currencySymbol = "currency_symbol"
        case groupID = "group_id"
        case crossedPrice = "crossed_price"
        case cart
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        saleText = try values.decodeIfPresent(String.self, forKey: .saleText) ?? DocumentDefaultValues.Empty.string
        rating = try values.decodeIfPresent(String.self, forKey: .rating) ?? DocumentDefaultValues.Empty.string
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? DocumentDefaultValues.Empty.string
        sku = try values.decodeIfPresent(String.self, forKey: .sku) ?? DocumentDefaultValues.Empty.string
        productHeading = try values.decodeIfPresent(String.self, forKey: .productHeading) ?? DocumentDefaultValues.Empty.string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? DocumentDefaultValues.Empty.string
        brandURL = try values.decodeIfPresent(String.self, forKey: .brandURL) ?? DocumentDefaultValues.Empty.string
        inventory = try values.decodeIfPresent(String.self, forKey: .inventory) ?? DocumentDefaultValues.Empty.string
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? DocumentDefaultValues.Empty.string
        price = try values.decodeIfPresent(String.self, forKey: .price) ?? DocumentDefaultValues.Empty.string
        appExclusive = try values.decodeIfPresent(String.self, forKey: .appExclusive) ?? DocumentDefaultValues.Empty.string
        publishTime = try values.decodeIfPresent(String.self, forKey: .publishTime) ?? DocumentDefaultValues.Empty.string
        slotDescription = try values.decodeIfPresent(String.self, forKey: .slotDescription) ?? DocumentDefaultValues.Empty.string
        brand = try values.decodeIfPresent(String.self, forKey: .brand) ?? DocumentDefaultValues.Empty.string
        variant = try values.decodeIfPresent(String.self, forKey: .variant) ?? DocumentDefaultValues.Empty.string
        inStock = try values.decodeIfPresent(String.self, forKey: .inStock) ?? DocumentDefaultValues.Empty.string
        underSale = try values.decodeIfPresent(String.self, forKey: .underSale) ?? DocumentDefaultValues.Empty.string
        categories = try values.decodeIfPresent([String].self, forKey: .categories) ?? [String]()
        productSlug = try values.decodeIfPresent(String.self, forKey: .productSlug) ?? DocumentDefaultValues.Empty.string
        newArrival = try values.decodeIfPresent(String.self, forKey: .newArrival) ?? DocumentDefaultValues.Empty.string
        productID = try values.decodeIfPresent(String.self, forKey: .productID) ?? DocumentDefaultValues.Empty.string
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? DocumentDefaultValues.Empty.string
        bestseller = try values.decodeIfPresent(String.self, forKey: .bestseller) ?? DocumentDefaultValues.Empty.string
        dyDisplayPrice = try values.decodeIfPresent(String.self, forKey: .dyDisplayPrice) ?? DocumentDefaultValues.Empty.string
        currencySymbol = try values.decodeIfPresent(String.self, forKey: .currencySymbol) ?? DocumentDefaultValues.Empty.string
        groupID = try values.decodeIfPresent(String.self, forKey: .groupID) ?? DocumentDefaultValues.Empty.string
        crossedPrice = try values.decodeIfPresent(String.self, forKey: .crossedPrice) ?? DocumentDefaultValues.Empty.string
        cart = try values.decodeIfPresent(Int.self, forKey: .cart) ?? DocumentDefaultValues.Empty.int
    }
    
    init() {
        saleText = DocumentDefaultValues.Empty.string
        rating = DocumentDefaultValues.Empty.string
        currency = DocumentDefaultValues.Empty.string
        sku = DocumentDefaultValues.Empty.string
        productHeading = DocumentDefaultValues.Empty.string
        name = DocumentDefaultValues.Empty.string
        brandURL = DocumentDefaultValues.Empty.string
        inventory = DocumentDefaultValues.Empty.string
        imageURL = DocumentDefaultValues.Empty.string
        price = DocumentDefaultValues.Empty.string
        appExclusive = DocumentDefaultValues.Empty.string
        publishTime = DocumentDefaultValues.Empty.string
        slotDescription = DocumentDefaultValues.Empty.string
        brand = DocumentDefaultValues.Empty.string
        variant = DocumentDefaultValues.Empty.string
        inStock = DocumentDefaultValues.Empty.string
        underSale = DocumentDefaultValues.Empty.string
        categories = [String]()
        productSlug = DocumentDefaultValues.Empty.string
        newArrival = DocumentDefaultValues.Empty.string
        productID = DocumentDefaultValues.Empty.string
        url = DocumentDefaultValues.Empty.string
        bestseller = DocumentDefaultValues.Empty.string
        dyDisplayPrice = DocumentDefaultValues.Empty.string
        currencySymbol = DocumentDefaultValues.Empty.string
        groupID = DocumentDefaultValues.Empty.string
        crossedPrice = DocumentDefaultValues.Empty.string
        cart = DocumentDefaultValues.Empty.int
    }
}
