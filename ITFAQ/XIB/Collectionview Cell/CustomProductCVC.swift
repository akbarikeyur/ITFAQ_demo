//
//  CustomProductCVC.swift
//  ITFAQ
//
//  Created by Keyur on 13/12/21.
//

import UIKit

class CustomProductCVC: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var newView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newView.roundCorners(corners: [.bottomRight, .topLeft], radius: 10)
    }
    
    func setupDetails(_ dict: ProductModel) {
        productImgView.downloadCachedImage(placeholder: "", urlString: dict.imageURL)
        productNameLbl.text = dict.name
        newView.isHidden = (dict.newArrival.lowercased() != "true")
    }

}
