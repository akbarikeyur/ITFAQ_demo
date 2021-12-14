//
//  HomeVC.swift
//  ITFAQ
//
//  Created by Keyur on 13/12/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var productCV: UICollectionView!
    @IBOutlet weak var cartLbl: Label!
    
    var homeVM = HomeViewModel()
    var arrSearch = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartLbl.text = ""
        cartLbl.isHidden = !homeVM.isCart()
    }
    
    func configUI() {
        registerCollectionView()
        callAPI()
        bindAllData()
    }

    //MARK: - Button Click
    @IBAction func clicKToCart(_ sender: UIButton) {
        let vc : MyCartVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.MyCartVC.rawValue) as! MyCartVC
        vc.homeVM = homeVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == searchTxt {
            arrSearch = [ProductModel]()
            arrSearch = homeVM.productList.value.filter({ (result) -> Bool in
                let nameTxt: NSString = result.name as NSString
                return (nameTxt.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            })
            productCV.reloadData()
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
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionView() {
        productCV.register(UINib.init(nibName: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (searchTxt.text?.trimmed == "" ? homeVM.productList.value : arrSearch).count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2
        let height = (width*250/150)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomProductCVC = productCV.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.CustomProductCVC.rawValue, for: indexPath) as! CustomProductCVC
        cell.setupDetails((searchTxt.text?.trimmed == "" ? homeVM.productList.value : arrSearch)[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let vc : ProductDetailVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.ProductDetailVC.rawValue) as! ProductDetailVC
        vc.homeVM = homeVM
        vc.selectedProduct = (searchTxt.text?.trimmed == "" ? homeVM.productList.value : arrSearch)[indexPath.row]
        searchTxt.text = ""
        productCV.reloadData()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC {
    func callAPI() {
        homeVM.getAllProdyctData()
    }
    
    func bindAllData() {
        
        homeVM.productList.bind { [weak self](_) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.productCV.reloadData()
            }
        }
    }
}
