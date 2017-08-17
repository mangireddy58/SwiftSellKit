//
//  MenuViewController.swift
//  LakeImaging
//
//  Created by Dinesh Jagtap on 11/08/16.
//  Copyright © 2016 MediaNX. All rights reserved.

import UIKit

protocol SlideMenuDelegate_rafrral {
    func slideMenuItemSelectedAtIndex(index : Int32)
}

class MenuViewController_rafrral: UIViewController ,UITableViewDelegate, UITableViewDataSource {
     @IBOutlet weak var tblExpandable: UITableView!
    @IBAction func homeVC(_ sender: UIButton) {
        
        let loginPageView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! tabBarVC
        self.navigationController?.pushViewController(loginPageView, animated: true)

    }
    @IBOutlet weak var homeBtn: UIButton!

    /**
    *  Array to display menu options
    */
   // @IBOutlet var tblMenuOptions : UITableView!
 
    /**
     var cellDescriptors: NSMutableArray?
     // 2d array which stores the index of visible cells for each section
     var visibleRowsPerSection = [[Int]]()
     

    *  Transparent button to hide menu
    */
    var cellDescriptors: NSArray?
    // 2d array which stores the index of visible cells for each section
    var visibleRowsPerSection = [[Int]]()
    

    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate_rafrral?
    var stateArray = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.homeBtn.backgroundColor = UIColor.black
      //  tblMenuOptions.tableFooterView = UIView()
       
        // Do any additional setup after loading the view.
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        
        // load plist file
        self.loadCellDescriptors()

    }
    
    func configureTableView() {
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        tblExpandable.tableFooterView = UIView(frame: CGRect.zero)
        
        tblExpandable.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
//        tblExpandable.register(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
//        tblExpandable.register(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
//        tblExpandable.register(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
//        tblExpandable.register(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
//        tblExpandable.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    }
    
    // Load plist file
    func loadCellDescriptors() {
        if let path = UserDefaults.standard.object(forKey: "cat") {
           // cellDescriptors = NSMutableArray(contentsOfFile: path)
            cellDescriptors = path as? NSArray
            for _ in cellDescriptors! {
                stateArray.append(false)
            }
            // Innitial call of getIndicesOfVisibleRows()
            
//            self.getIndicesOfVisibleRows()
//            self.tblExpandable.reloadData()
        }
    }
    
    

    func getIndicesOfVisibleRows() {
        self.visibleRowsPerSection.removeAll()
        
        for row in 0...((cellDescriptors?.count)! - 1) {
            var visibleRows = [Int]()
            
//            let currentSection = ((currentSectionCells as AnyObject).value(forKey:"all_subcategory")) as! NSArray
//            
//            for row in 0...(currentSection.count - 1) {
                let cell = cellDescriptors?[row] as! NSDictionary
          //     if cell.value(forKey:"isVisible" ) as! Bool == true {
                    visibleRows.append(row)
            //   }
            
            
            
            self.visibleRowsPerSection.append(visibleRows)
        }
         print(self.visibleRowsPerSection)
    }
    
    //
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> String   {
        let indexOfVisibleRow = self.visibleRowsPerSection[indexPath.section][indexPath.row]
        let item = self.cellDescriptors?[indexPath.section] as! NSDictionary
        let cellDescriptor = ((item as AnyObject).value(forKey:"category_name")) as! String
        return cellDescriptor as  String
//        let cellDescriptor = ((item as AnyObject).value(forKey:"all_subcategory")) as! NSArray
//        return cellDescriptor as NSArray
    }
    
    // MARK: UITableView Delegate and Datasource Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.cellDescriptors != nil {
            return self.cellDescriptors!.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visibleRowsPerSection[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return ""
        default:
            return ""
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath: indexPath as NSIndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellNormal", for: indexPath) as! CustomCell
        
       // if currentCellDescriptor["cellIdentifier"] as! String == "idCellNormal" {
        cell.textLabel?.text = currentCellDescriptor as? String
        cell.detailTextLabel?.text = ""
            
//            if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
//                cell.detailTextLabel?.text = secondaryTitle as? String
//            }
   //     }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellTextfield" {
//            cell.textField.placeholder = currentCellDescriptor["primaryTitle"] as? String
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSwitch" {
//            cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
//            
//            let value = currentCellDescriptor["value"] as? String
//            cell.swMaritalStatus.isOn = (value == "true") ? true : false
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellValuePicker" {
//            cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSlider" {
//            let value = currentCellDescriptor["value"] as! String
//            cell.slExperienceLevel.value = (value as NSString).floatValue
//        }
//        
//        
      //  cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath: indexPath as NSIndexPath)
        
                   return 44.0
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfTappedRow = self.visibleRowsPerSection[indexPath.section][indexPath.row]
        
        let section = cellDescriptors![indexPath.section] as! NSDictionary
       // let cell = section.value(forKey: "all_subcategory") as! NSArray
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = section.value(forKey: "category_id") as! Int
        self.onCloseMenuClick(button: btn)
        UserDefaults.standard.set(btn.tag, forKey: "category_id")
        
        if section["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
                 // In this case the cell should expand.
                shouldExpandAndShowSubRows = true
            
            // Too long line of code to access a nested mutableArray
            let tappedRow = (self.cellDescriptors![indexPath.section] as! NSMutableDictionary)
            
            tappedRow.setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            
            
            //It contains the total number of additional rows that should be displayed when an expandable cell is expanded.
       /*     let additionalRows = cell.count
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + additionalRows) {
                // Too long line of code to access a nested mutableArray
                section.setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
            }
        } else {
            //when such a cell is tapped, we want the respective top-level cell to collapse (and hide the options), and the value shown to the selected cell to be displayed to the top-level cell as well.
        }
        self.getIndicesOfVisibleRows()
        tblExpandable.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: UITableViewRowAnimation.fade)*/
    }
    }

    // MARK: Custom cell delegate to display user input such as (date picker, switch)
/*
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellDescriptor!.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = self.cellDescriptors?[section] as! NSDictionary
       // let cellDescriptor = ((item as AnyObject).value(forKey:"category_name")) as! String
     //   return cellDescriptor as  String
           let cellDescriptorArr = ((item as AnyObject).value(forKey:"all_subcategory")) as! NSArray

        if let count = cellDescriptorArr.count {
            return count
        } else {
            return 1
        }
    }
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        headerView.tag = section;
                    headerView.backgroundColor = UIColor.blueColor()
        
        var title = UILabel(frame: CGRectMake(10, 10, headerView.frame.width - 70, 30))
        let item = self.cellDescriptors?[section] as! NSDictionary
        let cellDescriptorStr = ((item as AnyObject).value(forKey:"category_name")) as! String

        title.text = cellDescriptorStr
        title.textAlignment = NSTextAlignment.left
        title.textColor = UIColor.darkText
        headerView.addSubview(title)
        
        var headerGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("sectionHeaderTapped:"))
        
        headerView.addGestureRecognizer(headerGesture)
        return headerView;
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if stateArray[indexPath.section] {
            return 50
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        if let colorFamily = colorFamilyMaps[colorFamilies[indexPath.section]]  {
            cell.backgroundColor = colorFamily[indexPath.row] as UIColor!
        }
        return cell
    }
    
    func sectionHeaderTapped(gestureRecognizer:UITapGestureRecognizer){
        if let section = gestureRecognizer.view?.tag {
            stateArray[section] = !stateArray[section]
            self.tblExpandable.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }*/


    
    @IBAction func onCloseMenuClick(button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -2
            }
            delegate?.slideMenuItemSelectedAtIndex(index: index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = self.CGRectMake(-UIScreen.main.bounds.size.width, 0, UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }

    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
 /* internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(button: btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }*/
}
