//
//  ViewController.swift
//  ModelBlock
//
//  Created by QUYNV on 11/30/16.
//  Copyright © 2016 QUYNV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "data", ofType: "plist")
        let raw = NSDictionary(contentsOfFile: filePath!)!
        
        for item in raw.allKeys {
            data.append(raw[item] as! NSDictionary)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCell", owner: self, options: nil)?.first as! CustomCell
        let key = data[indexPath.row]
        
        cell.lblName.text = key["name"] as? String
        cell.lblMeasure.text = key["measure"] as? String

        if let url = NSURL(string: (key["image"]! as? String)!) {
            DispatchQueue.global().async {
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async(execute: {
                        cell.imgView.image = UIImage(data: data as Data)
                    })
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }


}

