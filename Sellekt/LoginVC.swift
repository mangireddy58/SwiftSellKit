//
//  LoginVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 22/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class LoginVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var login_type: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var remember_me: UIButton!
    var activityIndicator = UIActivityIndicatorView()
    var type:Int = 0
    var is_rem: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.setNavigationBarHidden(true, animated:true)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        view.addSubview(self.activityIndicator)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)       // scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height)
        
        self.navigationItem.title = "Login"
        emailTxt.delegate=self
        let defaultss = UserDefaults.standard
        type = defaultss.integer(forKey: "login_type")
       

        is_rem = defaultss.bool(forKey: "staff_rem")
        
            if is_rem {
                remember_me.isSelected=true;
                emailTxt.text = defaultss.string(forKey: "staff_u_name")
                passTxt.text = defaultss.string(forKey: "staff_password")
            }
        
        

        // Do any additional setup after loading the view.
    }
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInset
    }
@IBAction func forgotPass_btn(sender: UIButton) {
    }
    @IBAction func rememberme_btn(sender: UIButton) {
        
        
        
            let defaults = UserDefaults.standard
            is_rem = defaults.bool(forKey: "staff_rem")
            if is_rem {
                defaults.set(false, forKey: "staff_rem")
                remember_me.isSelected=false;
                
                defaults.set("", forKey: "staff_u_name")
                defaults.set("", forKey: "staff_password")
                
                
            }
            else
            {
                defaults.set(true, forKey: "staff_rem")
                remember_me.isSelected=true;
                
                defaults.set(self.emailTxt.text, forKey: "staff_u_name")
                defaults.set(self.passTxt.text, forKey: "staff_password")
                
            }
    }
    @IBAction func rememberme_btn1(sender: UIButton) {
        
        
        
        let defaults = UserDefaults.standard
        is_rem = defaults.bool(forKey: "staff_rem")
        if is_rem {
            defaults.set(false, forKey: "staff_rem")
            remember_me.isSelected=false;
            
            defaults.set("", forKey: "staff_u_name")
            defaults.set("", forKey: "staff_password")
            
            
        }
        else
        {
            defaults.set(true, forKey: "staff_rem")
            remember_me.isSelected=true;
            
            defaults.set(self.emailTxt.text, forKey: "staff_u_name")
            defaults.set(self.passTxt.text, forKey: "staff_password")
            
        }
    }
    @IBAction func registerBtn_btn(sender: UIButton) {
        
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
         self.navigationController?.pushViewController(loginPageView, animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if ( textField == self.emailTxt ) {
            passTxt.becomeFirstResponder()
        }
        else if ( textField == self.passTxt )
        {   self.view.endEditing(true)
        }
        else
        {
            self.view.endEditing(true)
        }
        
        return true;
    }
    @IBAction func login_btn(sender: UIButton) {
        
        if ((emailTxt.text?.characters.count)! > 0)
        {
            if ((passTxt.text?.characters.count)! > 0)
                {
                    sender.isEnabled = false
                    
                    let defaults = UserDefaults.standard
                    emailTxt.resignFirstResponder() // To resign the inputView on clicking done.
                    passTxt.resignFirstResponder() // To resign the inputView on clicking done.
                    
                    self.activityIndicator.isHidden = false;
                    
                    self.activityIndicator.startAnimating()
                    let request: NSMutableURLRequest = NSMutableURLRequest()
                    let url = NSString(format:"http://sellekt.teamdaphnisys.in/customer_login.php?user_id=%@&password=%@",emailTxt.text!,passTxt.text!) as String
                    let trimmedString = url.removingWhitespaces()

                     request.url = NSURL(string: trimmedString as String) as URL?
                    request.httpMethod = "GET"
                    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
                    
                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue()) {(response, datas, error) -> Void in
                        
                        if error != nil {
                            
                            print("error")
                            
                        } else {
                            
                            let dataString = String(data: datas!, encoding: String.Encoding.utf8)
                            let jsonResult = try! JSONSerialization.jsonObject(with: datas!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            
                            let tem=jsonResult.value(forKey: "status") as! Int
                            if tem==200
                                
                            {
                                 DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                sender.isEnabled = true
                                
                                print(jsonResult)
                                print(dataString! as String)
                                let dict=jsonResult.value(forKey: "data") as! NSDictionary
                                let defaults = UserDefaults.standard
                                defaults.set(dict.value(forKey:"customer_id") as! Int, forKey: "user_id")
                                defaults.set(dict.value(forKey:"first_name") as! String, forKey: "first_name")
                                defaults.set(dict.value(forKey:"customer_email_id") as! String, forKey: "customer_email_id")
                                defaults.set(dict.value(forKey:"mobile_no") as! String, forKey: "mobile_no")
                                defaults.set(dict.value(forKey:"profile_picture") as! String, forKey: "profile_picture")
                                
                                
                                
                                let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
                                self.navigationController?.pushViewController(loginPageView, animated: true)
                                }
                                
                         /*       NSDictionary *returnArray = [returnedDealDict objectForKey:@"data"];
                                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                                [[NSUserDefaults standardUserDefaults] setValue:[returnArray valueForKey:@"customer_email_id"] forKey:@"customer_email_id"];
                                [[NSUserDefaults standardUserDefaults] setValue:[returnArray valueForKey:@"customer_id"] forKey:@"customer_id"];
                                [[NSUserDefaults standardUserDefaults] setValue:[returnArray valueForKey:@"first_name"] forKey:@"first_name"];
                                [[NSUserDefaults standardUserDefaults] setValue:[returnArray valueForKey:@"mobile_no"] forKey:@"mobile_no"];
                                [[NSUserDefaults standardUserDefaults] setValue:[returnArray valueForKey:@"profile_picture"] forKey:@"profile_picture"];
                                 let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                                 self.navigationController?.pushViewController(loginPageView, animated: true)

                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                                tabBarVC *objSecondViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
                                //   objSecondViewController.ids = stylistID;
                                
                                [self.navigationController pushViewController:objSecondViewController animated:YES];*/
                            }
                            else
                            {
                                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                    sender.isEnabled = true
                                    
                                    let altMessage = UIAlertController(title: "Error", message:jsonResult.value(forKey: "message") as? String, preferredStyle: UIAlertControllerStyle.alert)
                                    altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(altMessage, animated: true, completion: nil)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                }
                else
                {
                    let altMessage = UIAlertController(title: "Warning", message: "Please enter password", preferredStyle: UIAlertControllerStyle.alert)
                    altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(altMessage, animated: true, completion: nil)
                    
                }
        }
        else
        {
            let altMessage = UIAlertController(title: "Warning", message: "Please enter username", preferredStyle: UIAlertControllerStyle.alert)
            altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(altMessage, animated: true, completion: nil)
            
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
