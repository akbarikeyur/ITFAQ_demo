//
//  MyCartVC.swift
//  ITFAQ
//
//  Created by Keyur on 14/12/21.
//

import UIKit

class MyCartVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var arrCart = [ProductModel]()
    var homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        getCartData()
    }
    
    func getCartData() {
        arrCart = [ProductModel]()
        for temp in homeVM.productList.value {
            if temp.cart > 0 {
                arrCart.append(temp)
            }
        }
        tblView.reloadData()
        noDataLbl.isHidden = (arrCart.count > 0)
    }
    
    //MARK: - Button Click
    @IBAction func clicKToBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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

//MARK:- Tableview Method
extension MyCartVC : UITableViewDelegate, UITableViewDataSource, ProductListDelegate {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: TABLE_VIEW_CELL.ProductListTVC.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ProductListTVC.rawValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCart.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductListTVC = tblView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ProductListTVC.rawValue) as! ProductListTVC
        cell.delegate = self
        cell.dict = arrCart[indexPath.row]
        cell.setupDetails()
        cell.selectionStyle = .none
        return cell
    }
    
    func updateCart(_ product: ProductModel) {
        updateProductList(product)
        let index = arrCart.firstIndex { temp in
            temp.productID == product.productID
        }
        if index != nil {
            if product.cart == 0 {
                arrCart.remove(at: index!)
                noDataLbl.isHidden = (arrCart.count > 0)
            }else{
                arrCart[index!] = product
            }
            tblView.reloadData()
        }
    }
    
    func updateProductList(_ product : ProductModel) {
        let index = homeVM.productList.value.firstIndex { temp in
            temp.productID == product.productID
        }
        if index != nil {
            homeVM.productList.value[index!] = product
        }
        setProductData(homeVM.productList.value)
    }
}
