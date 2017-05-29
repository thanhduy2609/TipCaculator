//
//  SettingViewController.swift
//  TipCaculator
//
//  Created by Duy Bùi on 5/29/17.
//  Copyright © 2017 Duy Bùi. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["5", "10", "15"]
    var fileManager: FileManager?
    var filePath: NSString?
    var documentDir: NSString?
    var tip: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(documentDir)")


        // Do any additional setup after loading the view.
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        //create file
        filePath = documentDir?.appendingPathComponent("setting.txt") as! NSString
        if !(fileManager?.fileExists(atPath: filePath! as String))! {
            fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
            //save default file
            let content: NSString = NSString(string: "5")
            let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
            try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("setting.txt")), options: [.atomic])
    
        }
        else {
            filePath = documentDir?.appendingPathComponent("setting.txt") as! String as NSString
            var fileContent: Data?
            fileContent = fileManager?.contents(atPath: filePath! as String)
            let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
            if str == "5"{
                self.pickerView.selectRow(0, inComponent: 0, animated: true)
            }
            else if str == "10" {
                self.pickerView.selectRow(1, inComponent: 0, animated: true)
            }
            else {
                self.pickerView.selectRow(2, inComponent: 0, animated: true)
            }
            
        }
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        tip = pickerDataSource[row];
        return (pickerDataSource[row] + "%")
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if !(tip == "") {
            //save data
            filePath = documentDir?.appendingPathComponent("setting.txt") as! NSString
            if (fileManager?.fileExists(atPath: filePath! as String))! {
                fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
                //save default file
                let content: NSString = tip as NSString
                let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
                try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("setting.txt")), options: [.atomic])
                
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

}
