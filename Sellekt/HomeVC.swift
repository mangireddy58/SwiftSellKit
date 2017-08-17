//
//  HomeVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 22/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit
import DropDown
import CoreLocation
import MultiAutoCompleteTextSwift
import SDWebImage

class HomeVC: BaseViewController_rafrral,KWBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate,UITextFieldDelegate {
   
    var activityIndicator = UIActivityIndicatorView()
    var locationManager: CLLocationManager!
    var location : CLLocation!
    var flag : Bool = true
    @IBOutlet var historyView: UIView!

    @IBOutlet var ring5: UIImageView!
    @IBOutlet var locationRxt: UITextField!
    @IBOutlet var topBanner: KWBannerView!
    @IBOutlet var listBtn: UIBarButtonItem!
    @IBOutlet var locationBtn: UIBarButtonItem!
    @IBOutlet var locationPopup: UIView!
    @IBOutlet var contryTxt: UITextField!
    @IBOutlet var cityTxt: UITextField!
    @IBOutlet var streetTxt: UITextField!
    @IBOutlet var ring1: UIImageView!
    @IBOutlet var ring2: UIImageView!
    @IBOutlet var ring3: UIImageView!
    @IBOutlet var ring4: UIImageView!
    @IBOutlet weak var productSearch: UITextField!
  //  @IBOutlet weak var locationSearch: MultiAutoCompleteTextField!
    @IBOutlet var venderTable: UITableView!
    @IBOutlet var productTable: UITableView!

    @IBOutlet weak var venderSearch: UITextField!
    @IBOutlet var topOfferCollection: UICollectionView!
    @IBOutlet var bottomBanner: KWBannerView!
    @IBOutlet var compareCollection: UICollectionView!
    @IBOutlet var bottomOfferCollection: UICollectionView!
    @IBOutlet var historyTable: UITableView!
    @IBOutlet var partnerDisc: UITextView!
    @IBOutlet var partnerCollection: UICollectionView!
    @IBOutlet var scrollVC: UIScrollView!
      let defaults = UserDefaults.standard
    var topOfferArr:NSMutableArray = []
    var bottomOfferArr:NSMutableArray = []
    var topBannerArr:NSMutableArray = []
    var bottomBannerArr:NSMutableArray = []
    var compareProductArr:NSMutableArray = []
    var compareProductLisrArr:NSArray = []
    var searchVenderArr:NSArray = []
    var setLocationArr:NSArray = []
    var partnerCollectionArr:NSArray = []
    var venderArr:NSArray = []
    var venderString:NSString = ""
    var historyArr:NSMutableArray = []
    var locationArr:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        self.scrollVC.addSubview(self.activityIndicator)
         let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)

        self.navigationItem.titleView = imageView

        let sz = CGSize(width: view.frame.width, height: 2900)
        
        self.scrollVC.contentSize = sz
        navigationController!.setNavigationBarHidden(false, animated:true)
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        else
        {
            defaults.set("0", forKey: "lati")
            defaults.set("0", forKey: "longi")

            defaults.set(false, forKey: "isLocation")
            loadDataStep1()

            if  defaults.bool(forKey:"isAddress")
            {
                //let thumb = defaults.stringForKey("referral_thumbnail");
              //  loadDataStep2()
                
            }
            else
            {
               // self.locationPopup.isHidden = false;
            }
          //  let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height+980)
           

        }
       /*  self.locationRxt.onSelect = {  str, indexPath in
           // self?.inputText.text = "Selected word: \(str)"
        }
       // self.locationRxt.
         self.scrollVC.bringSubview(toFront: self.locationRxt.autoCompleteTableView!)
//self.locationRxt.willMove(toSuperview: self.scrollVC)
//        self.venderString.willMove(toSuperview: self.view);
//        self.productSearch.willMove(toSuperview: self.view);

        self.locationRxt.onTextChange = {[weak self] str in
            
            // self?.inputText.text = "Selected word: \(str)"
            
        }
        self.productSearch.onTextChange = {[weak self] str in
            
            // self?.inputText.text = "Selected word: \(str)"
            
        }
        self.venderSearch.onTextChange = {[weak self] str in
            
            // self?.inputText.text = "Selected word: \(str)"
            
        }*/
        
          // Do any additional setup after loading the view.
       // self.scrollVC.contentSize(self.view.frame.size.width,1700)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSlideMenuButton()
        
    }
    func dismissKeyboard() {
       // view.endEditing(true)
         
        // do aditional stuff
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField == self.contryTxt
        {
           self.cityTxt.becomeFirstResponder()
        }
        if textField == self.contryTxt
        {
            self.cityTxt.becomeFirstResponder()
        }
        if textField == self.cityTxt
        {
            self.streetTxt.becomeFirstResponder()
        }
        if textField == self.streetTxt
        {
            self.streetTxt.resignFirstResponder()
        }
        if textField == self.venderSearch
        {
            self.venderSearch.resignFirstResponder()
        }
        if textField == self.productSearch
        {
            self.productSearch.resignFirstResponder()
        }
        if textField == self.locationRxt
        {
            self.locationRxt.resignFirstResponder()
        }
       // textField.resignFirstResponder()i
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        
        
                if flag
        {
            location = locations.last! as CLLocation
            defaults.set(location.coordinate.latitude, forKey: "lati")
            defaults.set(location.coordinate.longitude, forKey: "longi")
            defaults.set(true, forKey: "isLocation")
            loadDataStep1()

        }
        
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        if textField == locationRxt {
            
            self.scrollVC.setContentOffset(
                CGPoint(x: 0,y: textField.frame.origin.y+40),
                animated: true)
            
        }
        else if textField == productSearch {
            
            
            self.scrollVC.setContentOffset(
                CGPoint(x: 0,y: productSearch.frame.origin.y+600),
                animated: true)
            
            
            
            
        }
        
        
    }

      func textField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange,
                            replacementString string: String) -> Bool
    {
        if (textField == self.venderSearch)
            
        {
            self.loadDataVender(textField: string)
           // self.venderSearch.isEnabled = false
            //self.venderSearch.text = string
        }
        if (textField == self.productSearch)
            
        {
            self.loadDataCompareProd(textField: string)
           // self.productSearch.isEnabled = false
          //  self.productSearch.text = string

        }

          return true;
    }
  /*    func text(_ textField: UITextField) {
        if (textField == self.venderSearch)
            
        {
            self.loadDataVender(textField: self.venderSearch.text!)
            self.venderSearch.isEnabled = false
        }
        if (textField == self.productSearch)
            
        {
            self.loadDataCompareProd(textField: self.venderSearch.text!)
            self.productSearch.isEnabled = false
        }

    }
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.venderSearch)
            
        {
            self.loadDataVender(textField: self.venderSearch.text!)
            self.venderSearch.isEnabled = false
        }
        if (textField == self.productSearch)
            
       {
            self.loadDataCompareProd(textField: self.venderSearch.text!)
            self.productSearch.isEnabled = false
        }

        return true;
    }*/
    func loadDataVender(textField: String){
         if (textField.characters.count != 0)
         {
            //NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/autocomplete_vendor_business_name.php?vendor_business_name_search_keyword=%@&shipping_vendor_id=%@&@",searchText,venderStrs];

            let request: NSMutableURLRequest = NSMutableURLRequest()
            var url = NSString(format:"http://sellekt.teamdaphnisys.in/autocomplete_vendor_business_name.php?vendor_business_name_search_keyword=%@&shipping_vendor_id=%@",textField,self.venderString) as String
             url = url.removingWhitespaces()
            self.activityIndicator.isHidden = false;
            self.activityIndicator.startAnimating()
            
            request.url = NSURL(string: url as String) as URL?
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
                            
                            let dict:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
                                                        var inputTextTokens:[String] = []
                            self.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
                                                        
                           if self.venderArr.count == 0
                            {
                                self.venderSearch.isEnabled = true
                                
                            }
                            else
                            {
                                self.venderTable.reloadData()
                                self.venderTable.isHidden = false
                                
                                
                            }

                            //let thumb = defaults.stringForKey("referral_thumbnail");
                          //  self.venderSearch.autoCompleteStrings = inputTextTokens
                            
                            
                            
                            
                            
                        }
                        else
                        {
                            
                            
                        }
                        
                    }
                }
            }
            

            
        }
    }
    func loadDataCompareProd(textField: String){
        if (textField.characters.count != 0)
        {
       //    http://test.tranzporthub.com/sellekt/home_page_autocomplete_product_name_step4.php?shipping_vendor_id=1,2,3&search_product_keyword=b
            
            let request: NSMutableURLRequest = NSMutableURLRequest()
            var url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_autocomplete_product_name_step4.php?shipping_vendor_id=%@&search_product_keyword=%@",self.venderString,textField) as String
            url = url.removingWhitespaces()
            self.activityIndicator.isHidden = false;
            self.activityIndicator.startAnimating()
            
            request.url = NSURL(string: url as String) as URL?
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
                            
                            let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                             self.compareProductLisrArr = dict.value(forKey: "home_page_search_product") as! NSMutableArray
                            
                            if self.compareProductLisrArr.count == 0
                            {
                                self.productSearch.isEnabled = true

                            }
                            else
                            {
                                self.productTable.reloadData()
                                self.productTable.isHidden = false
                                
                                
                            }
                            //let thumb = defaults.stringForKey("referral_thumbnail");
                            //  self.venderSearch.autoCompleteStrings = inputTextTokens
                            
                            
                            
                            
                            
                        }
                        else
                        {
                            
                            
                        }
                        
                    }
                }
            }
            
            
            
        }
    }
    func loadDataCompareProdCollection(textField: String){
        if (textField.characters.count != 0)
        {
            //    http://test.tranzporthub.com/sellekt/home_page_autocomplete_product_name_step4.php?shipping_vendor_id=1,2,3&search_product_keyword=b
            
          //  http://test.tranzporthub.com/sellekt/home_page_autocomplete_top3_product_step5.php?shipping_vendor_id=1,2,3&search_product_keyword=b
            
            let request: NSMutableURLRequest = NSMutableURLRequest()
            var url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_autocomplete_top3_product_step5.php?shipping_vendor_id=%@&search_product_keyword=%@",self.venderString,textField) as String
            url = url.removingWhitespaces()
            self.activityIndicator.isHidden = false;
            self.activityIndicator.startAnimating()
            
            request.url = NSURL(string: url as String) as URL?
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
                            
                            let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                            let newArr = dict.value(forKey: "home_page_top3_product") as! NSMutableArray
                            
                            if newArr.count == 0
                            {
                               // self.productSearch.isEnabled = true
                                self.compareProductArr = newArr
                            }
                                
                            else
                            {
                                self.compareCollection.reloadData()
                               // self.compareProductArr.isHidden = false
                                
                                
                            }
                            //let thumb = defaults.stringForKey("referral_thumbnail");
                            //  self.venderSearch.autoCompleteStrings = inputTextTokens
                            
                            
                            
                            
                            
                        }
                        else
                        {
                            
                            
                        }
                        
                    }
                }
            }
            
            
            
        }
    }


     func loadDataStep1() {
        flag = false
        let request: NSMutableURLRequest = NSMutableURLRequest()
      //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/home_page_step1.php?customer_id=%@&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",user_id,currentLatitude,currentLongitude ];

        let url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_step1.php?customer_id=%d&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",defaults.value(forKey:"user_id") as! Int,defaults.float(forKey:"lati"),defaults.float(forKey:"longi") ) as String
        let trimmedString = url.removingWhitespaces()

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
                        let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                         self.topOfferArr = dict.value(forKey: "home_page_top_offer") as! NSMutableArray
                        self.bottomOfferArr = dict.value(forKey: "home_page_bottam_offer") as! NSMutableArray

                        let bannerArr:NSArray = dict.value(forKey: "home_page_all_banner") as! NSArray
                        let imgArray:NSArray = dict.value(forKey: "home_why_shop_with_us") as! NSArray
                        let venderArr:NSArray = dict.value(forKey: "shipping_vendor_id") as! NSArray
                        self.partnerCollectionArr = dict.value(forKey: "home_partner_with_us") as! NSArray
                            let mainCatArr:NSMutableArray = []
                         let catArr:NSArray = dict.value(forKey: "all_category_subcategory_array") as! NSArray
                         for row in 0...(catArr.count - 1)
                         {
                            let cell = catArr[row] as! NSMutableDictionary
                             cell.setValue(true, forKey: "isExpandable")
                             cell.setValue(false, forKey: "isVisible")
                            cell.setValue(false, forKey: "isExpanded")
                            mainCatArr.add(cell)
                            
                        }
                        let datas:NSMutableDictionary = [:]
                        datas.setObject("View All", forKey: "category_name" as NSCopying)
                        datas.setObject(0, forKey: "category_id" as NSCopying)
                        mainCatArr.add(datas)
                        let datas1:NSMutableDictionary = [:]
                        datas1.setObject("Logout", forKey: "category_name" as NSCopying)
                        datas1.setObject(-1, forKey: "category_id" as NSCopying)
                        mainCatArr.add(datas1)


                        self.defaults.set(mainCatArr, forKey: "cat")
                        let partnerDetailStr:NSString = dict.value(forKey: "home_page_partner_with_us_description") as! NSString
                        self.partnerDisc.text = partnerDetailStr as String
                        for i in 0..<imgArray.count
                        {
                            let thumb = (imgArray[i] as AnyObject).value(forKey:"image_path")  as! String

                            let urls: NSURL =   NSURL(string: thumb)!
                           
                            switch i
                            {
                            case 0:
                                self.ring1.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
                             //   Nuke.loadImage(with: urls as URL, into: self.ring1)
                                
                                break
                            case 1:
                                self.ring2.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
                                
                                break
                            case 2:
                                self.ring3.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
                                
                                break
                            case 3:
                                self.ring4.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
                                
                                break
                            case 4:
                                self.ring5.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))
                                
                                break

                                default:
                                break
                                
                            }
                            
                        }
                       for i in 0..<bannerArr.count
                        {
                            let page = (bannerArr[i] as AnyObject).value(forKey:"banner_type") as? String
                            if   page == "Home_Top"
                            {
                                self.topBannerArr.add((bannerArr[i]as AnyObject).value(forKey:"image_path") as? String)
                            }
                            else
                            {
                             
                                self.bottomBannerArr.add((bannerArr[i]as AnyObject).value(forKey:"image_path") as? String)

                                //self.bottomBannerArr.add(bannerArr[i])
                                
                            }
                        }
                        self.topBanner.delegate = self;
                        self.topBanner.imagesURLs = self.topBannerArr
                        self.topBanner.isAutoScroll = true
                        self.topBanner.drawBannerNew()
                        self.bottomBanner.delegate = self;
                        self.bottomBanner.imagesURLs = self.bottomBannerArr
                        self.bottomBanner.isAutoScroll = true
                        self.bottomBanner.drawBannerNew()
                        if venderArr.count == 0
                        {
                            if  self.defaults.bool(forKey:"isAddress")
                            {
                                //let thumb = defaults.stringForKey("referral_thumbnail");
                                self.loadDataStep2()
                                
                            }
                            else
                            {
                                self.locationPopup.isHidden = false;
                            }
                            
                        }
                        else
                        {
                            let string = venderArr.componentsJoined(by: ",")
                            self.venderString = string as NSString
                            if  ((self.defaults.object(forKey:"user_id")) != nil){
                                if  (self.defaults.object(forKey:"user_id") as! Int == 0){
                                    self.loadDataStep4()
                                    self.historyView.isHidden = true

                                    

                                }
                                else
                                {
                                    self.loadDataStep3()
                                    self.historyView.isHidden = false

                                }
                            }
                            self.defaults.set(string, forKey: "venderArr")

                        }
                        print( self.venderString)

//                        NSArray *cat_array = [returnArray valueForKey:@"all_category_subcategory_array"];
//                        NSArray *banner_array = [returnArray valueForKey:@"home_page_all_banner"];
//                        NSArray *offer_array = [returnArray valueForKey:@"home_page_offer"];
//                        NSString *partner_desc = [returnArray valueForKey:@"home_page_partner_with_us_description"];
//                        bottomPartnerArr=[[NSMutableArray alloc]init];
//                        NSArray *imgArray = [returnArray valueForKey:@"home_why_shop_with_us"];

                        if  self.topOfferArr.count != 0{
                        self.topOfferCollection.reloadData()
                        }
                        if  self.bottomOfferArr.count != 0{
                            self.bottomOfferCollection.reloadData()
                        }
                        if  self.partnerCollectionArr.count != 0{
                            self.partnerCollection.reloadData()
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
    func loadDataStep2() {
       // NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/home_page_offer_step2.php?customer_id=%@&shipping_vendor_id=&street_name=%@&city_name=%@&country_name=%@&offer_page=Home_Bottom&offer_start_limit=0&offer_end_limit=20&flag=2",user_id,self.streetText.text,self.cityText.text,self.contryText.text];

        let request: NSMutableURLRequest = NSMutableURLRequest()
        //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/home_page_step1.php?customer_id=%@&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",user_id,currentLatitude,currentLongitude ];
              let url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_offer_step2.php?customer_id=%@&shipping_vendor_id=&street_name=%@&city_name=%@&country_name=%@&offer_page=Home_Bottom&offer_start_limit=0&offer_end_limit=20&flag=2",defaults.value(forKey:"user_id") as! CVarArg,defaults.value(forKey: "state") as! CVarArg,defaults.value(forKey: "city") as! CVarArg,defaults.value(forKey: "contry") as! CVarArg) as String
          // post = [post stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
        let trimmedString = url.removingWhitespaces()
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
                      //  NSString *addressStr = [NSString stringWithFormat:@"%@ , %@",[returnArray valueForKey:@"street_name"],[returnArray valueForKey:@"city_name"]];
                        let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                        self.topOfferArr = dict.value(forKey: "home_page_top_offer") as! NSMutableArray
                        self.bottomOfferArr = dict.value(forKey: "home_page_bottam_offer") as! NSMutableArray
                        let venderArr:NSArray = dict.value(forKey: "shipping_vendor_id") as! NSArray
                                                        //let thumb = defaults.stringForKey("referral_thumbnail");
                        let Addstring = NSString(format: "%@  %@", dict.value(forKey: "street_name") as!NSString, dict.value(forKey: "city_name") as!NSString )
                        
                                self.locationRxt.text = Addstring as String
                        if  self.topOfferArr.count != 0{
                            DispatchQueue.main.async {
                            self.topOfferCollection.reloadData()
                            }
                        }
                        if  self.bottomOfferArr.count != 0{
                            DispatchQueue.main.async {
                            self.bottomOfferCollection.reloadData()
                            }
                        }

                        let string = venderArr.componentsJoined(by: ",")
                         self.venderString = string as NSString
                        self.defaults.set(string, forKey: "venderArr")
                            print( self.venderString)
                        if  ((self.defaults.object(forKey:"user_id")) != nil){
                            if  (self.defaults.object(forKey:"user_id") as! Int == 0){
                                self.loadDataStep4()
                                
                            }
                            else
                            {
                                self.loadDataStep3()
                                
                            }
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
     func loadDataStep3() {
        
      //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/home_page_shipping_address_order_history.php?customer_id=1&address_flag=Yes&order_flag=Yes&order_history_start_limit=0&order_history_end_limit=100" ];

        let request: NSMutableURLRequest = NSMutableURLRequest()
              let url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_shipping_address_order_history.php?customer_id=1&address_flag=Yes&order_flag=Yes&order_history_start_limit=0&order_history_end_limit=100") as String
        let trimmedString = url.removingWhitespaces()
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
                        
                        let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                        self.historyArr = dict.value(forKey: "customer_order_history") as! NSMutableArray
                        self.locationArr = dict.value(forKey: "customer_shipping_address") as! NSMutableArray
                        var inputTextTokens:[String] = []
                        for i in 0..<self.locationArr.count
                        {
                           // street_name":"SB Road","city_name":"Bilaspur","Country_name":"India"
                            let Addstring = NSString(format: "%@ , %@ , %@", (self.locationArr[i]as AnyObject).value(forKey: "street_name") as!NSString, (self.locationArr[i]as AnyObject).value(forKey: "city_name") as!NSString, (self.locationArr[i]as AnyObject).value(forKey: "Country_name") as!NSString )

                            inputTextTokens.append(Addstring as String)
                        }

                         //let thumb = defaults.stringForKey("referral_thumbnail");
                          //self.locationRxt.autoCompleteStrings = inputTextTokens
                         if  self.historyArr.count != 0{
                            DispatchQueue.main.async {
                            self.historyTable.reloadData()
                            }
                        }
                        
                        self.loadDataStep4()

                        
                        
                        
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
    func loadDataStep4() {
        let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/home_page_autocomplete_top3_product_step5.php?shipping_vendor_id=%@&search_product_keyword",defaults.value(forKey:"venderArr") as! CVarArg) as String
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
                        
                        let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                        self.compareProductArr = dict.value(forKey: "home_page_top3_product") as! NSMutableArray
                        
                        if  self.compareProductArr.count != 0{
                            DispatchQueue.main.async {
                                self.compareCollection.reloadData()
                            }
                        }
                        
                       // self.loadDataStep4()
                        
                        
                        
                        
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var index : Int = 0
        if collectionView == self.topOfferCollection
        {
            index = topOfferArr.count
        }
        if collectionView == self.bottomOfferCollection
        {
            index = bottomOfferArr.count
        }
        if collectionView == self.compareCollection
        {
            index = compareProductArr.count
        }
        if collectionView == self.partnerCollection
        {
            index = partnerCollectionArr.count
        }

        return index
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topOfferCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! homeCell
            let thumb = (self.topOfferArr[indexPath.row] as AnyObject).value(forKey:"image_path")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
             cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.png"))

         //   Nuke.loadImage(with: urls as URL, into: cell.imgView)
             cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4

            return cell

         }
        if collectionView == self.bottomOfferCollection
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! homeCell
            let thumb = (self.bottomOfferArr[indexPath.row] as AnyObject).value(forKey:"image_path")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
            cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4

            return cell

        }
        if collectionView == self.compareCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
            let thumb = (self.compareProductArr[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))

             cell.venderName.text = (self.compareProductArr[indexPath.row] as AnyObject).value(forKey:"business_name")  as? String
            cell.prodName.text = (self.compareProductArr[indexPath.row] as AnyObject).value(forKey:"product_name")  as? String
            cell.qtyName.text = (self.compareProductArr[indexPath.row] as AnyObject).value(forKey:"size_name")  as? String
          cell.costName.text = NSString(format: "%d", ((self.compareProductArr[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as! Int)) as String
             cell.backgroundColor = UIColor.white
            cell.addBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
            cell.addBtn.addTarget(self, action: #selector(HomeVC.AddCart(_:)), for: UIControlEvents.touchUpInside)
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4
            return cell
//            NSURL *url = [NSURL URLWithString:[[arr2 objectAtIndex:indexPath.row]valueForKey:@"product_display_img"]];
//            [cell.prodImg  sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
//            cell.venderName.text = [[arr2 objectAtIndex:indexPath.row]valueForKey:@"business_name"];
//            cell.costName.text = [NSString stringWithFormat:@"%@",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"display_mrp_price"]];
//            cell.productName.text = [[arr2 objectAtIndex: ]valueForKey:@"product_name"];
//            cell.qtyName.text = [[arr2 objectAtIndex:indexPath.row]valueForKey:@"size_name"];

        }
        if collectionView == self.partnerCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! homeCell
            let thumb = (self.partnerCollectionArr[indexPath.row] as AnyObject).value(forKey:"image_path")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
//            cell.backgroundColor = UIColor.white
//            
//            // add a border
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 1
//            cell.layer.cornerRadius = 4

            return cell

        }
else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
            
            return cell

        }
        
    }
     @IBAction func AddLocationPopup(_ sender: UIButton) {
         self.locationPopup.isHidden = false
        if  defaults.bool(forKey:"isAddress")
        {
        self.contryTxt.text = defaults.value(forKey:"contry") as! String?
            self.cityTxt.text = defaults.value(forKey:"city") as! String?
            self.streetTxt.text = defaults.value(forKey:"state") as! String?

        
        }
    }
    @IBAction func AddLocation(_ sender: UIButton) {
        if ((self.contryTxt.text?.characters.count)! > 0)
        {
            if ((self.cityTxt.text?.characters.count)! > 0)
            {
                if ((self.streetTxt.text?.characters.count)! > 0)
                {
                    defaults.set(true, forKey: "isAddress")

                    defaults.set(self.contryTxt.text, forKey: "contry")
                    defaults.set(self.cityTxt.text, forKey: "city")
                    defaults.set(self.streetTxt.text, forKey: "state")
                    defaults.synchronize()
                    loadDataStep2()
                    self.locationPopup.isHidden = true

                }
                else
                {
                    DispatchQueue.main.async {
                                               
                        let altMessage = UIAlertController(title: "Error", message:"Enter Street Name", preferredStyle: UIAlertControllerStyle.alert)
                        altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(altMessage, animated: true, completion: nil)
                    }
                    
            }
            }
                else
                {
                    DispatchQueue.main.async {
                        
                        let altMessage = UIAlertController(title: "Error", message:"Enter City Name", preferredStyle: UIAlertControllerStyle.alert)
                        altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(altMessage, animated: true, completion: nil)
                    }
        }
    
        }
        else
        {
            DispatchQueue.main.async {
                
                let altMessage = UIAlertController(title: "Error", message:"Enter Country Name", preferredStyle: UIAlertControllerStyle.alert)
                altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(altMessage, animated: true, completion: nil)
            }
        }
    }
    @IBAction func list_Btn(_ sender: UIButton) {
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
                let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "uploadList") as! uploadList
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
    @IBAction func CompareBtn(_ sender: UIButton) {
         if (self.productSearch.text?.characters.count != 0)
         {
         self.loadDataCompareProdCollection(textField: self.productSearch.text!)
        }
    }
    @IBAction func JoinUs(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ind:Int = 0
        if tableView == historyTable{
            ind =  self.historyArr.count}
        if tableView == venderTable{
            ind =  self.venderArr.count}
        if tableView == productTable{
            ind =  self.compareProductLisrArr.count}

    
    return ind
}
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cellReuseIdentifier = "cell"
        if tableView == historyTable{
            let identifier = "cell"
            // let cell: historyCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? historyCell
            //String phonStr =
            let cell:historyCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! historyCell
            cell.venderLbl.text = (self.historyArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String
            cell.dateLbl.text =  NSString(format:"%@", ((self.historyArr[indexPath.row] as AnyObject).value(forKey:"created_datetime")as? String)!) as String
            cell.amtLbl.text =  NSString(format:"%d", ((self.historyArr[indexPath.row] as AnyObject).value(forKey:"net_total")as? Int)!) as String
            
            
            
            return cell

        }
        if tableView == venderTable{
            
            let cell:UITableViewCell = self.venderTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            cell.textLabel?.text = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"business_name") as? String

            
            return cell
        }
        if tableView == productTable{
            let cell:UITableViewCell = self.productTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            cell.textLabel?.text = (self.compareProductLisrArr[indexPath.row] as AnyObject).value(forKey:"product_name") as? String

            // set the text from the data model
          //  cell.textLabel?.text = self.animals[indexPath.row]
            
            return cell
        }
        else
        {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
            
            // set the text from the data model
            
            return cell
        }

           }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
        if collectionView == self.topOfferCollection
        {
            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
           let offer_id =   (self.topOfferArr[indexPath.row] as AnyObject).value(forKey:"discount_percentage")  as! String
              let vender_id =   (self.topOfferArr[indexPath.row] as AnyObject).value(forKey:"vendor_id")  as! Int
            loginPageView.vender_id = vender_id
            loginPageView.offer_id = offer_id
            loginPageView.dict =  self.topOfferArr[indexPath.row] as! NSMutableDictionary
            //vendor_id":1,"offer_page":"Home_Top","discount_percentage
            self.navigationController?.pushViewController(loginPageView, animated: true)

        }
        if collectionView == self.bottomOfferCollection
        {
            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
            let offer_id =   (self.bottomOfferArr[indexPath.row] as AnyObject).value(forKey:"discount_percentage")  as! String
            let vender_id =   (self.bottomOfferArr[indexPath.row] as AnyObject).value(forKey:"vendor_id")  as! Int
           loginPageView.dict =  self.bottomOfferArr[indexPath.row] as! NSMutableDictionary
            loginPageView.vender_id = vender_id
            loginPageView.offer_id = offer_id
            //vendor_id":1,"offer_page":"Home_Top","discount_percentage
                        self.navigationController?.pushViewController(loginPageView, animated: true)

        }
        
        
        /*  if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
         cellLabels[indexPath.row] as String
         cellImages[indexPath.row] as String
         }*/
//        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! productDetailsVC
//        if collectionView == self.subProductArrTopCollectionView
//        {
//            loginPageView.dict = self.subProductArrTop[indexPath.row] as! NSMutableDictionary
//            
//        }
//        if collectionView == self.subProductArrMiddelCollectionView
//        {
//            loginPageView.dict = self.subProductArrMiddel[indexPath.row] as! NSMutableDictionary
//            
//            // index = subProductArrMiddel.count
//        }
        if collectionView == self.compareCollection
        {
            
            // index = subProductArrBottom.count
        }
        
        
        
    }
    

    @IBAction func AddCart(_ sender: UIButton) {
         let buttonRow = sender.tag
       let vender_id =   (self.compareProductArr[buttonRow] as AnyObject).value(forKey:"vendor_id")  as? Int
        let dict:NSMutableDictionary = self.compareProductArr[buttonRow] as! NSMutableDictionary
        
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let path = UserDefaults.standard.object(forKey: "cart") as! NSMutableArray
            for row in 0...(path.count - 1) {
                let cell = path[row] as! NSDictionary
                if cell.value(forKey: "vendor_id") as? Int == vender_id
                {
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                     dict.setValue(1, forKey: "qty")
                    loginPageView.dict = dict
                    
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
            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
            dict.setValue(1, forKey: "qty")
            loginPageView.dict = dict
            
            self.navigationController?.pushViewController(loginPageView, animated: true)
            
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.venderTable.isHidden = true
        self.productTable.isHidden = true
         if tableView == venderTable{
            
            let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
            loginPageView.dict = self.venderArr[indexPath.row] as! NSMutableDictionary
            self.navigationController?.pushViewController(loginPageView, animated: true)
        }
        if tableView == productTable{
            //loadDataCompareProdCollection
             let str = (self.compareProductLisrArr[indexPath.row] as AnyObject).value(forKey:"product_name") as? String
            self.loadDataCompareProdCollection(textField: str!)
        }


        print("You tapped cell number \(indexPath.row).")
    }
    func Event_buttonClicked(sender:UIButton) {
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
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
