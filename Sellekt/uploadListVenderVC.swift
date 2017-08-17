//
//  uploadListVenderVC.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 28/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class uploadListVenderVC:BaseViewController_rafrral ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    @IBOutlet var venderTable: UITableView!
    var venderArr:NSMutableArray = []
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var offer_id:Int = 0
    var vender_id:Int = 0
    var filterArr:NSMutableArray = []
    @IBOutlet var venderSearch: UITextField!
    var param:[String : Any] = [:]
    var venderIDArr:NSMutableArray = []
    var q_id:String = ""
    var newArr:NSMutableArray = []
    var filter_id:String = "A_Z"
    var search_id:String = ""
    let fullStarImage:UIImage = UIImage(named: "Star_rating.png")!
    let halfStarImage:UIImage = UIImage(named: "Star_Haff_rating.png")!
    let emptyStarImage:UIImage = UIImage(named: "BlankStar_ratingt.png")!
    @IBOutlet var FilterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        print(self.venderArr)
            self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
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
        self.filterArr = ["A-Z","Near By","Not Near By","Rating High to Low","Rating Low to High"]
        self.navigationItem.titleView = imageView
        self.venderSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        view.endEditing(true)
    //    self.FilterTable.isHidden = true

        // do aditional stuff
    }
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 0.5 == starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate me
        textField.resignFirstResponder()
   
    // textField.resignFirstResponder()i
    
    return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var index:Int = 0
        if tableView == FilterTable
         {
            index = self.filterArr.count
         }
        if tableView == venderTable
        {
            index = self.venderArr.count
        }
        return index
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        
              //  let results = self.venderArr.filter() { ($0["data"]?["business_name"] as? String) == String  }
       // let filtered = self.venderIDArr.filter { $0.containsString("lo") }
        self.search_id = string
        self.filterVenderList()
        
        return true
        
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == FilterTable
        {
            let cell:UITableViewCell = self.FilterTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            cell.textLabel?.text = (self.filterArr[indexPath.row] as AnyObject)  as? String
            
            
            return cell

            
         }
        if tableView == venderTable
        {
            
        
        // let cell:venderCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! venderCell
        let cell:venderQuatationCell = self.venderTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! venderQuatationCell
        let thumb = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"vendor_cover_img")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
        cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
        
        cell.venderName.text = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String
        cell.away.text =  NSString(format:"2 Km") as String
         cell.rating.text = NSString(format:"%0.2f", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"average_rating")as? Float)!) as String
        cell.timeVender.text =  NSString(format:"%@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"working_hours")as? String)!) as String
        cell.address.text =  NSString(format:"%@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"city_name")as? String)!) as String
           let ourRating = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"average_rating")as? Float
            if ourRating == 0.5 {
                cell.starImg1.image = halfStarImage
            }
            if ourRating == 1 {
                cell.starImg1.image = fullStarImage
            }
            if ourRating == 1.5 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = halfStarImage
            }
            if ourRating == 2 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
            }
            if ourRating == 2.5 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = halfStarImage
            }
            if ourRating == 3 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = fullStarImage
            }
            if ourRating == 3.5 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = fullStarImage
                cell.starImg4.image = halfStarImage
            }
            if ourRating == 4 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = fullStarImage
                cell.starImg4.image = fullStarImage
            }
            if ourRating == 4.5 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = fullStarImage
                cell.starImg4.image = fullStarImage
                cell.starImg5.image = halfStarImage
            }
            if ourRating == 5 {
                cell.starImg1.image = fullStarImage
                cell.starImg2.image = fullStarImage
                cell.starImg3.image = fullStarImage
                cell.starImg4.image = fullStarImage
                cell.starImg5.image = fullStarImage
            }
            
            
            if  cell.tickImg.isSelected {
        cell.tickImg.isSelected = true
            }
            else
            {
                cell.tickImg.isSelected = false


            }
        
        return cell
        }
        else
        {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        self.FilterTable.isHidden = true

        if tableView == venderTable
        {
         let cell = self.venderTable.cellForRow(at: indexPath as IndexPath) as! venderQuatationCell!
         let text_id = (self.venderArr[indexPath.row] as AnyObject).value(forKey: "vendor_id") as! Int
       if (cell?.tickImg.isSelected)!
       {

        cell?.tickImg.isSelected = false
        if self.venderIDArr.count != 0
        {
            for row in 0...((self.venderIDArr.count) - 1) {
                
                let id = (self.venderIDArr[row] as AnyObject).value(forKey: "vendor_id") as! Int
                if id == text_id
                {
                    self.venderIDArr.removeObject(at: row)
                    
                    
                }
            }
        }

        }
        else
       {

        cell?.tickImg.isSelected = true
        if self.venderIDArr.count != 0
        {
             for row in 0...((self.venderIDArr.count) - 1) {
                
                let id = (self.venderIDArr[row] as AnyObject).value(forKey: "vendor_id") as! Int
                if id == text_id
                {
                    self.venderIDArr.removeObject(at: row)

                    let dictNew:NSMutableDictionary = [:]
                    dictNew.setValue(text_id, forKey: "vendor_id" )
                    
                    self.venderIDArr.add(dictNew)

        
                 }
            }
        }
        else
        {
            let dictNew:NSMutableDictionary = [:]
            dictNew.setValue(text_id, forKey: "vendor_id" )
            
            self.venderIDArr.add(dictNew)

        }

        }
        }
        if tableView == FilterTable {
            self.FilterTable.isHidden = true
            let filter = self.filterArr.object(at: indexPath.row) as! String
            if filter == self.filter_id
            {
                
            }
            else
            {
                self.filterVenderList()
            }
        }
        print (self.venderIDArr)
    }
    
    @IBAction func sendList(_ sender: Any) {
        if self.venderIDArr.count == 0
        {
            
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "Please Add At least one product "
            alert.addButton(withTitle: "OK")
            alert.show()

        }
        else
        {
            self.shareVenderList()
           
        }
        
        
    }
    func shareVenderList()
        
    {
        
        
        
        
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        // http://test.tranzporthub.com/sellekt/create_list_save_order_details_get_vendor_step2.php
        var url = NSString(format:"http://sellekt.teamdaphnisys.in/assign_quotation_to_vendor.php") as String
        url = url.removingWhitespaces()
        self.activityIndicator.isHidden = false;
        self.activityIndicator.startAnimating()
        
        request.url = NSURL(string: url as String) as URL?
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let param = [

            "customer_id":NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "quotation_id":self.q_id,
            "vendor_id_array": self.venderIDArr
            ] as [String : Any]
        print(param)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
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
                    print(jsonResult)

                    if tem==200
                        
                    {
                       // print
                        
//                        let dict:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
//                        // self.venderArr =
//                        //let thumb = defaults.stringForKey("referral_thumbnail");
//                        //  self.venderSearch.autoCompleteStrings = inputTextTokens
//                        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "uploadListVenderVC") as! uploadListVenderVC
//                        loginPageView.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
//                        loginPageView.param = param
//                        self.navigationController?.pushViewController(loginPageView, animated: true)
                        let alert:UIAlertController=UIAlertController(title: "Sucsess", message: "Your quatation has been send", preferredStyle: UIAlertControllerStyle.actionSheet)
                        alert.view.tintColor = UIColor.black
                        let cameraAction = UIAlertAction(title: "Home", style: UIAlertActionStyle.default)
                        {
                            
                            UIAlertAction in
                            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
                            self.navigationController?.pushViewController(loginPageView, animated: true)

                            
                        }
                        let gallaryAction = UIAlertAction(title: "Details", style: UIAlertActionStyle.default)
                        {
                            UIAlertAction in
                            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "MyQuotationVC") as! MyQuotationVC
                           // loginPageView.quatation_id =  Int(self.q_id)!
                            self.navigationController?.pushViewController(loginPageView, animated: true)

                         }
                        
                                                alert.addAction(cameraAction)
                        alert.addAction(gallaryAction)

                        self.present(alert, animated: true, completion: nil)
                        
                        
                       
                        
                        
                    }
                    else
                    {
                        let alert = UIAlertView()
                        alert.title = "Alert"
                        alert.message =  jsonResult.value(forKey: "message") as! String
                        alert.addButton(withTitle: "OK")
                        alert.show()

                        
                    }
                    
                }
            }
        }
        
        
    }

    func filterVenderList()
    {
        
               let request: NSMutableURLRequest = NSMutableURLRequest()
        // http://test.tranzporthub.com/sellekt/create_list_save_order_details_get_vendor_step2.php
        var url = NSString(format:"http://sellekt.teamdaphnisys.in/create_list_save_order_details_get_vendor_step2.php") as String
        url = url.removingWhitespaces()
        self.activityIndicator.isHidden = false;
        self.activityIndicator.startAnimating()
        
        request.url = NSURL(string: url as String) as URL?
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let param = [
            "shipping_vendor_id" : defaults.value(forKey:"venderArr") as! CVarArg,
            "customer_id":NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "quotation_id":self.q_id,
            "customer_quotation_comment":" ",
            "latitude":NSString (format: "%f",defaults.float(forKey:"lati")),
            "longitude":NSString (format: "%f",defaults.float(forKey:"longi")),
            "sort_by":self.filter_id,
            "vendor_business_name_search_keyword":self.search_id,
            "vendor_start_limit":"0",
            "vendor_end_limit":"100",
            "order_details_array": newArr
            ] as [String : Any]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
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
                        
                        let dict:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
                        // self.venderArr =
                        //let thumb = defaults.stringForKey("referral_thumbnail");
                        //  self.venderSearch.autoCompleteStrings = inputTextTokens
                         self.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
                                            
                        self.venderTable.reloadData()
                        
                        
                        
                        
                    }
                    else
                    {
                        
                        
                    }
                    
                }
            }
        }
        
        
    }

    @IBAction func filterList(_ sender: Any) {
      if self.FilterTable.isHidden
      {
        self.FilterTable.isHidden = false

        }
        else
      {
        self.FilterTable.isHidden = true

        
        }
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
