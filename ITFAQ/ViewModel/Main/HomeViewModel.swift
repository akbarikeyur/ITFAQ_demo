//
//  HomeViewModel.swift
//  ITFAQ
//
//  Created by Keyur on 13/12/21.
//

import Foundation

protocol HomeViewDelegate {
    
    var productList: Box<[ProductModel]> { get set }
    func getAllProdyctData()
    
}

public class HomeViewModel : HomeViewDelegate {
    
    var productList: Box<[ProductModel]> = Box([])
    
    func getAllProdyctData()
    {
        if getProductData().count > 0 {
            self.productList.value = getProductData()
            return
        }
        if let filePath = Bundle.main.path(forResource: "product", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                let success = try JSONDecoder().decode(HomeModel.self, from: data as Data) // decode the
                self.productList.value = success.slots.self
                setProductData(self.productList.value)
            }
            catch {
                //Handle error
            }
        }
    }
    
    func isCart() -> Bool {
        let index = self.productList.value.firstIndex { temp in
            temp.cart > 0
        }
        if index != nil {
            return true
        }else{
            return false
        }
    }
}
