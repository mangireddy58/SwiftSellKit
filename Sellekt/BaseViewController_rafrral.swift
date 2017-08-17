//
//  BaseViewController.swift
//
//  LakeImaging
//
//  Created by Dinesh Jagtap on 11/08/16.
//  Copyright © 2016 MediaNX. All rights reserved.
//

import UIKit

class BaseViewController_rafrral: UIViewController, SlideMenuDelegate_rafrral {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenuItemSelectedAtIndex(index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
       
        if index == -1
        {
            self.openViewControllerBasedOnIdentifier(strIdentifier: "ViewController")
        }
//        if index == -2
//        {
//            self.openViewControllerBasedOnIdentifier(strIdentifier: "tabBarVC")
//        }
        if index >= 0
        {
            self.openViewControllerBasedOnIdentifier(strIdentifier: "VenderVC")
            
        }       /* switch(index){ß
                     
       //     http://test.tranzporthub.com/sellekt/listing_vendor_product.php?vendor_id=1&display_type=&discount_percentage=&category_id=&subcategory_id=&=&search_keyword=&sort_by=A_Z&start_limit=0&end_limit=3

            
            
            
       /* case 0:
            print("Home\n", terminator: "")
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(0, forKey: "login_type")

            self.openViewControllerBasedOnIdentifier("ViewController")
            
            break*/
        case 0:
            print("Play\n", terminator: "")
            
            self.openViewControllerBasedOnIdentifier(strIdentifier: "refrral_home")
            
            break
               case 1:
            //self.openViewControllerBasedOnIdentifier("referra")


             break
        case 2:
         //   self.openViewControllerBasedOnIdentifier("refrral_submit_req")


             break
        case 3:
         //   self.openViewControllerBasedOnIdentifier("referral_electronic_request")
            
            
            break

        case 4:
          //  self.openViewControllerBasedOnIdentifier("referral_request_form")
            
            
            break

        case 5:
           //  self.openViewControllerBasedOnIdentifier("refrral_event")



             break
        case 6:
           // self.openViewControllerBasedOnIdentifier("refrral_support")


            
            break
        case 7:
            
          //  self.openViewControllerBasedOnIdentifier("referral_private_chat")


             break
        case 8:
//            let defaults = NSUserDefaults.standardUserDefaults()
//            defaults.setInteger(0, forKey: "login_type")
//
//            self.openViewControllerBasedOnIdentifier("login")
            self.logout_func()
            
            
            break

        
            
        default:
           // self.openViewControllerBasedOnIdentifier("refrral_home")

             break
        }*/
    }
    func logout_func()
    {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Logout", message: "Do you want to logout?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        
        actionSheetController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            let defaults = UserDefaults.standard
            let cust_id = defaults.string(forKey: "referral_id")!;
            
            let JSONstr = NSString(format:"customer_id=%@&type=3", cust_id)
            let request: NSMutableURLRequest = NSMutableURLRequest()
            let url = "http://www.lakesapp.com.au/logout.php"
            
            let postData:NSData = JSONstr.data(using: String.Encoding.ascii.rawValue)! as NSData
            
            request.url = NSURL(string: url) as URL?
            request.httpMethod = "POST"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
            request.httpBody = postData as Data
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue()) {(response, datas, error) -> Void in

                
                if error != nil {
                    
                    print("error")
                    
                } else {
                    
                   // let dataString = String(data: datas!, encoding: String.Encoding.utf8)
                    let jsonResult = try! JSONSerialization.jsonObject(with: datas!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    let tem = jsonResult.value(forKey: "success") as! Int
                    if tem == 1
                        
                    {
                        print(jsonResult)
                        
                        
                    }
                    else
                    {
                      
                        
                        
                    }
                }
            }
        })
        self.present(actionSheetController, animated: true, completion: nil)

                }
    
            
        

    func openViewControllerBasedOnIdentifier(strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            if strIdentifier == "ViewController"
            {
                destViewController.hidesBottomBarWhenPushed = true
                
            }
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState.normal)
        btnShowMenu.tintColor = UIColor.black
         btnShowMenu.frame = CGRectMake(0, 0, 30, 30)
        
        btnShowMenu.addTarget(self, action: #selector(BaseViewController_rafrral.onSlideMenuButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }

    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRectMake(0, 3, 30, 1)).fill()
        UIBezierPath(rect: CGRectMake(0, 10, 30, 1)).fill()
        UIBezierPath(rect: CGRectMake(0, 17, 30, 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRectMake(0, 4, 30, 1)).fill()
        UIBezierPath(rect: CGRectMake(0, 11,  30, 1)).fill()
        UIBezierPath(rect: CGRectMake(0, 18, 30, 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        return defaultMenuImage;
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    func onSlideMenuButtonPressed(sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(index: -1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController_rafrral = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController_rafrral") as! MenuViewController_rafrral
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRectMake(0 - UIScreen.main.bounds.size.width, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=self.CGRectMake(0, 0, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            }, completion:nil)
    }
}
