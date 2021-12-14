//
//  ProductListTVC.swift
//  ITFAQ
//
//  Created by Keyur on 14/12/21.
//

import UIKit

protocol ProductListDelegate {
    func updateCart(_ product: ProductModel)
}

class ProductListTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    
    var dict = ProductModel.init()
    var delegate : ProductListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails() {
        imgView.downloadCachedImage(placeholder: "", urlString: dict.imageURL)
        nameLbl.text = dict.name
        priceLbl.text = dict.currencySymbol + " " + dict.dyDisplayPrice
        qtyLbl.text = String(dict.cart)
    }
    
    //MARK: - Button Click
    @IBAction func clicKToPlusMinus(_ sender: UIButton) {
        if sender.tag == 1 {
            if dict.inStock == "true" && (dict.inventory != "0" && dict.inventory != "") {
                dict.cart += 1
                dict.inventory = String(Int(dict.inventory)! - 1)
                if dict.inventory == "0" {
                    dict.inStock = "false"
                }
            }else{
                displayToast("Out of stock")
            }
        }else{
            if dict.cart > 0 {
                dict.cart -= 1
                dict.inventory = String(Int(dict.inventory)! + 1)
                dict.inStock = "true"
            }
        }
        delegate?.updateCart(dict)
    }
    
    @IBAction func clicKToDelete(_ sender: UIButton) {
        if dict.cart > 0 {
            dict.inventory = String(Int(dict.inventory)! + dict.cart)
            dict.cart = 0
            dict.inStock = "true"
            delegate?.updateCart(dict)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
