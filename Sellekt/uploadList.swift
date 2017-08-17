//
//  uploadList.swift
//  Selleket
//
//  Created by MEDIA MELANGE on 24/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class uploadList: BaseViewController_rafrral,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    @IBOutlet var imgVC: UIImageView!
    var index:Int = 3
    var activityIndicator = UIActivityIndicatorView()
var allCellsText = [String]()
    @IBOutlet var uploadTable: UITableView!
    let cellReuseIdentifier = "cell"
 let picker = UIImagePickerController()
    var cust_img: UIImage!
    @IBOutlet var popUpView: UIView!
    var q_id:String = ""
    let defaults = UserDefaults.standard
    var productArr:NSMutableArray = []
    var isList = false
    var path:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))

        self.navigationItem.titleView = imageView
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color  = UIColor(red:  49.0/255.0, green: 101.0/255.0, blue: 176.0/255.0, alpha: 100.0/100.0)
        self.activityIndicator.isHidden = true;
        self.activityIndicator.frame = CGRect(x: view.frame.midX-25 , y: view.frame.midY-50 , width: 50, height: 50)
        self.view.addSubview(self.activityIndicator)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        addSlideMenuButton()

    }
    @IBAction func popupClose(_ sender: UIButton) {
        self.cust_img = nil
        self.popUpView.isHidden = true
    }

    @IBAction func cancleUpload(_ sender: UIButton) {
        self.cust_img = nil
        self.popUpView.isHidden = true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    @IBAction func uploadImg(_ sender: UIButton) {
      
        let myUrl = NSURL(string: "http://sellekt.teamdaphnisys.in/create_list_upload_image_step1.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        
        
        
                let param = [
            "customer_id"    : NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "quotation_id"    : q_id,
            "quantity"    : "1",
            "quotation_details_id"    : ""
            ] as [String : String]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(self.imgVC.image!, 0.3)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "product_image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
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
                let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
 DispatchQueue.main.async {
                let tem = dict.value(forKey: "status") as! String
                if tem=="200"
                    
                {
                    let dict1:NSDictionary = dict.value(forKey: "data") as! NSDictionary
                   if (self.q_id == "")
                   {
                    self.q_id =  NSString (format: "%d",dict1.value(forKey:"quotation_id") as! Int) as String
                    }
                    
                   
                    if self.isList
                    {
                        let indexPath = NSIndexPath(row: self.path, section: 0)
                        // let indexPath1 = NSIndexPath(row: se, section: <#T##Int#>)
                        let cell = self.uploadTable.cellForRow(at: indexPath as IndexPath) as! uploadListCell!
                      //  let cell:uploadListCell = self.getCellForView(view: sender) as! uploadListCell
                        //     let indexPath = self.uploadTable.indexPath(for: cell)
                        //  product_name
                        
                        let thumb = dict1.value(forKey:"product_image") as! String
                        cell?.imgName.text  = dict1.value(forKey:"product_image") as? String

                        let urls: NSURL =   NSURL(string: thumb)!
                        cell?.addImg.sd_setImage(with: urls as URL, placeholderImage: UIImage(named: "placeholder.jpeg"))
                        if self.productArr.count != 0
                        {
                            var value1:Bool = true
                            for row in 0...((self.productArr.count) - 1) {
                                
                                let id = (self.productArr[row] as AnyObject).value(forKey: "index_path") as! Int
                                let qty = (self.productArr[row] as AnyObject).value(forKey: "quantity") as! String
                                
                                if id == self.path
                                {
                                    value1 = false
                                    self.productArr.removeObject(at: row)
                                    let dictNew:NSMutableDictionary = [:]
                                    dictNew.setValue(self.path, forKey: "index_path" )
                                    
                                    dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                                    dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                                    dictNew.setValue(qty, forKey: "quantity" )
                                    dictNew.setValue(true, forKey: "isSelected" )
                                    
                                    //  product_name
                                    
                                    self.productArr.add(dictNew)
                                    
                                }
                                
                            }
                            if value1
                            {
                                let dictNew:NSMutableDictionary = [:]
                                
                                dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                                dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                                dictNew.setValue("1", forKey: "quantity" )
                                dictNew.setValue(self.path, forKey: "index_path" )
                                dictNew.setValue(true, forKey: "isSelected" )
                                
                                //  product_name
                                
                                self.productArr.add(dictNew)
                                
                            }
                        }
                        else
                        {
                            
                            
                            
                            let dictNew:NSMutableDictionary = [:]
                            
                            dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                            dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                            dictNew.setValue("1", forKey: "quantity" )
                            dictNew.setValue(self.path, forKey: "index_path" )
                            dictNew.setValue(true, forKey: "isSelected" )
                            
                            //  product_name
                            
                            self.productArr.add(dictNew)
                        }

                    }
                    else
                    {
                        if self.productArr.count != 0
                        {
                            var value1:Bool = true
                            for row in 0...((self.productArr.count) - 1) {
                                
                                let id = (self.productArr[row] as AnyObject).value(forKey: "index_path") as! Int
                                let qty = (self.productArr[row] as AnyObject).value(forKey: "quantity") as! String
                                
                                if id == self.path
                                {
                                    value1 = false
                                    self.productArr.removeObject(at: row)
                                    let dictNew:NSMutableDictionary = [:]
                                    dictNew.setValue(self.path, forKey: "index_path" )
                                    
                                    dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                                    dictNew.setValue("", forKey: "product_name" )
                                    dictNew.setValue(qty, forKey: "quantity" )
                                    dictNew.setValue(true, forKey: "isSelected" )
                                    
                                    //  product_name
                                    
                                    self.productArr.add(dictNew)
                                    
                                }
                                
                            }
                            if value1
                            {
                                let dictNew:NSMutableDictionary = [:]
                                
                                dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                                dictNew.setValue("", forKey: "product_name" )
                                dictNew.setValue("1", forKey: "quantity" )
                                dictNew.setValue(self.path, forKey: "index_path" )
                                dictNew.setValue(true, forKey: "isSelected" )
                                
                                //  product_name
                                
                                self.productArr.add(dictNew)
                                
                            }
                        }
                        else
                        {
                            
                            
                            
                            let dictNew:NSMutableDictionary = [:]
                            
                            dictNew.setValue(dict1.value(forKey:"quotation_details_id") as! Int, forKey: "quotation_details_id" )
                            dictNew.setValue("", forKey: "product_name" )
                            dictNew.setValue("1", forKey: "quantity" )
                            dictNew.setValue(self.path, forKey: "index_path" )
                            dictNew.setValue(true, forKey: "isSelected" )
                            
                            //  product_name
                            
                            self.productArr.add(dictNew)
                        }

                    }
                    
                }
                self.popUpView.isHidden = true
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
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        print(allCellsText)
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
                     textField.resignFirstResponder()
//        let dictNew:NSMutableDictionary = [:]
//        
//        dictNew.setValue(1, forKey: "quotation_details_id" )
//        dictNew.setValue( textField.text, forKey: "product_name" )
//        dictNew.setValue(1, forKey: "quantity" )
//        
//        //  product_name
//        
//        self.productArr.add(dictNew)

        
        return true
    }

    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
  
    @IBAction func uploadList1(_ sender: UIButton) {
        self.path = sender.tag
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
        isList = true
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
    isList = false
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
        self.popUpView.isHidden = false
        self.imgVC.image = cust_img
        picker .dismiss(animated: true, completion: nil)

            }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker .dismiss(animated: true, completion: nil)
        
        print("picker cancel.")
    }


    @IBAction func shareList(_ sender: Any) {
        view.endEditing(true)
        if self.productArr.count == 0
        {
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "Please Add At least one product "
            alert.addButton(withTitle: "OK")
            alert.show()

        }
        else
        {
            self.shareVenderList()
        }
        
    }
    func shareVenderList()
    {

        let newArr:NSMutableArray = []
        
        for row in 0...((self.productArr.count) - 1) {
            
            let id = (self.productArr[row] as AnyObject).value(forKey: "isSelected") as! Bool
            if id
            {
                               newArr.add(self.productArr[row])
                
            }
            
        }
        
        
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
       // http://test.tranzporthub.com/sellekt/create_list_save_order_details_get_vendor_step2.php
        var url = NSString(format:"http://sellekt.teamdaphnisys.in/create_list_save_order_details_get_vendor_step2.php") as String
        url = url.removingWhitespaces()
        self.activityIndicator.isHidden = false;
        self.activityIndicator.startAnimating()
        print(url)

        request.url = NSURL(string: url as String) as URL?
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let param = [
            "shipping_vendor_id" : defaults.value(forKey:"venderArr") as! CVarArg,
            "customer_id":NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "quotation_id":self.q_id,
            "customer_quotation_comment":" ",
            "latitude":NSString (format: "%f",defaults.float(forKey:"lati")),
            "longitude":NSString (format: "%f",defaults.float(forKey:"longi")),
            "sort_by":"A_Z",
            "vendor_business_name_search_keyword":"",
            "vendor_start_limit":"0",
            "vendor_end_limit":"100",
            "order_details_array": newArr
            ] as [String : Any]
        print(param)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
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
                        print(jsonResult)

                        let dict:NSMutableArray = jsonResult.value(forKey: "data") as! NSMutableArray
                        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "uploadListVenderVC") as! uploadListVenderVC
                        loginPageView.venderArr = jsonResult.value(forKey: "data") as! NSMutableArray
                        loginPageView.param = param
                        loginPageView.q_id = self.q_id
                        loginPageView.newArr = newArr
                        self.navigationController?.pushViewController(loginPageView, animated: true)

                        
                        
                        
                        
                    }
                    else
                    {
                        
                        
                    }
                    
                }
            }
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let text_id = textField.tag
        let indexPath = NSIndexPath(row: self.path, section: 0)
        // let indexPath1 = NSIndexPath(row: se, section: <#T##Int#>)
        let cell = self.uploadTable.cellForRow(at: indexPath as IndexPath) as! uploadListCell!
        if self.productArr.count != 0
        {
            var value1:Bool = true
            for row in 0...((self.productArr.count) - 1) {
                
                let id = (self.productArr[row] as AnyObject).value(forKey: "index_path") as! Int
                if id == text_id
                {
                    value1 = false
                    self.productArr.removeObject(at: row)
                    let dictNew:NSMutableDictionary = [:]
                    dictNew.setValue(text_id, forKey: "index_path" )
                    
                    dictNew.setValue(0, forKey: "quotation_details_id" )
                    dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                    dictNew.setValue(cell?.qtyTxt.text, forKey: "quantity" )
                    dictNew.setValue(true, forKey: "isSelected" )

                    //  product_name
                    
                    self.productArr.add(dictNew)
                    
                }
                
            }
            if value1
            {
                let dictNew:NSMutableDictionary = [:]
                
                dictNew.setValue(0, forKey: "quotation_details_id" )
                dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                dictNew.setValue(cell?.qtyTxt.text, forKey: "quantity" )
                dictNew.setValue(text_id, forKey: "index_path" )
                dictNew.setValue(true, forKey: "isSelected" )

                //  product_name
                
                self.productArr.add(dictNew)
                
            }
        }
        else
        {
            
            
            
            let dictNew:NSMutableDictionary = [:]
            
            dictNew.setValue(0, forKey: "quotation_details_id" )
            dictNew.setValue(cell?.productName.text, forKey: "product_name" )
            dictNew.setValue(cell?.qtyTxt.text, forKey: "quantity" )
            dictNew.setValue(text_id, forKey: "index_path" )
            dictNew.setValue(true, forKey: "isSelected" )

            //  product_name
            
            self.productArr.add(dictNew)
        }

        
        
        
                return true
    }
    
    @IBAction func AddMore(_ sender: Any) {
        self.index = self.index + 1
        self.uploadTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.index
    }
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell:uploadListCell = self.uploadTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! uploadListCell
        cell.productName.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
        cell.productName.delegate = self
        cell.imgName.isEnabled = false
        cell.productName.layer.borderColor = UIColor.darkGray.cgColor
        cell.qtyTxt.layer.borderColor = UIColor.darkGray.cgColor
        cell.imgName.layer.borderColor = UIColor.darkGray.cgColor
        cell.uploadBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
        cell.uploadBtn.addTarget(self, action: #selector(uploadList1(_:)), for: UIControlEvents.touchUpInside)
        
        cell.selectBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
        cell.selectBtn.addTarget(self, action: #selector(AddCart(_:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    @IBAction func AddCart(_ sender: UIButton) {
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
       //
        let cell = self.uploadTable.cellForRow(at: indexPath as IndexPath) as! uploadListCell!
        if (cell?.selectBtn.isSelected)!
        {
            cell?.selectBtn.isSelected =  false
        }
        else
        {
            cell?.selectBtn.isSelected =  true
            
        }
        if self.productArr.count != 0
        {
            var value1:Bool = true
            for row in 0...((self.productArr.count) - 1) {
                
                let id = (self.productArr[row] as AnyObject).value(forKey: "index_path") as! Int
                if id == sender.tag
                {
                    value1 = false
                    self.productArr.removeObject(at: row)
                    let dictNew:NSMutableDictionary = [:]
                    dictNew.setValue(sender.tag, forKey: "index_path" )
                    
                    dictNew.setValue(0, forKey: "quotation_details_id" )
                    dictNew.setValue(cell?.productName.text, forKey: "product_name" )
                    dictNew.setValue(cell?.qtyTxt.text, forKey: "quantity" )
                    dictNew.setValue(cell?.selectBtn.isSelected, forKey: "isSelected" )
                    
                    //  product_name
                    
                    self.productArr.add(dictNew)
                    
                }
                
            }
                    }

        
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
       }
    

}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
