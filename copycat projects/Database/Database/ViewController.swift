//
//  ViewController.swift
//  Database
//
//  Created by yeshaokai on 3/6/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var status: UILabel!
    var databasePath = NSString()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let  fileManager = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        databasePath = docsDir.stringByAppendingPathComponent("contacts.db")
        println("before it gets here")
        if fileManager.fileExistsAtPath(databasePath){
            println("already exist")
        }
        if fileManager.fileExistsAtPath(databasePath){
            let contactDB = FMDatabase(path: databasePath)
            println("db is \(contactDB)")
            if contactDB == nil {
                println("or got here")
                println("Error1 :\(contactDB.lastErrorMessage())")
            }
            if contactDB.open() {
                println("got here")
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt){
                    println("Error2: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            }else {
                println("Error3: \(contactDB.lastErrorMessage())")
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveData(sender: AnyObject) {
        let contactDB = FMDatabase(path:databasePath)
        if contactDB.open(){
            let insertSQL = "INSERT INTO CONTACTS (name,address,phone) VALUES ('\(name.text)','\(address.text)','\(phone.text)')"
            let result = contactDB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            if !result {
                status.text = "Failed to add contact"
                println("Error4: \(contactDB.lastErrorMessage())")
            }else {
                status.text = "Contact added"
                name.text = ""
                address.text = ""
                phone.text = ""
            }
        }else {
            println("Error here: \(contactDB.lastErrorMessage())")
        }
    }

    @IBAction func findContact(sender: AnyObject) {
        let contactDB = FMDatabase(path: databasePath)
        if contactDB.open(){
            let querySQL = "SELECT address, phone FROM CONTACTS WHERE name = '\(name.text)'"
            let results:FMResultSet? = contactDB.executeQuery(querySQL, withArgumentsInArray: nil)
            if results?.next() == true {
                address.text == results?.stringForColumn("address")
                phone.text = results?.stringForColumn("phone")
                status.text = "Record found"
            }else {
                status.text = "record not found"
                address.text = ""
                phone.text = ""
            }
            contactDB.close()
        }else {
            println("Error5 \(contactDB.lastErrorMessage())")
        }
    }
}

