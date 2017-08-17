//
//  productDetailsVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 24/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit
 class productDetailsVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate ,UITableViewDataSource,UITableViewDelegate{
    var subProductArrTop:NSMutableArray = []
    var filterArr:NSMutableArray = []
    var imgArray:NSMutableArray = []
    var vender_id:String = "0"
    var isFav:Bool = false
    @IBOutlet var prodImg: UIImageView!
    @IBOutlet var selectSize: UIButton!
    @IBOutlet var favBtns: UIButton!
    @IBOutlet var FilterTable: UITableView!
    var isFavStr:String = "Add"
    var vender_id1:Int = 0
    var product_id:Int = 0
    var product_log_id:Int = 0
    var qty:String = "1"

    @IBOutlet var descLbl: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet var createList: UIBarButtonItem!
    @IBOutlet var prodCost: UILabel!
    @IBOutlet var prodNameLbl: UILabel!
    @IBOutlet weak var qtyCount: UILabel!
    let defaults = UserDefaults.standard
     var objArr:[String] = []
    var activityIndicator = UIActivityIndicatorView()
    var img_dict: NSMutableDictionary!
    @IBOutlet var starImg1: UIImageView!
    @IBOutlet var starImg2: UIImageView!
    @IBOutlet var starImg3: UIImageView!
    @IBOutlet var starImg4: UIImageView!
    @IBOutlet var starImg5: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    let fullStarImage:UIImage = UIImage(named: "Star_rating.png")!
    let halfStarImage:UIImage = UIImage(named: "Star_Haff_rating.png")!
    let emptyStarImage:UIImage = UIImage(named: "BlankStar_ratingt.png")!

     var dict: NSMutableDictionary!
 
    @IBOutlet weak var favBtn: UIButton!
    @IBAction func MinusBtn(_ sender: Any) {
        if Int(self.qtyCount.text!)! > 1
        {
           self.qtyCount.text = NSString(format: "%d",Int(self.qtyCount.text!)!-1) as String
        }
    }
    @IBAction func favBtn(_ sender: Any) {
        if self.favBtn.isSelected
        {
            self.favBtn.isSelected = false
            isFavStr = "Remove"
        }
        else
        {
            self.favBtn.isSelected = true
            isFavStr = "Add"


        }
        self.loadDataFav()
    }
    @IBAction func pluseBtn(_ sender: Any) {
        self.qtyCount.text = NSString(format: "%d",Int(self.qtyCount.text!)!+1) as String
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.setNavigationBarHidden(false, animated:true)
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let thumb = (self.dict as AnyObject).value(forKey:"product_display_img")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
         self.prodNameLbl.text = (self.dict as AnyObject).value(forKey:"product_name")  as? String
        print(self.dict)
     //   self.qtyName.text = (self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"size_name")  as? String
        self.prodCost.text = NSString(format: "%d", ((self.dict as AnyObject).value(forKey:"display_mrp_price")  as? Int)!) as String
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
     //   self.venderID =  NSString(format: "%d",((self.dict as AnyObject).value(forKey:"vendor_id") as? Int)!) as String
        navigationController!.setNavigationBarHidden(true, animated:true)
        self.qtyCount.text = self.qty
        loadData()
//http://test.tranzporthub.com/sellekt/product_details.php?shipping_vendor_id=1,2,3&product_id=71&product_log_id=95&variation_id=181&vendor_id=1&customer_id=//
        // Do any additional setup after loading the view.
    }
    func loadDataFav() {
       // http://test.tranzporthub.com/sellekt/add_remove_wishlist_product.php
        let request: NSMutableURLRequest = NSMutableURLRequest()
        // http://test.tranzporthub.com/sellekt/create_list_save_order_details_get_vendor_step2.php
        var url = NSString(format:"http://sellekt.teamdaphnisys.in/add_remove_wishlist_product.php") as String
        url = url.removingWhitespaces()
        self.activityIndicator.isHidden = false;
        self.activityIndicator.startAnimating()
        
        request.url = NSURL(string: url as String) as URL?
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let param = [
            "flag_add_remove":self.isFavStr,
            "customer_id":NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "product_id":self.product_id,
            "vendor_id":self.vender_id1,
            "variation_id":self.vender_id,
            "product_log_id":self.product_log_id

            
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
                        
                        
                        let altMessage = UIAlertController(title: jsonResult.value(forKey: "response_message") as? String, message:jsonResult.value(forKey: "message") as? String, preferredStyle: UIAlertControllerStyle.alert)
                        altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(altMessage, animated: true, completion: nil)
                        // self.venderArr =
                        //let thumb = defaults.stringForKey("referral_thumbnail");
                        //  self.venderSearch.autoCompleteStrings = inputTextTokens
//                        self.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
//                        
//                        self.venderTable.reloadData()
                        
                        
                        
                        
                    }
                    else
                    {
                        
                        
                    }
                    
                }
            }
        }

    }
    func loadData() {
        
        //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%@&longitude&=%@&sort_by=A_Z&vendor_business_name_search_keyword=&category_id=&subcategory_id=&vendor_start_limit=0&vendor_end_limit=100",[[NSUserDefaults standardUserDefaults]stringForKey:@"venderStr"],[[NSUserDefaults standardUserDefaults]stringForKey:@"lati" ],[[NSUserDefaults standardUserDefaults]stringForKey:@"longi" ] ];
        //  let url = NSString(format:"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",defaults.value(forKey:"venderArr") as! CVarArg,defaults.float(forKey:"lati"),defaults.float(forKey:"longi") ) as String
        self.vender_id1 = ((self.dict as AnyObject).value(forKey:"vendor_id") as? Int!)!
        self.product_id =  ((self.dict as AnyObject).value(forKey:"product_id") as? Int)!
         self.product_log_id  =   ((self.dict as AnyObject).value(forKey:"product_logs_id") as? Int)!
        self.vender_id  =  NSString(format: "%d",(self.dict as NSMutableDictionary).value(forKey:"variation_id") as! Int) as String
//         self.vender_id  =  NSString(format: "%d",((self.dict as AnyObject).value(forKey:"variation_id") as? Int)!)
        let shippingID =  NSString(format: "%d",((self.dict as AnyObject).value(forKey:"vendor_id") as? Int)!) as String
        let thumb = (self.dict  as AnyObject).value(forKey:"product_display_img")  as! String
        self.prodNameLbl.text = (self.dict  as AnyObject).value(forKey:"product_name")  as? String
        let urls: NSURL =   NSURL(string: thumb)!
        self.prodImg.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
        self.descLbl.text = (self.dict  as AnyObject).value(forKey:"product_description")  as? String

        let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/product_details.php?shipping_vendor_id=%d&product_id=%d&product_log_id=%d&variation_id=%@&vendor_id=%d&customer_id=%@",defaults.value(forKey:"venderArr") as! CVarArg,self.product_id,self.product_log_id,self.vender_id ,self.vender_id1,defaults.value(forKey:"user_id") as! CVarArg) as String
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
                    print(jsonResult)
                    let tem = jsonResult.value(forKey: "status") as! Int
                    if tem==200
                        
                    {
                        
                        print (jsonResult)
                      //  self.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
                        let bannerArr:NSArray = jsonResult.value(forKey: "product_size") as! NSArray
                     self.imgArray = jsonResult.value(forKey: "product_images") as! NSArray as! NSMutableArray
                         let product_details:NSDictionary = jsonResult.value(forKey: "product_details") as! NSDictionary
                        self.descLbl.text = product_details.value(forKey: "product_description") as! String?
                        self.prodCost.text =  NSString(format:"%0.2f ADE",(product_details.value(forKey: "price") as? Float)!)as String
                         // self.ratingCount.text = product_details.value(forKey: "average_rating") as! String?
                           self.ratingCount.text = NSString(format:"%0.1f", (product_details.value(forKey:"average_rating")as? Float)!)as String
                        //check_wishlist_product
                        let ourRating = product_details.value(forKey:"average_rating")as? Float
                        if ourRating == 0.5 {
                            self.starImg1.image = self.halfStarImage
                        }
                        if ourRating == 1 {
                            self.starImg1.image = self.fullStarImage
                        }
                        if ourRating == 1.5 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.halfStarImage
                        }
                        if ourRating == 2 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                        }
                        if ourRating == 2.5 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.halfStarImage
                        }
                        if ourRating == 3 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.fullStarImage
                        }
                        if ourRating == 3.5 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.fullStarImage
                            self.starImg4.image = self.halfStarImage
                        }
                        if ourRating == 4 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.fullStarImage
                            self.starImg4.image = self.fullStarImage
                        }
                        if ourRating == 4.5 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.fullStarImage
                            self.starImg4.image = self.fullStarImage
                            self.starImg5.image = self.halfStarImage
                        }
                        if ourRating == 5 {
                            self.starImg1.image = self.fullStarImage
                            self.starImg2.image = self.fullStarImage
                            self.starImg3.image = self.fullStarImage
                            self.starImg4.image = self.fullStarImage
                            self.starImg5.image = self.fullStarImage
                        }
                        
                       if self.imgArray.count != 0
                            {
                                self.collectionView.reloadData()
                        }
                        if bannerArr.count != 0
                        {
                            self.filterArr = bannerArr as! NSMutableArray
                            self.FilterTable.reloadData()
                        }

                        //   self.mainBannerArr = jsonResult.value(forKey: "array_vendor_offer") as! NSMutableArray
                        for i in 0..<bannerArr.count
                        {
                            
                            self.objArr.append(((bannerArr[i]as AnyObject).value(forKey:"size_name") as? String)!)
                            
                            
                        }
                       // self.setupChooseArticleDropDown()

                        
                        
                        
                        
                        
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

    //http://test.tranzporthub.com/sellekt/product_details.php?shipping_vendor_id=1,2,3&product_id=71&product_log_id=95&variation_id=181&vendor_id=1&customer_id=
    @IBAction func selectSize(_ sender: UIButton) {
      //  chooseArticleDropDown.show()
        self.FilterTable.isHidden = false

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var index:Int = 0
        
            index = self.filterArr.count
                return index
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "cell"

            let cell:UITableViewCell = self.FilterTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            cell.textLabel?.text = (self.filterArr[indexPath.row] as AnyObject).value(forKey: "size_name")  as? String
            
            
            return cell
            
            
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.FilterTable.isHidden = true
            let filter = (self.filterArr.object(at: indexPath.row) as AnyObject).value(forKey:"size_name")  as! String
            if  filter  == self.vender_id
            {
                
            }
            else
            {
                self.vender_id = filter
                self.loadData()
            }
        }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var index : Int = 0
        
            index = self.imgArray.count
        return index
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! homeCell
            let thumb = (self.imgArray[indexPath.row] as AnyObject).value(forKey:"product_image")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
        
        cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4
            
            return cell
            
        }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddCart(_ sender: Any) {
        
       let vender_id =   (self.dict as AnyObject).value(forKey:"vendor_id")  as? Int
        var flag:Bool = false
        var vender_id1:Int = 0
         if let path1 = UserDefaults.standard.object(forKey: "cart")
         {
            let path = UserDefaults.standard.object(forKey: "cart") as! NSArray
            let mainCatArr:NSMutableArray = []

            for row in 0...(path.count - 1) {
                let cell = path[row] as! NSDictionary
              //  cell.setValue(1, forKey: "quantity")
                
              //  cell.setValue("Cart", forKey: "order_type")
             //   cell.setValue("Unpaid", forKey: "payment_status")
                
                mainCatArr.add(cell)

                  vender_id1 = (cell.value(forKey: "vendor_id") as? Int)!
                flag = true

                           }
            if vender_id1  == vender_id
            {
                
                if flag
                {
                    
                    let cell = self.dict as NSMutableDictionary
                    cell.setValue(Int(self.qtyCount.text!)!, forKey: "quantity")
                    
                    cell.setValue("Cart", forKey: "order_type")
                    cell.setValue("Unpaid", forKey: "payment_status")
                    
                    mainCatArr.add(cell)
                       UserDefaults.standard.setValue(mainCatArr, forKey: "cart")
                    
                }
            

                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                    
                  //  loginPageView.dict = self.dict
                    
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
                        UserDefaults.standard.removeObject(forKey: "cart")

                        let cell = self.dict as NSMutableDictionary
                        cell.setValue(Int(self.qtyCount.text!)!, forKey: "quantity")
                        
                        cell.setValue("Cart", forKey: "order_type")
                        cell.setValue("Unpaid", forKey: "payment_status")
                        
                        mainCatArr.add(cell)
                        UserDefaults.standard.setValue(mainCatArr, forKey: "cart")
                    }
                    actionSheetController.addAction(nextAction)
                      self.present(actionSheetController, animated: true, completion: nil)
                }
        
            
         }
        else
         {
            let mainCatArr:NSMutableArray = []

            let cell = self.dict as NSMutableDictionary
            cell.setValue(Int(self.qtyCount.text!)!, forKey: "quantity")
            
            cell.setValue("Quotation", forKey: "order_type")
            cell.setValue("Unpaid", forKey: "payment_status")
            
            mainCatArr.add(cell)
            UserDefaults.standard.setValue(mainCatArr, forKey: "cart")
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
          //  self.dict.setValue(1, forKey: "qty")

        loginPageView.dict = self.dict
        
        self.navigationController?.pushViewController(loginPageView, animated: true)
        
        }
    }

    
}
