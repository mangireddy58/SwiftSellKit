//
//  aceptanceListVC.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 31/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class aceptanceListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet var acceptanceTable: UITableView!
    var acceptanceArr:NSMutableArray = []
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var quatation_id:Int = 0
    var vender_id:Int = 0
    @IBOutlet var acceptanceHeader: UIView!
    var productArr:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        loadData()
 
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return acceptanceArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataDict : NSMutableDictionary? = acceptanceArr.object(at: section) as? NSMutableDictionary
        let counts: NSArray = (dataDict!.object(forKey: "array_vendor_quotation_details") as? NSArray)!
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        
        if isOpened == true {
            return counts.count
        }
        else {
            return 0
        }
    }

  /*  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var index:Int = 0
                if tableView == acceptanceTable
        {
            index = self.acceptanceArr.count
        }
        return index
        // Do any additional setup after loading the view.
}*/
    


func loadData() {
    
    //http://test.tranzporthub.com/sellekt/customer_vendor_quotation_details.php?customer_id=1&quotation_id=1
    var quatation_str:NSString = ""
    
    if self.quatation_id == 0
    {
        quatation_str = ""
        
    }
        
    else
    {
        quatation_str = NSString(format:"%d",self.quatation_id)
        
    }
    
    let request: NSMutableURLRequest = NSMutableURLRequest()
    let url = NSString(format:"http://sellekt.teamdaphnisys.in/customer_vendor_quotation_details.php?customer_id=%@&quotation_id=%@",NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,quatation_str) as String
    let trimmedString = url.removingWhitespaces()
    
    //url.removingWhitespaces()
    self.activityIndicator.isHidden = false;
    self.activityIndicator.startAnimating()
    
    request.url = NSURL(string: trimmedString as String) as URL?
    request.httpMethod = "GET"
    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue()) {(response, datas, error) -> Void in
        if error != nil {
            self.activityIndicator.isHidden = true;
            self.activityIndicator.stopAnimating()
            
            print("error")
            
        } else {
            DispatchQueue.main.async {
                //code
                self.activityIndicator.isHidden = true;
                self.activityIndicator.stopAnimating()
                
                
                let jsonResult = try! JSONSerialization.jsonObject(with: datas!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let tem = jsonResult.value(forKey: "status") as! Int
                if tem==200
                    
                {
                    let mainCatArr:NSMutableArray = []

                    let arr:NSMutableArray = jsonResult.value(forKey: "array_vendor_quotation_listing_details") as! NSMutableArray
                    for row in 0...(arr.count - 1)
                    {
                        
                        let cell = arr[row] as! NSMutableDictionary
                         cell.setValue(false, forKey: "isOpened")
                         mainCatArr.add(cell)
                        
                    }
                    if mainCatArr.count == 0
                    {
                        let altMessage = UIAlertController(title: "Alert", message:"No data found", preferredStyle: UIAlertControllerStyle.alert)
                        altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(altMessage, animated: true, completion: nil)

                    }
                    else
                    {
                         DispatchQueue.main.async {
                        self.acceptanceArr = mainCatArr
                        self.acceptanceTable.reloadData()
                        }

                    }
                
                
                   
//                        self.recivedQuatation.text = NSString (format: "%d" ,jsonResult.value(forKey: "total_quotation_recieved_count")as! Int) as String
//                        self.shareVender.text = NSString (format: "%d" ,jsonResult.value(forKey: "total_quotation_sending_count")as! Int) as String
//                        
//                        //                            total_quotation_sending_count": 1,
//                        //                            "total_quotation_recieved_count": 3
//                        self.tableVIew.reloadData()
                    }
                    
                    
                    
                    
            
                else
                {
                    let altMessage = UIAlertController(title: "Alert", message:jsonResult.value(forKey: "message") as? String, preferredStyle: UIAlertControllerStyle.alert)
                    altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(altMessage, animated: true, completion: nil)
                    
                    
                }
                
            }
        }
    
    
}
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //  var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCell
        let cell:AcceptanceVCCellTableViewCell = self.acceptanceTable.dequeueReusableCell(withIdentifier: "cell") as! AcceptanceVCCellTableViewCell

               let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: indexPath.section) as? NSMutableDictionary
        let objectArray : NSMutableArray? = dataDict?.object(forKey: "array_vendor_quotation_details") as? NSMutableArray
        let objectDict : NSMutableDictionary? = objectArray?.object(at: indexPath.row) as? NSMutableDictionary
        cell.backgroundColor = UIColor.white;
        
        cell.productLbl?.text = objectDict?.value(forKey: "product_name") as? String
        cell.costLbl.text = NSString(format:"%0.2f", (objectDict?.value(forKey:"total_price")as? Float)!) as String
        cell.qtyLbl.text =  NSString(format:"%d", ( objectDict?.value(forKey:"quantity")as? Int)!) as String
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 50))
        let headerView = UIButton(frame: CGRect(x: 0, y: 10, width:  self.view.frame.size.width, height: 40))
        let img:UIImageView = UIImageView()
        img.frame = CGRect(x: view.frame.size.width - 50, y: 5, width:  30, height: 30)
        
        let name:UILabel = UILabel()
        name.text =   NSString(format:"%@ Market",((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String)!) as String
        name.frame = CGRect(x: 10, y: 0, width:  self.view.frame.size.width-100, height: 40)
        name.textColor = UIColor.white
        name.font = name.font.withSize(15)

       // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
        headerView.addSubview(name)
        let cost:UILabel = UILabel()
        cost.text =  NSString(format:"%0.2f AED",((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "vendor_quotation_total_amount") as? Float!)!) as String
        cost.frame = CGRect(x: name.frame.size.width-70, y: 5, width:  80, height: 25)
        cost.textColor = UIColor.black
        cost.backgroundColor = UIColor.white
        cost.textAlignment = NSTextAlignment.center
        cost.font = cost.font.withSize(13)
        cost.layer.masksToBounds = true
        cost.layer.cornerRadius = 5
        // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
        headerView.addSubview(cost)
      //  headerView.setTitle("Whole Market " + String(section),for: UIControlState())
        
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            
            headerView.backgroundColor = UIColor(red: CGFloat(176) / 255.0, green: CGFloat(19) / 255.0, blue: CGFloat(90) / 255.0, alpha: CGFloat(1))
            img.image = UIImage.init(named: "minus.png")
               headerView.frame =  CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 70)
            self.acceptanceHeader.frame =  CGRect(x: 0, y: 40, width:  self.view.frame.size.width, height: 30)
            let view1 = UIView(frame: CGRect(x: 0, y: 40, width:  self.view.frame.size.width, height: 30))
            view1.backgroundColor = UIColor.lightGray
            let names:UILabel = UILabel()
            names.text =  "Our Product Name"
            names.frame = CGRect(x: 10, y: 0, width:  200, height: 30)
            names.textColor = UIColor.black
            names.font = name.font.withSize(16)
            
            let names1:UILabel = UILabel()
            names1.text =  "Qty"
            names1.frame = CGRect(x: 210, y: 0, width:  50, height: 30)
            names1.textColor = UIColor.black
            names1.font = name.font.withSize(16)

            let names2:UILabel = UILabel()
            names2.text =  "Price"
            names2.frame = CGRect(x:  self.view.frame.size.width-50, y: 0, width:  80, height: 30)
            names2.textColor = UIColor.black
            names2.font = name.font.withSize(16)

            // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
            view1.addSubview(names)
            view1.addSubview(names1)
            view1.addSubview(names2)


        
          //  let headerViews:UIView = (Bundle.main.loadNibNamed("acceptanceHeader", owner: nil, options: nil)![0] as? UIView)!
           // tableView.register(UINib(nibName: "acceptanceHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "acceptanceHeader")
            headerView.addSubview(view1)


        }
        else{
            //  headerView.backgroundColor = UIColor.blue
            headerView.backgroundColor = UIColor(red: CGFloat(31) / 255.0, green: CGFloat(78) / 255.0, blue: CGFloat(120) / 255.0, alpha: CGFloat(1))
            img.image = UIImage.init(named: "plus1.png")
          //  headerViews.isHidden=true
            headerView.frame =  CGRect(x: 0, y: 10, width:  self.view.frame.size.width, height: 40)



        }

        headerView.addTarget(self, action: #selector(aceptanceListVC.headerClicked(_:)), for: UIControlEvents.touchUpInside)
        headerView.tag = section
        headerView.addSubview(img)

        view.addSubview(headerView)
        return view
    }
      func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view = UIView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 70))
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            view = UIView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 50))
            
        }
        else{
            //  headerView.backgroundColor = UIColor.blue
            view = UIView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 0))
            
        }
        view.backgroundColor = UIColor(red: CGFloat(176) / 255.0, green: CGFloat(19) / 255.0, blue: CGFloat(90) / 255.0, alpha: CGFloat(1))
        let headerView = UIButton(frame: CGRect(x: 25, y: 5, width:  120, height: 30))
        headerView.setTitle("Pay Now", for: .normal)
      //  headerView.title(for: UIControlState.normal)
        headerView.layer.cornerRadius = 5
       // let diff = date1.timeIntervalSinceDate(date2)
        headerView.tintColor = UIColor.white
        headerView.backgroundColor =  UIColor(red: CGFloat(51) / 255.0, green: CGFloat(153) / 255.0, blue: CGFloat(51) / 255.0, alpha: CGFloat(1))
        let name:UILabel = UILabel()
        name.text =  "Total Amount"
        name.frame = CGRect(x: view.frame.size.width-150, y: 0, width:  90, height: 40)
        name.textColor = UIColor.white
        name.font = name.font.withSize(11)
        // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
        view.addSubview(name)
        let cost:UILabel = UILabel()
        cost.text =  NSString(format:"%0.2f AED",((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "vendor_quotation_total_amount") as? Float!)!) as String
        cost.frame = CGRect(x: name.frame.origin.x + 80, y: 5, width: 60, height: 30)
        cost.textColor = UIColor.black
        cost.backgroundColor = UIColor.white
        cost.layer.masksToBounds = true
        cost.layer.cornerRadius = 5
        //cost.font.withSize(10.0)
        cost.textAlignment = NSTextAlignment.center
        cost.font = cost.font.withSize(11)
        // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
        view.addSubview(cost)
        //  headerView.setTitle("Whole Market " + String(section),for: UIControlState())
        
        

        headerView.addTarget(self, action: #selector(aceptanceListVC.footerClicked(_:)), for: UIControlEvents.touchUpInside)
        headerView.tag = section;
        view.addSubview(headerView)
        return view
        
     }
    
      func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var hightt:CGFloat = 0
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            hightt = 40.0
         }
        else{
            //  headerView.backgroundColor = UIColor.blue
            hightt =  0.0

         }

        return hightt
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var hightt:CGFloat = 0
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            hightt = 70.0
        }
        else{
            //  headerView.backgroundColor = UIColor.blue
            hightt =  55.0
            
        }
        
        return hightt

     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func headerClicked(_ sender:UIButton) {
        
        for i in 0...acceptanceArr.count-1
        {
            let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: i) as? NSMutableDictionary
            dataDict?.setValue(false, forKey: "isOpened")
        }
        
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: sender.tag) as? NSMutableDictionary
        dataDict?.setValue(true, forKey: "isOpened")
        
        UIView.transition(with: self.acceptanceTable, duration: 0.50, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.acceptanceTable.reloadData()
        }, completion: nil)
    }
    
    
    func footerClicked(_ sender:UIButton) {
        
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: sender.tag) as? NSMutableDictionary
        let vender_id =   dataDict?.value(forKey:"vendor_id")  as? Int
      //  let dict:NSMutableDictionary = self.compareProductArr[buttonRow] as! NSMutableDictionary
        
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let path = UserDefaults.standard.object(forKey: "cart") as! NSMutableArray
            for row in 0...(path.count - 1) {
                let cell = path[row] as! NSDictionary
                if cell.value(forKey: "vendor_id") as? Int == vender_id
                {
                    
                        let arr:NSArray = UserDefaults.standard.object(forKey: "cart") as! NSArray
                        for row in 0...(arr.count - 1) {
                            self.productArr.add(arr[row])
                         
                       

                    }
                    let objectArray : NSMutableArray? = dataDict?.object(forKey: "array_vendor_quotation_details") as? NSMutableArray
                    let mainCatArr:NSMutableArray = []
                    
                     for row in 0...((objectArray?.count)! - 1)
                    {
                        
                        let cell = objectArray?[row] as! NSMutableDictionary
                        cell.setValue("Quotation", forKey: "order_type")
                        cell.setValue("Unpaid", forKey: "payment_status")

                        mainCatArr.add(cell)
                        
                    }

                    self.productArr.add(mainCatArr as Any)
                    UserDefaults.standard.setValue(self.productArr, forKey: "cart")
                    
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                     loginPageView.dict = dataDict
                    self.navigationController?.pushViewController(loginPageView, animated: true)
                }
                else
                {
                    let actionSheetController: UIAlertController = UIAlertController(title: "Vender is missmatch", message: "Clear cart items and add this product to cart", preferredStyle: .alert)
                    
                    //Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        //Do some stuff
                    }
                    actionSheetController.addAction(cancelAction)
                    //Create and an option action
                    
                    let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                    }
                    actionSheetController.addAction(nextAction)
                    self.present(actionSheetController, animated: true, completion: nil)
                }
            }
            
        }
        else
        {
            let objectArray : NSMutableArray? = dataDict?.object(forKey: "array_vendor_quotation_details") as? NSMutableArray
            let mainCatArr:NSMutableArray = []
            
            for row in 0...((objectArray?.count)! - 1)
            {
                
                let cell = objectArray?[row] as! NSMutableDictionary
                cell.setValue("Quotation", forKey: "order_type")
                cell.setValue("Unpaid", forKey: "payment_status")
                
                self.productArr.add(cell)
                
            }
            
            //self.productArr.add(mainCatArr as Any)
            UserDefaults.standard.setValue(self.productArr, forKey: "cart")

            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
             loginPageView.dict = dataDict
            
            self.navigationController?.pushViewController(loginPageView, animated: true)
            
        }
    }

    
    
    }
    

    
    
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

