//
//  productsVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 24/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit
import SDWebImage
class productsVC: BaseViewController_rafrral ,UICollectionViewDataSource,UICollectionViewDelegate,KWBannerViewDelegate{
    var mainBannerArr:NSMutableArray = []
    var subProductArrTop:NSMutableArray = []
    var subProductArrMiddel:NSMutableArray = []
    var subProductArrBottom:NSMutableArray = []
    @IBOutlet var subProductArrTopCollectionView: UICollectionView!
    @IBOutlet var subProductArrMiddelCollectionView: UICollectionView!
    @IBOutlet var subProductArrBottomCollectionView: UICollectionView!
    @IBOutlet var topBanner: KWBannerView!
    @IBOutlet var scrollVC: UIScrollView!
    var offer_id:String = ""
    var vender_id:Int = 0

    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var dict: NSMutableDictionary!
    var venderID:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        let sz = CGSize(width: view.frame.width, height: view.frame.height+170)
        self.scrollVC.contentSize = sz

        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        self.venderID =  NSString(format: "%d",vender_id) as String
    //    navigationController!.setNavigationBarHidden(true, animated:true)
        
        loadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.setNavigationBarHidden(false, animated:true)
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
         self.navigationItem.titleView = imageView
 
 
    }
    @IBAction func createList(_ sender: UIBarButtonItem) {
    }
    @IBAction func seeAllBest(_ sender: UIButton) {
                   let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "seeAllProduct") as! seeAllProduct
        loginPageView.mainBannerArr = self.mainBannerArr

            loginPageView.subProductArrTop = self.subProductArrTop
            loginPageView.venderID = "Best Product"
            self.navigationController?.pushViewController(loginPageView, animated: true)
            
            
      
    }
     @IBAction func seeAllSpecialDeal(_ sender: UIButton) {
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "seeAllProduct") as! seeAllProduct
        
        loginPageView.subProductArrTop = self.subProductArrMiddel
        loginPageView.venderID = " Special Product"
        loginPageView.mainBannerArr = self.mainBannerArr

        self.navigationController?.pushViewController(loginPageView, animated: true)

    }
    @IBAction func seeAllNew(_ sender: Any) {
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "seeAllProduct") as! seeAllProduct
        loginPageView.mainBannerArr = self.mainBannerArr

        loginPageView.subProductArrTop = self.subProductArrBottom
        loginPageView.venderID = " New Product"
        self.navigationController?.pushViewController(loginPageView, animated: true)

    }
   
    
    func loadData() {
        
        //  NSString  *post = [NSString stringWithFormat:@"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%@&longitude&=%@&sort_by=A_Z&vendor_business_name_search_keyword=&category_id=&subcategory_id=&vendor_start_limit=0&vendor_end_limit=100",[[NSUserDefaults standardUserDefaults]stringForKey:@"venderStr"],[[NSUserDefaults standardUserDefaults]stringForKey:@"lati" ],[[NSUserDefaults standardUserDefaults]stringForKey:@"longi" ] ];
        //  let url = NSString(format:"http://test.tranzporthub.com/sellekt/vendor_listing.php?shipping_vendor_id=%@&latitude=%f&longitude=%f&offer_start_limit=0&offer_end_limit=100&pwu_start_limit=0&pwu_end_limit=100&flag=1",defaults.value(forKey:"venderArr") as! CVarArg,defaults.float(forKey:"lati"),defaults.float(forKey:"longi") ) as String
        

         var vender_str:NSString = ""
        
               if self.vender_id == 0
        {
            vender_str = ""
            
        }
            
        else
        {
            venderID = NSString(format:"%d",self.vender_id) as String
            
        }
       
        let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:" http://sellekt.teamdaphnisys.in/listing_vendor_product.php?vendor_id=%@&display_type=&discount_percentage=%@&category_id=&subcategory_id=&=&search_keyword=&sort_by=A_Z&start_limit=0&end_limit=300",self.venderID,self.offer_id) as String
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
                        
                        self.subProductArrTop = jsonResult.value(forKey: "array_most_selling_product") as! NSMutableArray
                        self.subProductArrMiddel = jsonResult.value(forKey: "array_new_product") as! NSMutableArray
                        self.subProductArrBottom = jsonResult.value(forKey: "array_special_product") as! NSMutableArray
                        let bannerArr:NSArray = jsonResult.value(forKey: "array_vendor_offer") as! NSArray

                     //   self.mainBannerArr = jsonResult.value(forKey: "array_vendor_offer") as! NSMutableArray
                        for i in 0..<bannerArr.count
                        {
                            
                                self.mainBannerArr.add((bannerArr[i]as AnyObject).value(forKey:"image_path") as? String)
                            
                                
                            }
                        
                        self.topBanner.delegate = self;
                        self.topBanner.imagesURLs = self.mainBannerArr
                        self.topBanner.isAutoScroll = true
                        self.topBanner.drawBannerNew()

                        DispatchQueue.main.async {
                            self.subProductArrBottomCollectionView.reloadData()
                            self.subProductArrTopCollectionView.reloadData()
                            self.subProductArrMiddelCollectionView.reloadData()

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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var index : Int = 0
        if collectionView == self.subProductArrTopCollectionView
        {
            index = subProductArrTop.count
        }
        if collectionView == self.subProductArrMiddelCollectionView
        {
            index = subProductArrMiddel.count
        }
        if collectionView == self.subProductArrBottomCollectionView
        {
            index = subProductArrBottom.count
        }
        
        return index
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.subProductArrTopCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
            let thumb = (self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
            cell.venderName.isHidden = true

          //  cell.venderName.text = (self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"business_name")  as? String
            cell.prodName.text = (self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"product_name")  as? String
            cell.qtyName.text = (self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"size_name")  as? String
            cell.costName.text = NSString(format: "%d", ((self.subProductArrTop[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!) as String
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4

            return cell

         }
        if collectionView == self.subProductArrMiddelCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
            let thumb = (self.subProductArrMiddel[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
            cell.venderName.isHidden = true
           // cell.venderName.text = (self.subProductArrMiddel[indexPath.row] as AnyObject).value(forKey:"business_name")  as? String
            cell.prodName.text = (self.subProductArrMiddel[indexPath.row] as AnyObject).value(forKey:"product_name")  as? String
            cell.qtyName.text = (self.subProductArrMiddel[indexPath.row] as AnyObject).value(forKey:"size_name")  as? String
            cell.costName.text = NSString(format: "%d", ((self.subProductArrMiddel[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!) as String
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4

            return cell

         }
        if collectionView == self.subProductArrBottomCollectionView
        {
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
            let thumb = (self.subProductArrBottom[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
            
            let urls: NSURL =   NSURL(string: thumb)!
            cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
            cell.venderName.isHidden = true

            //cell.venderName.text = (self.subProductArrBottom[indexPath.row] as AnyObject).value(forKey:"business_name")  as? String
            cell.prodName.text = (self.subProductArrBottom[indexPath.row] as AnyObject).value(forKey:"product_name")  as? String
            cell.qtyName.text = (self.subProductArrBottom[indexPath.row] as AnyObject).value(forKey:"size_name")  as? String
            cell.costName.text = NSString(format: "%d", ((self.subProductArrBottom[indexPath.row] as AnyObject).value(forKey:"display_mrp_price")  as? Int)!) as String
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.backgroundColor = UIColor.white
            
            // add a border
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4

            return cell
            
        }
                 else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
            
            return cell
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        /*  if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            cellLabels[indexPath.row] as String
            cellImages[indexPath.row] as String
        }*/
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! productDetailsVC
        if collectionView == self.subProductArrTopCollectionView
        {
             loginPageView.dict = self.subProductArrTop[indexPath.row] as! NSMutableDictionary

        }
        if collectionView == self.subProductArrMiddelCollectionView
        {
            loginPageView.dict = self.subProductArrMiddel[indexPath.row] as! NSMutableDictionary

           // index = subProductArrMiddel.count
        }
        if collectionView == self.subProductArrBottomCollectionView
        {
            loginPageView.dict = self.subProductArrBottom[indexPath.row] as! NSMutableDictionary

           // index = subProductArrBottom.count
        }
        self.navigationController?.pushViewController(loginPageView, animated: true)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddCart(_ sender: Any) {
        
        let vender_id =   (self.dict as AnyObject).value(forKey:"vendor_id")  as? Int
        
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let path = UserDefaults.standard.object(forKey: "cart") as! NSMutableArray
            for row in 0...(path.count - 1) {
                let cell = path[row] as! NSDictionary
                if cell.value(forKey: "vendor_id") as? Int == vender_id
                {
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                    self.dict.setValue(1, forKey: "qty")
                    //loginPageView.dict = self.dict
                    
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
           // self.dict.setValue(1, forKey: "qty")
            
            loginPageView.dict = self.dict
            
            self.navigationController?.pushViewController(loginPageView, animated: true)
            
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
