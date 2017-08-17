//
//  seeAllProduct.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 24/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class seeAllProduct: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,KWBannerViewDelegate{
    @IBOutlet var banner: KWBannerView!
    var mainBannerArr:NSMutableArray = []
    var subProductArrTop:NSMutableArray = []
    @IBOutlet var venderName: UILabel!
    @IBOutlet var scrollVC: UIScrollView!

    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var dict: NSMutableDictionary!
    var venderID:String = ""

    @IBOutlet var coolectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        let sz = CGSize(width: view.frame.width, height: view.frame.height+70)
        self.scrollVC.contentSize = sz
     //   self.venderID =  NSString(format: "%d",((self.dict as AnyObject).value(forKey:"vendor_id") as? Int)!) as String
      //  navigationController!.setNavigationBarHidden(true, animated:true)
        self.venderName.text = venderID
         // Do any additional setup after loading the view.
        self.banner.delegate = self;
        self.banner.imagesURLs = self.mainBannerArr
        self.banner.isAutoScroll = true
        self.banner.drawBannerNew()
        self.navigationController?.isNavigationBarHidden = false
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black

        // Do any additional setup after loading the view.
    }
 
  /*  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/3.0 //Display Three elements in a row.
        collectionViewSize.height = collectionViewSize.height/4.0
        return collectionViewSize
    }*/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var index : Int = 0
                    index = subProductArrTop.count
        
        return index
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        /*  if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
         cellLabels[indexPath.row] as String
         cellImages[indexPath.row] as String
         }*/
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! productDetailsVC
        
            loginPageView.dict = self.subProductArrTop[indexPath.row] as! NSMutableDictionary
        
        self.navigationController?.pushViewController(loginPageView, animated: true)
        
        
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
        
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let path = UserDefaults.standard.object(forKey: "cart") as! NSMutableArray
            for row in 0...(path.count - 1) {
                let cell = path[row] as! NSDictionary
                if cell.value(forKey: "vendor_id") as? Int == vender_id
                {
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                    self.dict.setValue(1, forKey: "qty")
                   // loginPageView.dict = self.dict
                    
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
            self.dict.setValue(1, forKey: "qty")
            
         //   loginPageView.dict = self.dict
            
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
