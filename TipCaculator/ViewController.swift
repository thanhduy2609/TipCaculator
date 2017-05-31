//
//  ViewController.swift
//  TipCaculator
//
//  Created by Duy Bùi on 5/20/17.
//  Copyright © 2017 Duy Bùi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var lblTip: UILabel!
    
    
    @IBOutlet weak var lblSum: UILabel!
    
    var tip: Double = 5;
    @IBAction func btnResult(_ sender: Any) {
        var result: Double = Double(txtPrice.text!)! + (Double(txtPrice.text!)! * tip) / 100;
        lblSum.text = String(result)
        
        filePathHistory = documentDir?.appendingPathComponent("history.txt") as! String as NSString
        if !(fileManager?.fileExists(atPath: filePathHistory! as String))! {
            fileManager?.createFile(atPath: filePathSetting! as String, contents: nil, attributes: nil)
            //save data file
            let content = lblSum.text!
            let fileContent: Data = content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("history.txt")), options: [.atomic])
        }
        else {
            var fileContentHistory: Data?
            fileContentHistory = fileManager?.contents(atPath: filePathHistory! as String)
            let str: NSString = NSString(data: fileContentHistory!, encoding: String.Encoding.utf8.rawValue)!
            //fileManager?.createFile(atPath: filePathSetting! as String, contents: nil, attributes: nil)
            //save data file
            let content = String((str as String) + ","+lblSum.text!)!
            let fileContent: Data = content.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("history.txt")), options: [.atomic])
        }
    }
    
    var fileManager: FileManager?
    var filePathSetting: NSString?
    var filePathHistory: NSString?
    var documentDir: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //use for setting
        filePathSetting = documentDir?.appendingPathComponent("setting.txt") as! NSString
        if !(fileManager?.fileExists(atPath: filePathSetting! as String))! {
            fileManager?.createFile(atPath: filePathSetting! as String, contents: nil, attributes: nil)
            //save default file
            let content: NSString = NSString(string: "5")
            let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
            try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("setting.txt")), options: [.atomic])
            
            //set text
            lblTip.text = "5%"
            tip = 5
            
        }
        else {
            //filePathSetting = documentDir?.appendingPathComponent("setting.txt") as! String as NSString
            var fileContent: Data?
            fileContent = fileManager?.contents(atPath: filePathSetting! as String)
            let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
            //set text
            lblTip.text = (str as String) + "%"
            tip = (Double(str as String))!
        }

    }


}

