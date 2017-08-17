//
//  AppDelegate.swift
//  Sellekt
//
//  Created by MEDIA MELANGE on 25/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit
//import DropDown
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


   
        let defaults = UserDefaults.standard
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
          //  DropDown.startListeningToKeyboard()
            
            
            if  defaults.bool(forKey:"hasRegister"){
                defaults.set(true, forKey: "hasRegister")
                defaults.set(0, forKey: "user_id")
                 defaults.synchronize()
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
                let rootViewController = self.window!.rootViewController as! UINavigationController
                rootViewController.pushViewController(loginPageView, animated: true)
                
            }
            else
            {
                if  ((defaults.object(forKey:"user_id")) != nil){
                    if  (defaults.object(forKey:"user_id") as! Int == 0){
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
                        let rootViewController = self.window!.rootViewController as! UINavigationController
                        rootViewController.pushViewController(loginPageView, animated: true)
                        
                    }
                    else
                    {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
                         let rootViewController = self.window!.rootViewController as! UINavigationController
                        rootViewController.pushViewController(loginPageView, animated: true)
                        
                        
                    }
                }
                else
                {
                    defaults.set(0, forKey: "user_id")
                    defaults.synchronize()
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
                    let rootViewController = self.window!.rootViewController as! UINavigationController
                    rootViewController.pushViewController(loginPageView, animated: true)
                    
                }
            }
        
        // Override point for customization after application launch.
        return true
    
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

