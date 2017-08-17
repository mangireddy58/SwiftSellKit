//
//  MainMyProfileVC.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit


class MainMyProfileVC: BaseViewController_rafrral , UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate ,UIImagePickerControllerDelegate
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgprofileOutlet: UIImageView!
    let defaults = UserDefaults.standard
    let picker = UIImagePickerController()
    var cust_img: UIImage!
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var myTable: UITableView!

    
    let ArrayItem = ["Edit Profile","MY Order","My Quotation", "Message","Favourite", "Change Password","LogOut"]
    
    let ArrayimageItem = ["profile.png","account_setting_3X.PNG","my_qutn@3x.png","Message_3X.PNG","fav.png","my_account_3X.PNG","logout_3X.PNG"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table view delegate
        self.myTable.delegate = self
        self.myTable.dataSource = self
       
        self.navigationController?.isNavigationBarHidden = true

        myTable.register(UINib(nibName: "MainMyProfileCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MainMyProfileCellTableViewCell")
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          addSlideMenuButton()
        self.lblName.text = defaults.object(forKey: "first_name") as! String
        let url = defaults.object(forKey: "profile_picture") as! String
        let urls: NSURL =   NSURL(string: url)!
        self.imgprofileOutlet.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
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
        self.view.addSubview(self.activityIndicator)

    }
    
    override func viewDidLayoutSubviews() {
        
        imgprofileOutlet.layer.cornerRadius = imgprofileOutlet.frame.size.width/2
        imgprofileOutlet.clipsToBounds = true
        
    }
    // MARK: - UITableViewDataSource
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayItem.count
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMyProfileCellTableViewCell", for: indexPath) as! MainMyProfileCellTableViewCell
        
       // cell.lblname.text = item[indexPath.row]
        cell.lblName.text = ArrayItem [indexPath.row]
        
       
        cell.ImageMenu?.image = UIImage(named:self.ArrayimageItem[indexPath.row])
        return cell
    }

    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let MyProfileVc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVCViewController") as! MyProfileVCViewController
            self.navigationController?.pushViewController(MyProfileVc, animated: true)
            
            
            
        }
        if indexPath.row == 1
        {
        let order = self.storyboard?.instantiateViewController(withIdentifier:"MyOrderVC") as! MyOrderVC
          
             self.navigationController?.pushViewController(order, animated: true)
        }
        if indexPath.row == 2
        {
            let order = self.storyboard?.instantiateViewController(withIdentifier:"MyQuotationVC") as! MyQuotationVC
            
            self.navigationController?.pushViewController(order, animated: true)
        }
        if indexPath.row == 3
        {/*
            let order = self.storyboard?.instantiateViewController(withIdentifier:"ChatVC") as! ChatVC
            
            self.navigationController?.pushViewController(order, animated: true)
 */
        }
        if indexPath.row == 4
        {
            let order = self.storyboard?.instantiateViewController(withIdentifier:"FavVCViewController") as! FavVCViewController
            
            self.navigationController?.pushViewController(order, animated: true)
        }
        if indexPath.row == 5
        {
            let order = self.storyboard?.instantiateViewController(withIdentifier:"VerificationVC") as! VerificationVC
            
            self.navigationController?.pushViewController(order, animated: true)
        }
        if indexPath.row == 6
        {
            let order = self.storyboard?.instantiateViewController(withIdentifier:"ViewController") as! ViewController
            
            self.navigationController?.pushViewController(order, animated: true)
        }
        
        
/*if indexPath.row == 2
        {
            let quotation = self.storyboard?.instantiateInitialViewController(performSegue(withIdentifier: "MyQuotationVC")  as! MyQuotationVC
             self.navigationController?.pushViewController(quotation, animated: true)
        }}
        
        if indexPath.row == 3
        {
            let chat = self.storyboard?.instantiateInitialViewController(performSegue(withIdentifier: "ChatVC")  as! ChatVC)
             self.navigationController?.pushViewController(chat, animated: true)
        }
        
        if indexPath.row == 4
        {
            let fav = self.storyboard?.instantiateInitialViewController(performSegue(withIdentifier: "FavVCViewController")  as! FavVCViewController)
             self.navigationController?.pushViewController(fav, animated: true)
        }
        if indexPath.row == 5
        {
            let changePass = self.storyboard?.instantiateInitialViewController(performSegue(withIdentifier: "ChangePasswordVC")  as! ChangePasswordVC)
             self.navigationController?.pushViewController(changePass, animated: true)
        }
        if indexPath.row == 6
        {
            let LoOut = self.storyboard?.instantiateInitialViewController(performSegue(withIdentifier: "ViewController")  as! ViewController)
            self.navigationController?.pushViewController(LoOut, animated: true)
        }

        */
    }
    @IBAction func uploadList(_ sender: UIButton) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.view.tintColor = UIColor.black
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        let cam_image = UIImage(named: "camera.png")
         cameraAction.setValue(cam_image, forKey: "image")
        let gal_image = UIImage(named: "gallery.png")
        
        gallaryAction.setValue(gal_image, forKey: "image")
        
        //        let subview = cancelAction.view.subviews.first! as UIView
        //        let alertContentView = subview.subviews.first! as UIView
        //        alertContentView.backgroundColor =  UIColor.yellow
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        //        alert.popoverPresentationController!.sourceView = self.view
        //        alert.popoverPresentationController!.sourceRect = self.view.bounds
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    func openGallary(){
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    //MARK:UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //  private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        cust_img = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
     //   self.popUpView.isHidden = false
        self.uploadImg()
        self.imgprofileOutlet.image = cust_img
        picker .dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker .dismiss(animated: true, completion: nil)
        
        print("picker cancel.")
    }



     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func uploadImg() {
        
        let myUrl = NSURL(string: "http://sellekt.teamdaphnisys.in/update_customer_profile_picture.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        
        
        
        let param = [
            "customer_id"    : NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String
            ] as [String : String]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(self.imgprofileOutlet.image!, 0.5)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "profile_image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        self.activityIndicator.isHidden=false
        self.activityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                
                let jsonResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                DispatchQueue.main.async {
                    let tem = jsonResult.value(forKey: "code") as! String
                    if tem=="200"
                        
                    {
                       
                        self.activityIndicator.stopAnimating()
                        self.defaults.set(jsonResult.value(forKey:"profile_picture") as! String, forKey: "profile_picture")
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            // sender.isEnabled = true
                            
                            let altMessage = UIAlertController(title: "Sucssess", message:jsonResult.value(forKey: "message") as? String, preferredStyle: UIAlertControllerStyle.alert)
                            altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(altMessage, animated: true, completion: nil)
                        }

                        
                                                     }
                            else
                            {
                                
                                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                   // sender.isEnabled = true
                                    
                                    let altMessage = UIAlertController(title: "Error", message:jsonResult.value(forKey: "message") as? String, preferredStyle: UIAlertControllerStyle.alert)
                                    altMessage.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(altMessage, animated: true, completion: nil)
                                }

                                
                    }
                 //   self.popUpView.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
        
        
        
        
        
    }
    
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
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


