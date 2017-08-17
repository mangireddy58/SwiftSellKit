//
//  CartVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 22/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class CartVC: BaseViewController_rafrral , UITableViewDataSource,UITableViewDelegate {
    var dict: NSMutableDictionary!
    var productArr:NSMutableArray = []
    @IBOutlet var cartTable: UITableView!
    var qty_count:Int = 1
    var shipping:Int = 0
    var subTotal:Int = 0
    var mainTotal:Int = 0
    var vender_id:Int = 0
    @IBOutlet var shippingLbl: UILabel!
    @IBOutlet var subTotalLbl: UILabel!
    @IBOutlet var mainTotalLbl: UILabel!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view.
    }
    func totalValues(arr : NSMutableArray)  {
        subTotal = 0
        mainTotal = 0
        for row in 0...(arr.count - 1) {
            let cost:Int = ((arr[row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
            let quantity:Int = ((arr[row] as AnyObject).value(forKey:"quantity")  as? Int)!
            let total = cost * quantity
            subTotal = subTotal + total
            
        }
        mainTotal = subTotal + shipping
        
        self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
        self.shippingLbl.text = NSString(format: "%d", shipping)  as String
        self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String

        
        
    }
    @IBAction func checkOut(_ sender: Any) {
        if  ((defaults.object(forKey:"user_id")) != nil){
            if  (defaults.object(forKey:"user_id") as! Int == 0){
                let altMessage = UIAlertController(title: "Alert", message:"Please Login to continue ", preferredStyle: UIAlertControllerStyle.alert)
                let cameraAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                {
                    
                    UIAlertAction in
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    loginPageView.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(loginPageView, animated: true)
                    
                    
                }
                
                altMessage.addAction(cameraAction)
                
                self.present(altMessage, animated: true, completion: nil)
                
            }
            else
            {
                let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "checkOutVC") as! checkOutVC
                self.navigationController?.pushViewController(loginPageView, animated: true)
                
            }
        }
        else
        {
            let altMessage = UIAlertController(title: "Alert", message:"Please Login to continue ", preferredStyle: UIAlertControllerStyle.alert)
            let cameraAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
            {
                
                UIAlertAction in
                let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                loginPageView.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(loginPageView, animated: true)
                
                
            }
            
            altMessage.addAction(cameraAction)
            
            self.present(altMessage, animated: true, completion: nil)
            
        }

    }
     @IBAction func continuShoping(_ sender: Any) {
        let dataDict : NSMutableDictionary? = self.productArr.object(at: 0) as? NSMutableDictionary
          self.vender_id =   (dataDict?.value(forKey:"vendor_id")  as? Int)!
        
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
     //   loginPageView.dict = self.venderArr[indexPath.row] as! NSMutableDictionary
        loginPageView.vender_id = self.vender_id
        self.navigationController?.pushViewController(loginPageView, animated: true)

    }
    @IBAction func emptyCart(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Remove all Items?", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            if self.navigationController != nil {
                UserDefaults.standard.removeObject(forKey: "cart")
                let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
                self.navigationController?.pushViewController(loginPageView, animated: true)
                
                
            }
            //self.navigationController?.popViewController(animated: true)                //Just dismiss the action sheet
        }
        let cancelActions: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            if self.navigationController != nil {
                
                
            }
            //self.navigationController?.popViewController(animated: true)                //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelActions)

        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)

        
    }
    func totalValues1(arr : NSMutableArray)  {
        subTotal = 0
        mainTotal = 0
        for row in 0...(arr.count - 1) {
            let cost:Int = ((arr[row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
            let quantity:Int = ((arr[row] as AnyObject).value(forKey:"cost")  as? Int)!
            let total = cost * quantity
            subTotal = subTotal + total
            
        }
        mainTotal = subTotal + shipping
        
        self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
        self.shippingLbl.text = NSString(format: "%d", shipping)  as String
        self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productArr.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identifier = "cartCell"
        let cell: cartCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? cartCell
        //String phonStr =
      // cell.venderName.text = (self.productArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String
        cell.venderName.isHidden = true
        let thumb = (self.productArr[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
        cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
        cell.prodName.text = (self.productArr[indexPath.row] as AnyObject).value(forKey:"product_name")  as? String
        cell.qty.text =  NSString(format: "%d", ((self.productArr[indexPath.row] as AnyObject).value(forKey:"quantity")  as? Int)!) as String
        cell.cost.text = NSString(format: "%d", ((self.productArr[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!) as String
        

//        cell.dateLbl.text =  NSString(format:"%@", ((self.historyArr[indexPath.row] as AnyObject).value(forKey:"created_datetime")as? String)!) as String
//        cell.amtLbl.text =  NSString(format:"%@", ((self.historyArr[indexPath.row] as AnyObject).value(forKey:"net_total")as? String)!) as String
        
              let rec_id = Int((indexPath as NSIndexPath).row as NSNumber)
        //
        
               cell.pluse.tag = rec_id
               cell.pluse.addTarget(self, action: #selector(CartVC.Event_buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        cell.minuse.tag = rec_id
        cell.minuse.addTarget(self, action: #selector(CartVC.Minus_Event_buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
                 cell.deleteBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
        cell.deleteBtn.addTarget(self, action: #selector(CartVC.Delete_buttonClicked(sender:)), for: UIControlEvents.touchUpInside)

        
        
        
        return cell
    }
    func Event_buttonClicked(sender:UIButton) {
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        //
        let cell = self.cartTable.cellForRow(at: indexPath as IndexPath) as! cartCell!
        cell?.qty.text = NSString(format: "%d",  Int((cell?.qty.text)!)!+1) as String
        let val:Int = Int((cell?.qty.text)!)!
        let oldCost:Int = Int((cell?.cost.text)!)!

        let cost:Int = ((self.productArr[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
         cell?.cost.text = NSString(format: "%d", val*cost) as String
        let newCost:Int = Int((cell?.cost.text)!)!
        let cost1:Int = ((self.productArr[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
        let cost11:Int = newCost - cost1
        subTotal = subTotal +  cost11
     
    mainTotal = subTotal + shipping
    
    self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
    self.shippingLbl.text = NSString(format: "%d", shipping)  as String
    self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String

      //  (self.productArr[indexPath.row] as AnyObject).setValue(val, forKey: "cost")

      //  self.totalValues1(arr: self.productArr)

    }
    func Minus_Event_buttonClicked(sender:UIButton) {
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        //

        let cell = self.cartTable.cellForRow(at: indexPath as IndexPath) as! cartCell!
        let val = Int((cell?.qty.text)!)
        let oldCost:Int = Int((cell?.cost.text)!)!

        if val! > 1
        {
        cell?.qty.text = NSString(format: "%d",  Int((cell?.qty.text)!)!-1) as String
            let val:Int = Int((cell?.qty.text)!)!
            let cost:Int = ((self.productArr[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
            cell?.cost.text = NSString(format: "%d", val*cost) as String
            let newCost:Int = Int((cell?.cost.text)!)!
            let cost11:Int = cost - newCost
            subTotal = subTotal +  cost11
            
            mainTotal = subTotal + shipping
            
            self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
            self.shippingLbl.text = NSString(format: "%d", shipping)  as String
            self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String

         /*   let addCost:Int = newCost - cost
            subTotal = subTotal + addCost
            
            
            mainTotal = subTotal + shipping
            
            self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
            self.shippingLbl.text = NSString(format: "%d", shipping)  as String
            self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String

           // (self.productArr[indexPath.row] as AnyObject).setValue(val, forKey: "cost")*/

           // self.totalValues1(arr: self.productArr)

        }
        else
        {
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        addSlideMenuButton()
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
         self.navigationItem.titleView = imageView
         navigationController!.setNavigationBarHidden(false, animated:true)
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let arr:NSArray = UserDefaults.standard.object(forKey: "cart") as! NSArray
            if arr.count==0
            {
                
            }
            else
            {
                for row in 0...(arr.count - 1) {
                    self.productArr.add(arr[row])
                }
                print(self.productArr)
                self.totalValues(arr: self.productArr)
                // UserDefaults.standard.setValue(self.productArr, forKey: "cart")
                cartTable.reloadData()
            }
        }
       // self.totalValues(arr: self.productArr)

        
    }

    func Delete_buttonClicked(sender:UIButton) {
         let cost:Int = ((self.productArr[sender.tag] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!
        let qty:Int = ((self.productArr[sender.tag] as AnyObject).value(forKey:"quantity")  as? Int)!

        let cost11:Int = cost * qty
        subTotal = subTotal -  cost11
        
        mainTotal = subTotal + shipping
        
        self.subTotalLbl.text = NSString(format: "%d", subTotal)  as String
        self.shippingLbl.text = NSString(format: "%d", shipping)  as String
        self.mainTotalLbl.text = NSString(format: "%d", mainTotal)  as String

        self.productArr.removeObject(at: sender.tag);
        self.cartTable.reloadData()
        
        UserDefaults.standard.setValue(self.productArr, forKey: "cart")

    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


