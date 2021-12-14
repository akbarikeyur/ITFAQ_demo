//
//  ProductDetailVC.swift
//  ITFAQ
//
//  Created by Keyur on 14/12/21.
//

import UIKit
import Lottie

class ProductDetailVC: UIViewController {

    @IBOutlet weak var productDescLbl: Label!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLbl: Label!
    @IBOutlet weak var productHeadingLbl: Label!
    @IBOutlet weak var brandLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var offerBtn: Button!
    @IBOutlet weak var cartLbl: Label!
    @IBOutlet weak var bestSellerView: UIView!
    @IBOutlet weak var exclusiveBtn: Button!
    @IBOutlet weak var addToBagBtn: Button!
    @IBOutlet weak var cartView: UIView!
    
    @IBOutlet weak var relatedItemView: UIView!
    @IBOutlet weak var productCV: UICollectionView!
    @IBOutlet weak var constraintHeightProductCV: NSLayoutConstraint!
    
    var selectedProduct : ProductModel = ProductModel.init()
    var homeVM = HomeViewModel()
    let animationView = AnimationView(name: "add_cart")
    var arrRelatedProduct : [ProductModel] = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartLbl.text = ""
        cartLbl.isHidden = !homeVM.isCart()
        setupUIDesigning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delay(0.5) {
            self.animationView.frame = CGRect(x: 0, y: -25, width: self.cartView.frame.size.width, height: self.cartView.frame.size.height + 50)
            self.cartView.addSubview(self.animationView)
        }
        
    }
    
    //MARK:- Setup UI and data
    func setupUIDesigning()
    {
        cartLbl.isHidden = !homeVM.isCart()
        //Rotate button
        offerBtn.transform = CGAffineTransform(rotationAngle: CGFloat(-0.5.squareRoot()+0.3))
        exclusiveBtn.transform = CGAffineTransform(rotationAngle: CGFloat(-0.5.squareRoot()))
        //Set round corner
        bestSellerView.roundCorners(corners: [.bottomRight, .topLeft], radius: 15)
        
        arrRelatedProduct = homeVM.productList.value
        
        let index = homeVM.productList.value.firstIndex { temp in
            temp.productID == selectedProduct.productID
        }
        if index != nil {
            selectedProduct = homeVM.productList.value[index!]
        }
        setProductDetail()
    }
    
    //MARK:- Setup product detail
    func setProductDetail()
    {
        productDescLbl.text = selectedProduct.slotDescription
        productImg.downloadCachedImage(placeholder: "", urlString: selectedProduct.imageURL)
        productNameLbl.text = selectedProduct.name
        if selectedProduct.variant != "" && productNameLbl.text != ""
        {
            productNameLbl.text = productNameLbl.text! + "(" + selectedProduct.variant + ")"
        }
        productHeadingLbl.text = selectedProduct.productHeading
        brandLbl.text = selectedProduct.brand
        starView.rating = Double(selectedProduct.rating) ?? 0.0
        priceLbl.text = selectedProduct.currencySymbol + " " + selectedProduct.dyDisplayPrice
        offerBtn.isHidden = true
        if selectedProduct.crossedPrice != "" {
            let crossed_price = selectedProduct.currencySymbol + " " + selectedProduct.crossedPrice
            priceLbl.text = crossed_price + " " + priceLbl.text!
            let attributedString = NSMutableAttributedString(string: priceLbl.text!)
            let range = (priceLbl.text! as NSString).range(of: crossed_price)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: range)
            priceLbl.attributedText = attributedString
            
            if selectedProduct.saleText != ""
            {
                let sale = selectedProduct.saleText.replacingOccurrences(of: " ", with: "\n")
                offerBtn.setTitle(sale, for: .normal)
                offerBtn.isHidden = false
            }
        }
        
        if selectedProduct.inStock == "false" && (selectedProduct.inventory == "0" || selectedProduct.inventory == "")
        {
            addToBagBtn.setTitle("OUT OF STOCK", for: .normal)
            addToBagBtn.isUserInteractionEnabled = false
            addToBagBtn.backgroundColor = UIColor.lightGray
            addToBagBtn.titleLabel?.textColor = UIColor.darkGray
        }else{
            addToBagBtn.setTitle("ADD TO BAG", for: .normal)
            addToBagBtn.isUserInteractionEnabled = true
            addToBagBtn.backgroundColor = RedColor
            addToBagBtn.titleLabel?.textColor = WhiteColor
        }
        
        bestSellerView.isHidden = (selectedProduct.bestseller == "false")
        exclusiveBtn.isHidden = (selectedProduct.appExclusive == "false")
        
        arrRelatedProduct = [ProductModel]()
        for tempCategory in selectedProduct.categories {
            for tempProduct in homeVM.productList.value {
                if tempProduct.productID != selectedProduct.productID {
                    let index = arrRelatedProduct.firstIndex { (temp) -> Bool in
                        temp.productID == tempProduct.productID
                    }
                    if index == nil {
                        if tempProduct.categories.contains(tempCategory)
                        {
                            arrRelatedProduct.append(tempProduct)
                        }
                    }
                }
            }
        }
        productCV.reloadData()
        relatedItemView.isHidden = (arrRelatedProduct.count == 0)
    }
    
    //MARK: - Button Click
    @IBAction func clicKToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clicKToCart(_ sender: UIButton) {
        let vc : MyCartVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.MyCartVC.rawValue) as! MyCartVC
        vc.homeVM = homeVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToProductImage(_ sender: Any) {
        displayFullImage([selectedProduct.imageURL], 0)
    }
    
    @IBAction func clickToBrand(_ sender: Any) {
        openUrlInSafari(strUrl: selectedProduct.brandURL)
    }
    
    @IBAction func clickToAddToBag(_ sender: UIButton) {
        if addToBagBtn.titleLabel?.text == "ADD TO BAG" {
            UIView.transition(with: sender, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.addToBagBtn.setTitle("ADDING...", for: .normal)
                self.AddToCartAnimation()
            }) { (isCompleted) in
                delay(1.0, closure: {

                })
            }
        }
    }
    
    //MARK:- Add to cart
    func AddToCartAnimation()
    {
        cartView.isHidden = false
        cartLbl.isHidden = false
        animationView.play()
        
        UIView.transition(with: cartLbl, duration: 0.1, options: .transitionCrossDissolve, animations: {
            
//            self.homeVM.total_cart += 1
//            self.cartLbl.text = String(self.homeVM.total_cart)
        })
        animationView.play { (isDone) in
            self.addToBagBtn.setTitle("ADD TO BAG", for: .normal)
            self.animationView.stop()
            self.cartView.isHidden = true
            self.updateProductInventory()
        }
    }
    
    //update cart value
    func updateProductInventory()
    {
        if selectedProduct.inventory != ""
        {
            var current_inventory : Int = Int(selectedProduct.inventory)!
            if current_inventory > 0 {
                current_inventory -= 1
                selectedProduct.inventory = String(current_inventory)
                
                if current_inventory == 0 {
                    addToBagBtn.setTitle("OUT OF STOCK", for: .normal)
                    addToBagBtn.isUserInteractionEnabled = false
                    addToBagBtn.backgroundColor = .lightGray
                    addToBagBtn.titleLabel?.textColor = .darkGray
                    selectedProduct.inStock = "false"
                }
                let index = homeVM.productList.value.firstIndex { (temp) -> Bool in
                    temp.productID == selectedProduct.productID
                }
                if index != nil
                {
                    selectedProduct.cart += 1
                    homeVM.productList.value[index!] = selectedProduct
                    setProductData(homeVM.productList.value)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK:- Collectionview Method
extension ProductDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionView() {
        productCV.register(UINib.init(nibName: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.productList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        constraintHeightProductCV.constant = 250
        let width = 150
        let height = 250
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomProductCVC = productCV.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue, for: indexPath) as! CustomProductCVC
        cell.setupDetails(homeVM.productList.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = homeVM.productList.value[indexPath.row]
        setProductDetail()
    }
}
