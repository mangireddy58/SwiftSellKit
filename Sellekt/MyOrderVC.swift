//
//  MyOrderVC.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class MyOrderVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
 //   let ArrayshopItem = ["1","2","3", "4","5", "6","7"]
    @IBOutlet var recivedQuatation: UILabel!
    @IBOutlet var shareVender: UILabel!
    var venderArr:NSMutableArray = []
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard
    let cellReuseIdentifier = "cell"
    var quatation_id:Int = 0
    var vender_id:Int = 0

    @IBOutlet weak var myordertable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = false
        self.myordertable.delegate = self
        self.myordertable.dataSource = self
        myordertable.register(UINib(nibName: "MyOrderCell", bundle: nil), forCellReuseIdentifier: "MyOrderCell")
        
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
        // navigationController!.setNavigationBarHidden(true, animated:true)
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        
        //http://test.tranzporthub.com/sellekt/customer_quotation_listing.php?customer_id=1&start_limit=0&end_limit=10
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
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/customer_my_order_listing.php?customer_id=%@&start_order_limit=0&end_order_limit=1000",NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String) as String
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
                        
                        self.venderArr = jsonResult.value(forKey: "customer_my_order_array") as! NSMutableArray
                        DispatchQueue.main.async {
                            
                            //                            total_quotation_sending_count": 1,
                            //                            "total_quotation_recieved_count": 3
                            self.myordertable.reloadData()
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
       // let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderCell", for: indexPath) as! MyOrderCell
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "MyquotationCell", for: indexPath) as! MyquotationCell
        let identifier = "cell"
        let cell:orderCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? orderCell
        cell.lblOrderId.text = NSString(format:"%d",((self.venderArr[indexPath.row] as AnyObject).value(forKey:"order_no")as? Int)!) as? String
        //    cell.qty.text =  NSString(format:"2 Km") as String
        
        let timeDict  = ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"Created_Date")) as! NSDictionary
        let timeZone = timeDict.value(forKey: "timezone") as! String
        let timeDate = timeDict.value(forKey: "date") as! String
        cell.lblStatus.text =  NSString(format:"%@", ((self.venderArr[indexPath.row] as AnyObject).value(forKey:"Order_Status")as? String)!) as String
        cell.lblAmount.text =  NSString(format:"%0.2f",((self.venderArr[indexPath.row] as AnyObject).value(forKey:"net_total")as? Float)!) as String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        dateFormatter.timeZone = NSTimeZone(name: timeZone) as TimeZone!
        let date = dateFormatter.date(from: timeDate)
        
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = " dd MMMM yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        
        
        cell.lblDate.text =  NSString(format:"%@", timeStamp) as String
        
        cell.btnDetail.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
        cell.btnDetail.addTarget(self, action: #selector(AddCart(_:)), for: UIControlEvents.touchUpInside)
        if (indexPath.row % 2) != 0{
            cell.backgroundColor =  UIColor(red: CGFloat(233) / 255.0, green: CGFloat(234) / 255.0, blue: CGFloat(235) / 255.0, alpha: CGFloat(1))

         }else{
            cell.backgroundColor = UIColor .white
        }

        // cell.ImageMenu?.image = UIImage(named:self.ArrayimageItem[indexPath.row])
        return cell
    }
    @IBAction func AddCart(_ sender: UIButton) {
    /*    let v_id = (self.venderArr[sender.tag] as AnyObject).value(forKey: "quotation_id") as! Int
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "quatationDetails") as! quatationDetails
        loginPageView.quatation_id =  v_id
        self.navigationController?.pushViewController(loginPageView, animated: true)*/
        
        
        
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
