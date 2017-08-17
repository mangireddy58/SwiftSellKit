//
//  checkOutVC.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 10/04/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class checkOutVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var cust_img: UIImage!

    @IBOutlet var checkOutTable: UITableView!
    let billingAddress:String = ""
    let fNameStr:String = ""
    let lNameStr:String = ""
    let emailStr:String = ""
    let mobStr:String = ""
    let addStr:String = ""
    let streetStr:String = ""
    let cityStr:String = ""
    let countryStr:String = ""
    let img1:String = ""
    let img2:String = ""
    let sloteStr:String = ""
    let  commentStr:String = ""
    @IBOutlet var slotTableVC: UITableView!
    var acceptanceArr:NSMutableArray = []
    let defaults = UserDefaults.standard
    var path:Int = 0
    let picker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...4
        {
            
            let cell:NSMutableDictionary = [:]
            cell.setValue(false, forKey: "isOpened")
            acceptanceArr.add(cell)
            
        }
        self.checkOutTable.reloadData()

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let dataDict : NSMutableDictionary? = acceptanceArr.object(at: section) as? NSMutableDictionary
     let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
    
    if isOpened == true {
        return 1
    }
    else {
        return 0
    }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 50))
        let headerView = UIButton(frame: CGRect(x: 0, y: 10, width:  self.view.frame.size.width, height: 40))
        let img:UIImageView = UIImageView()
        img.frame = CGRect(x: view.frame.size.width - 50, y: 5, width:  30, height: 30)
        
        let name:UILabel = UILabel()
        switch section {
        case 0:
            
                name.text = "Billing Details"

            
            break
        case 1:
            
            name.text = "Delivery Address"
            
            
            break
        case 2:
            
            name.text = "Delivery Details"
            
            
            break
        case 3:
            
            name.text = "Payment Information"
            
            
            break
        default:
            break
        }
                name.frame = CGRect(x: 10, y: 0, width:  self.view.frame.size.width-100, height: 40)
        name.textColor = UIColor.white
        name.font = name.font.withSize(15)
        
        // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
        headerView.addSubview(name)
                 // headerView.setTitle(((self.acceptanceArr.object(at: section) as AnyObject).value(forKey: "business_name") as? String),for: UIControlState())
         //  headerView.setTitle("Whole Market " + String(section),for: UIControlState())
        
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            
            headerView.backgroundColor = UIColor(red: CGFloat(176) / 255.0, green: CGFloat(19) / 255.0, blue: CGFloat(90) / 255.0, alpha: CGFloat(1))
            img.image = UIImage.init(named: "minus.png")
            headerView.frame =  CGRect(x: 0, y: 0, width:  self.view.frame.size.width, height: 40)
           
            
            
            
            //  let headerViews:UIView = (Bundle.main.loadNibNamed("acceptanceHeader", owner: nil, options: nil)![0] as? UIView)!
            // tableView.register(UINib(nibName: "acceptanceHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "acceptanceHeader")
            
            
        }
        else{
            //  headerView.backgroundColor = UIColor.blue
            headerView.backgroundColor = UIColor(red: CGFloat(31) / 255.0, green: CGFloat(78) / 255.0, blue: CGFloat(120) / 255.0, alpha: CGFloat(1))
            img.image = UIImage.init(named: "plus1.png")
            //  headerViews.isHidden=true
            headerView.frame =  CGRect(x: 0, y: 10, width:  self.view.frame.size.width, height: 40)
            
            
            
        }
        
        headerView.addTarget(self, action: #selector(checkOutVC.headerClicked(_:)), for: UIControlEvents.touchUpInside)
        headerView.tag = section
        headerView.addSubview(img)
        
        view.addSubview(headerView)
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          var indexs:CGFloat = 0
        switch indexPath.section as Int {
            
        case 0:
            indexs = 100
            break
        case 1:
            indexs = 572
            break
        case 2:
            indexs = 184
            break
        case 3:
            indexs = 228
            break

        default:
            break
        }
        return indexs;
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.setNavigationBarHidden(false, animated:true)
        let image = UIImage(named: "logo.png")!
        let screenWidth = UIScreen.main.bounds.width/2 - 20
        let imageView = UIImageView(frame: CGRect(x: screenWidth, y: 0, width: 40, height: 42));imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var hightt:CGFloat = 0
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: section) as? NSMutableDictionary
        let isOpened = (dataDict!.object(forKey: "isOpened") as? NSNumber)?.boolValue
        if isOpened == true {
            //  headerView.backgroundColor = UIColor.green
            hightt = 55.0
        }
        else{
            //  headerView.backgroundColor = UIColor.blue
            hightt =  55.0
            
        }
        
        return hightt
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
        //  var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCell
        let cell:billingAddCell = self.checkOutTable.dequeueReusableCell(withIdentifier: "cell1") as! billingAddCell
        
        cell.BillingAdd.delegate = self
            cell.BillingAdd.tag =  Int((indexPath as NSIndexPath).row as NSNumber)

            cell.continueBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
            cell.continueBtn.addTarget(self, action: #selector(contFunc), for: UIControlEvents.touchUpInside)

        
        
        
        return cell
        }
        if indexPath.section == 1
        {
            //  var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCell
            let cell:deliveryAddCell = self.checkOutTable.dequeueReusableCell(withIdentifier: "cell2") as! deliveryAddCell
            
            cell.fName.delegate = self
            cell.lName.delegate = self
            cell.emailId.delegate = self
            cell.mobileNo.delegate = self
            cell.address.delegate = self
            if  defaults.bool(forKey:"isAddress")
            {
                cell.contry.text = defaults.value(forKey:"contry") as! String?
                cell.city.text = defaults.value(forKey:"city") as! String?
                cell.street.text = defaults.value(forKey:"state") as! String?
                cell.fName.text = defaults.value(forKey:"first_name") as! String?
                cell.emailId.text = defaults.value(forKey:"customer_email_id") as! String?
                cell.mobileNo.text = defaults.value(forKey:"mobile_no") as! String?

                

                
            }
            cell.addImg1.tag =  100

              cell.addImg1.addTarget(self, action: #selector(uploadList1), for: UIControlEvents.touchUpInside)
            cell.addImg2.tag =  101
            cell.addImg2.addTarget(self, action: #selector(uploadList1), for: UIControlEvents.touchUpInside)
            
            
            
            return cell
        }
        if indexPath.section == 2
        {
            //  var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCell
            let cell:sloteCell = self.checkOutTable.dequeueReusableCell(withIdentifier: "cell3") as! sloteCell
            
            cell.sloteTextField.delegate = self
            cell.commentTextFiled.delegate = self
            
            
            cell.continueBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
            cell.continueBtn.addTarget(self, action: #selector(contFunc), for: UIControlEvents.touchUpInside)
            
            
            return cell
        }
        if indexPath.section == 3
        {
            //  var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCell
            let cell:paymentCell = self.checkOutTable.dequeueReusableCell(withIdentifier: "cell4") as! paymentCell
            
            
            
            cell.contiBtn.tag =  Int((indexPath as NSIndexPath).row as NSNumber)
            cell.contiBtn.addTarget(self, action: #selector(contFunc), for: UIControlEvents.touchUpInside)
            
            
            return cell
        }
        else
        {
            let cell:UITableViewCell =  self.checkOutTable.dequeueReusableCell(withIdentifier: "cell")!
            
            
            
           
            
            
            return cell

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
        
        let indexPath = NSIndexPath(row: 0, section: 1)
        if self.path == 100 {
            
       
         let cell = self.checkOutTable.cellForRow(at: indexPath as IndexPath) as! deliveryAddCell!
            cell?.addImg1.setBackgroundImage(cust_img, for: .normal)
            
             }
        if self.path == 101 {
            
            
            let cell = self.checkOutTable.cellForRow(at: indexPath as IndexPath) as! deliveryAddCell!
            cell?.addImg2.setBackgroundImage(cust_img, for: .normal)
        }
        // cell?.addImg1.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        picker .dismiss(animated: true, completion: nil)
        self.uploadServer()
    }
    func uploadServer()   {
        let myUrl = NSURL(string: "http://test.tranzporthub.com/sellekt/shipping_address_images.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        
        
        
        let param = [
            "customer_id"    : NSString (format: "%d",defaults.value(forKey:"user_id") as! Int) as String,
            "cust_shipping_id"    : "" 
                        ] as [String : String]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(self.cust_img!, 0.5)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "shipping_image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        
        
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
              //  let dict:NSDictionary = jsonResult.value(forKey: "data") as! NSDictionary
                DispatchQueue.main.async {
                    let tem = jsonResult.value(forKey: "status") as! String
                    if tem=="200"
                        
                    {
                        print(jsonResult)
                    }
                }
                    }catch
                    {
                        print(error)
                    }
                    
                }
                
                task.resume()
                
                
                
                

        
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker .dismiss(animated: true, completion: nil)
        
        print("picker cancel.")
    }

    func contFunc()  {
        
        
    }
    func headerClicked(_ sender:UIButton) {
        
        for i in 0...acceptanceArr.count-1
        {
            let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: i) as? NSMutableDictionary
            dataDict?.setValue(false, forKey: "isOpened")
        }
        
        let dataDict : NSMutableDictionary? = self.acceptanceArr.object(at: sender.tag) as? NSMutableDictionary
        dataDict?.setValue(true, forKey: "isOpened")
        
        UIView.transition(with: self.checkOutTable, duration: 0.50, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.checkOutTable.reloadData()
        }, completion: nil)
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
