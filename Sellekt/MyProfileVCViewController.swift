//
//  MyProfileVCViewController.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class MyProfileVCViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnOutletUpdate: UIButton!
   
    @IBOutlet weak var MyScroll: UIScrollView!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var State: UITextField!
    @IBOutlet weak var Country: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    @IBOutlet weak var EmailId: UITextField!
    @IBOutlet weak var LastName: UITextField!
    var activityIndicator = UIActivityIndicatorView()
    let defaults = UserDefaults.standard

    @IBOutlet weak var FirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
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
                let request: NSMutableURLRequest = NSMutableURLRequest()
        let url = NSString(format:"http://sellekt.teamdaphnisys.in/get_customer_profile_detail.php?customer_id=",NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String) as String
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
                        
                         DispatchQueue.main.async {
                              let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                            self.FirstName.text = dict.value(forKey: "first_name") as! String
                            self.LastName.text = dict.value(forKey: "last_name") as! String

//                            self.EmailId.text = dict.value(forKey: "last_name") as String
//                            self.Phone.text = dict.value(forKey: "address") as String
//                            self.Address.text = dict.value(forKey: "mobile_no") as String
//                            self.Country.text = dict.value(forKey: "first_name") as String
//                            self.State.text = dict.value(forKey: "first_name") as String
//                            self.City.text = dict.value(forKey: "first_name") as String

                            //                            total_quotation_sending_count": 1,
                            //                            "total_quotation_recieved_count": 3
                          //  self.myordertable.reloadData()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField == self.FirstName
        {
            self.LastName.becomeFirstResponder()
        }
        if textField == self.LastName
        {
            self.EmailId.becomeFirstResponder()
        }
        if textField == self.EmailId
        {
            self.Phone.becomeFirstResponder()
        }
        if textField == self.Phone
        {
            self.Address.becomeFirstResponder()
        }
        if textField == self.Address
        {
            self.Country.becomeFirstResponder()
        }
        if textField == self.Country
        {
            self.State.becomeFirstResponder()
        }
        if textField == self.State
        {
            self.City.resignFirstResponder()
            
            
        }
        
        
        return true
    }

    @IBAction func btnUpdateProfile(_ sender: Any) {
      
        let url = "http://sellekt.teamdaphnisys.in/update_customer_profile_picture.php"
        let MyUrl  = NSURL(string:url);
       // sender.enabled = false
        let request = NSMutableURLRequest(url: MyUrl! as URL);
       
        request.httpMethod = "POST";
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
