//
//  tabBarVC.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 22/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class tabBarVC: UITabBarController ,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
self.delegate = self
                // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items?[2].badgeValue = NSString(format:"02") as String
        if let path1 = UserDefaults.standard.object(forKey: "cart")
        {
            let arr:NSArray = UserDefaults.standard.object(forKey: "cart") as! NSArray
            
            
            self.tabBarController?.tabBar.items?[2].badgeValue = NSString(format:"02%d", arr.count) as String
            //  tabItem.badgeValue = NSString(format:"%d", arr.count) as String
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 2 {
            if let path1 = UserDefaults.standard.object(forKey: "cart")
            {
                let arr:NSArray = UserDefaults.standard.object(forKey: "cart") as! NSArray
                if(arr.count == 0)
                {
                    let alert = UIAlertView()
                    alert.title = "Warning"
                    alert.message = "Cart is empty"
                    alert.addButton(withTitle: "OK")
                  //  alert.show()

                }
                else
                {
                   

                   // tabItem.badgeValue =  arr.count
//                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
//                    
//                    self.navigationController?.pushViewController(loginPageView, animated: true)

                }
            }
            else
            {
                let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Cart is empty", preferredStyle: .alert)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
                    if let navigationController = self.navigationController {
                        
                        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
                        self.navigationController?.pushViewController(loginPageView, animated: true)

                    }
                    //self.navigationController?.popViewController(animated: true)                //Just dismiss the action sheet
                }
                actionSheetController.addAction(cancelAction)
                self.present(actionSheetController, animated: true, completion: nil)

            }
         }
        if tabBarIndex == 4 {
            if  ((UserDefaults.standard.object(forKey:"user_id")) != nil){
                if  (UserDefaults.standard.object(forKey:"user_id") as! Int == 0){
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
                    let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "MainMyProfileVC") as! MainMyProfileVC
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
