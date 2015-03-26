//
//  ViewController.swift
//  CloudKitDemo
//
//  Created by yeshaokai on 3/6/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit
import CloudKit
import MobileCoreServices
class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var commentsField: UITextView!
   
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    let container = CKContainer.defaultContainer()
    var publicDatabase: CKDatabase?
    var currentRecord: CKRecord?
    var photoURL: NSURL?
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        addressField.endEditing(true)
        commentsField.endEditing(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        publicDatabase = container.publicCloudDatabase
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveRecord(sender: AnyObject) {
        if (photoURL == nil) {
            notifyUser( "No Photo",message:"Use the photo option to choose a photo for the record")
            return
        }
        let asset = CKAsset(fileURL: photoURL!)
        let myRecord = CKRecord(recordType: "Houses")
        myRecord.setObject(addressField.text, forKey: "address" )
        myRecord.setObject(commentsField.text, forKey: "comment")
        myRecord.setObject(asset, forKey: "photo")
        publicDatabase!.saveRecord(myRecord, completionHandler: ({returnRecord,error in
            if let err = error {
                self.notifyUser("Save Error", message: err.localizedDescription)
            }else {
                dispatch_async(dispatch_get_main_queue()){
                    self.notifyUser("Success",message:"Record saved successfully")
                }
                self.currentRecord = myRecord
            }
        }))
    }
    func notifyUser(title:String, message: String) -> Void {
        let alert = UIAlertController(title: title,message: message,preferredStyle:UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title:"OK",style:.Cancel,handler:nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBAction func performQuery(sender: AnyObject) {
        let predicate = NSPredicate(format: "address = %@", addressField.text)
        let query = CKQuery(recordType: "Houses", predicate: predicate)
        publicDatabase?.performQuery(query,inZoneWithID: nil , completionHandler: ({
            results,error in
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.notifyUser("cloud access error", message: error.localizedDescription)
                }
                    
            }else {
                if results.count > 0 {
                    var record = results[0] as CKRecord
                    self.currentRecord = record
                    dispatch_async(dispatch_get_main_queue()){
                        self.commentsField.text = record.objectForKey("comment") as String
                    let  photo = record.objectForKey("photo") as CKAsset
                    let image = UIImage(contentsOfFile: photo.fileURL.path!)
                    self.imageView.image = image
                    self.photoURL = self.saveImageToFile(image!)
                    }
                }else {
                    dispatch_async(dispatch_get_main_queue()){
                        self.notifyUser("No match found", message: "No record matching the address ")
                    }
                }
            
            }
        }))
    
    }
    func imagePickerController(picker:UIImagePickerController!,didFinishPickingMediaWithInfo info:[NSObject : AnyObject]! ) {
        self.dismissViewControllerAnimated( true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        imageView.image = image
        photoURL = saveImageToFile(image)
    }
    func saveImageToFile(image: UIImage) -> NSURL{
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir: AnyObject = dirPaths[0]
        let filePath = docsDir.stringByAppendingPathComponent("currentImage.png")
        UIImageJPEGRepresentation(image,0.5).writeToFile(filePath, atomically: true)
        return NSURL.fileURLWithPath(filePath)!
    }
    func imagPickerControllerDidCancel (picker:UIImagePickerController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func selectPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updateRecord(sender: AnyObject) {
        if let record = currentRecord {
            let assect = CKAsset(fileURL:photoURL! )
            record.setObject(addressField.text, forKey: "address")
            record.setObject(commentsField.text, forKey: "comment")
            record.setObject(assect, forKey: "photo")
                publicDatabase!.saveRecord(record, completionHandler: ({
                    returnRecord,error in
                    if let err = error {
                        dispatch_async(dispatch_get_main_queue()){
                            self.notifyUser("Update Error", message: err.localizedDescription)
                        }
                    }else {
                        dispatch_async(dispatch_get_main_queue()){
                            self.notifyUser("success", message: "record updated successfully")
                        }
                    }
            }))
        
        }else {
            notifyUser("No record selected", message:"user query to select a record to update")
        }
    }
    @IBAction func deleteRecord(sender: AnyObject) {
        if let record = currentRecord {
            publicDatabase?.deleteRecordWithID(record.recordID,completionHandler:({returnRecord,error in
                if let err = error {
                    dispatch_async(dispatch_get_main_queue()){
                        self.notifyUser("delete error", message: err.localizedDescription)
                    }
                }else {
                    dispatch_async(dispatch_get_main_queue()){
                        self.notifyUser("scucess", message: "record deleted")
                    }
                }
            }))
        }else {
            notifyUser("no record selected", message: "use query to select a record in delete")
        }
    
    }

}

