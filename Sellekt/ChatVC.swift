//
//  ChatVC.swift
//  Sellekt
//
//  Created by Nikhil Boriwale on 27/03/17.
//  Copyright © 2017 appziatech. All rights reserved.
//

import UIKit

class ChatVC: UIViewController , UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var TableChat: UITableView!
    let ArrayshopItem = ["Nikhil","boriwale","sail", "kiran"]

    override func viewDidLoad() {
        super.viewDidLoad()
        TableChat.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayshopItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.lblUsername.text = ArrayshopItem [indexPath.row]
      
        return cell
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
