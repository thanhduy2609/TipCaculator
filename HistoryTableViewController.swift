//
//  HistoryTableViewController.swift
//  TipCaculator
//
//  Created by Duy Bùi on 5/31/17.
//  Copyright © 2017 Duy Bùi. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var fileManager: FileManager?
    var filePath: NSString?
    var documentDir: NSString?
    var filePathHistory: NSString?
    var historyArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        
        filePathHistory = documentDir?.appendingPathComponent("history.txt") as! NSString
        if (fileManager?.fileExists(atPath: filePathHistory! as String))! {
            var fileContent: Data?
            fileContent = fileManager?.contents(atPath: filePathHistory! as String)
            let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
            
            historyArr = str.components(separatedBy: ",");
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = historyArr[indexPath.row]
        return cell
    }

}
