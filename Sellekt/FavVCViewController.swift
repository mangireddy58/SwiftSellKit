//
//  FavVCViewController.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class FavVCViewController: UIViewController , UITableViewDataSource,UITableViewDelegate
{
    var venderArr:NSMutableArray = []
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var myfavtable: UITableView!
    let ArrayshopItem = ["1","2","3", "4","5", "6","7"]
    let ArrayimageItem = ["daily deals.png","daily deals.png","daily deals.png","daily deals.png","daily deals.png","daily deals.png","daily deals.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.myfavtable.delegate = self
        self.myfavtable.dataSource = self
        myfavtable.register(UINib(nibName: "FAVCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FAVCellTableViewCell")
       
        
        
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        loadData()

        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        
        //http://test.tranzporthub.com/sellekt/customer_quotation_listing.php?customer_id=1&start_limit=0&end_limit=10
        
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/customer_my_wishlist.php?customer_id=%@&start_limit=0&end_limit=1300",NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String) as String
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
                        DispatchQueue.main.async {
                            
                            //                            total_quotation_sending_count": 1,
                            //                            "total_quotation_recieved_count": 3
                            self.myfavtable.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venderArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAVCellTableViewCell", for: indexPath) as! FAVCellTableViewCell
        
        // cell.lblname.text = item[indexPath.row]
        let thumb = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"product_display_img")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
        cell.imgfavProduct.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))

        cell.lblProductName.text =  (self.venderArr[indexPath.row] as AnyObject).value(forKey:"product_name") as? String
        cell.lblQty.text = NSString(format:"%@",((self.venderArr[indexPath.row] as AnyObject).value(forKey:"size_name")as? String)!) as? String
        cell.lblPrice.text =  NSString(format:"%0.2f",((self.venderArr[indexPath.row] as AnyObject).value(forKey:"display_price")as? Float)!) as String

        
        cell.imgfavProduct?.image = UIImage(named:self.ArrayimageItem[indexPath.row])
        return cell
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
