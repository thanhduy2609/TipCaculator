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
    
    
    @IBAction func btnResult(_ sender: Any) {
    }
    
    var fileManager: FileManager?
    var filePathSetting: NSString?
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
            
        }
        else {
            filePathSetting = documentDir?.appendingPathComponent("setting.txt") as! String as NSString
            var fileContent: Data?
            fileContent = fileManager?.contents(atPath: filePathSetting! as String)
            let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
            //set text
            lblTip.text = (str as String) + "%"
            
        }

    }


}

