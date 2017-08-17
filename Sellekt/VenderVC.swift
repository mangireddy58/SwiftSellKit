//
//  VenderVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 22/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class VenderVC: BaseViewController_rafrral ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
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

        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
       
       // navigationController!.setNavigationBarHidden(true, animated:true)

        loadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        addSlideMenuButton()
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.filterArr = ["A-Z","Near By","Not Near By","Rating High to Low","Rating Low to High"]
        self.navigationItem.titleView = imageView
        self.venderSearch.delegate = self
        navigationController!.setNavigationBarHidden(false, animated:true)


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

    func loadData() {
        
        //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%@&longitude&=%@&sort_by=A_Z&vendor_business_name_search_keyword=&category_id=&subcategory_id=&vendor_start_limit=0&vendor_end_limit=100",[[NSUserDefaults standardUserDefaults]stringForKey:@"venderStr"],[[NSUserDefaults standardUserDefaults]stringForKey:@"lati" ],[[NSUserDefaults standardUserDefaults]stringForKey:@"longi" ] ];
      //  let url = NSString(format:"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",defaults.value(forKey:"venderArr") as! CVarArg,defaults.float(forKey:"lati"),defaults.float(forKey:"longi") ) as String
        var str:NSString = ""
        var vender_str:NSString = ""
        var offer_str:NSString = ""

         if let path = UserDefaults.standard.object(forKey: "category_id")
         {
            
            let ids = path as! Int
            if ids == 0
            {
                str = ""
            }
            else
            {
            str = NSString(format:"%d",ids)
                UserDefaults.standard.set(0, forKey: "category_id")
            }
        }
        if self.vender_id == 0
        {
            vender_str = ""

        }
    
        else
        {
            vender_str = NSString(format:"%d",self.vender_id)

        }
        if self.offer_id == 0
        {
            offer_str = ""
        }
        else
        {
            offer_str = NSString(format:"%d",self.offer_id)

        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/vendor_listing.php?shipping_vendor_id=%@&latitude=%f&longitude=%f&sort_by=%@&vendor_business_name_search_keyword=%@&category_id=%@&subcategory_id=&vendor_start_limit=0&vendor_end_limit=100",defaults.value(forKey:"venderArr") as! CVarArg,defaults.float(forKey:"lati"),defaults.float(forKey:"longi"),self.filter_id,self.search_id,str) as String
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
                        
                        self.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
                        print(self.venderArr)
                                                   DispatchQueue.main.async {
                                self.venderTable.reloadData()
                            }
                        
                        
                        
                        
                        
                        
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
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        
        //  let results = self.venderArr.filter() { ($0["data"]?["business_name"] as? String) == String  }
        // let filtered = self.venderIDArr.filter { $0.containsString("lo") }
        self.search_id = string
        self.loadData()
        
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
            let cell:venderCell = self.venderTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! venderCell
            let thumb = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"vendor_cover_img")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
            let thumb1 = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"vendor_profile_img")  as! String
            cell.venderLogo.layer.cornerRadius = cell.venderLogo.frame.size.width/2
            cell.venderLogo.layer.borderWidth = 1.5
            cell.venderLogo.layer.borderColor = UIColor.init(colorLiteralRed: 171.0/255.0, green: 21.0/255.0, blue: 92.0/255.0, alpha: 1.0/255.0).cgColor
            cell.venderLogo.clipsToBounds = true
            let urls1: NSURL =   NSURL(string: thumb1)!
            cell.venderLogo.sd_setImage(with: urls1 as URL, placeholderImage: UIImage(named: "Vendor Symbol.png"))

            cell.venderName.text = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String
            cell.away.text =  NSString(format:"2 Km") as String
            cell.rating.text = NSString(format:"%0.2f", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"average_rating")as? Float)!) as String
            cell.timeVender.text =  NSString(format:"%@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"working_hours")as? String)!) as String
            cell.address.text =  NSString(format:"%@ %@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"street_name")as? String)!,((self.venderArr[indexPath.row] as AnyObject).value(forKey:"city_name")as? String)!) as String
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
            
            
            
            return cell
        }
        else
        {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            
            return cell
            
        }
    }

  /*  @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // let cell:venderCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! venderCell
      let cell:venderCell = self.venderTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! venderCell
        let thumb = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"vendor_profile_img")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
        cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))

        cell.venderName.text = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String
        cell.away.text =  NSString(format:"2 Km") as String
        cell.timeVender.text =  NSString(format:"%@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"working_hours")as? String)!) as String
        cell.address.text =  NSString(format:"%@ %@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"street_name")as? String)!,((self.venderArr[indexPath.row] as AnyObject).value(forKey:"city_name")as? String)!) as String
        
        
        return cell
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == FilterTable {
            self.FilterTable.isHidden = true
            let filter = self.filterArr.object(at: indexPath.row) as! String
            if filter == self.filter_id
            {
                
            }
            else
            {
                self.loadData()
            }
        }
        if tableView == venderTable {
        print (self.venderIDArr)

        print("You tapped cell number \(indexPath.row).")
            let dataDict : NSMutableDictionary? = self.venderArr.object(at: indexPath.row) as? NSMutableDictionary
            self.vender_id =   (dataDict?.value(forKey:"vendor_id")  as? Int)!
        
         let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
      //  loginPageView.dict = self.venderArr[indexPath.row] as! NSMutableDictionary
           loginPageView.vender_id = self.vender_id
        self.navigationController?.pushViewController(loginPageView, animated: true)
        }
        // performSegueWithIdentifier("yourSegueIdentifer", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
