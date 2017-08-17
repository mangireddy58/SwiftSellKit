//
//  ChangePasswordVC.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationController?.isNavigationBarHidden = false
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }
    @IBAction func btnresetPassword(_ sender: Any) {
        
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
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
