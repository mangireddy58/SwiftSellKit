//
//  quatationDetails.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 31/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class quatationDetails: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var totalView: UIView!
    @IBOutlet var tableVIew: UITableView!
    @IBOutlet var recivedQuatation: UILabel!
    @IBOutlet var shareVender: UILabel!
    var venderArr:NSMutableArray = []
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var quatation_id:Int = 0
    var vender_id:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        self.navigationController?.isNavigationBarHidden = false
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView

        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
        // navigationController!.setNavigationBarHidden(true, animated:true)
        
        loadData()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venderArr.count
    }
    func loadData() {
        
  //http://test.tranzporthub.com/sellekt/customer_my_quotation_details.php?customer_id=1&quotation_id=1
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
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/customer_my_quotation_details.php?customer_id=%@&quotation_id=%@",NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,quatation_str) as String
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
                        
                        self.venderArr = jsonResult.value(forKey: "while_quotation_array") as! NSMutableArray
                        DispatchQueue.main.async {
                            self.recivedQuatation.text = NSString (format: "%d" ,jsonResult.value(forKey: "total_quotation_recieved_count")as! Int) as String
                            self.shareVender.text = NSString (format: "%d" ,jsonResult.value(forKey: "total_quotation_sending_count")as! Int) as String

//                            total_quotation_sending_count": 1,
//                            "total_quotation_recieved_count": 3
                            self.tableVIew.reloadData()
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
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // let cell:venderCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! venderCell
        let cell:quatationDetailsCell = self.tableVIew.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! quatationDetailsCell
        let thumb = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"product_image")  as! String
        
        let urls: NSURL =   NSURL(string: thumb)!
        cell.imgView.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
        
        cell.name.text = (self.venderArr[indexPath.row] as AnyObject).value(forKey:"product_name") as? String
    //    cell.qty.text =  NSString(format:"2 Km") as String
        cell.qty.text =  NSString(format:"%d", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"quantity")as? Int)!) as String
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped cell number \(indexPath.row).")
//        
//        
//        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! productsVC
//        loginPageView.dict = self.venderArr[indexPath.row] as! NSMutableDictionary
//        self.navigationController?.pushViewController(loginPageView, animated: true)
        
        // performSegueWithIdentifier("yourSegueIdentifer", sender: self)
        
    }
    
    
    
    
    
    
    
    @IBAction func viewDetails(_ sender: UIButton) {
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "aceptanceListVC") as! aceptanceListVC
        loginPageView.quatation_id = self.quatation_id
        self.navigationController?.pushViewController(loginPageView, animated: true)
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
