//
//  ViewController.swift
//  WherePedia
//
//  Created by yeshaokai on 3/12/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit
import CloudKit
import MobileCoreServices
import CoreLocation
class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    var currentLocation: CLLocation?
    let container = CKContainer.defaultContainer()
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var publicDatabase: CKDatabase?
    var currentRecord: CKRecord?
    var photoURL: NSURL?
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        textView.endEditing(true)
        
    }
    func notifyUser(title:String, message: String) -> Void {
        let alert = UIAlertController(title: title,message: message,preferredStyle:UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title:"OK",style:.Cancel,handler:nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        publicDatabase = container.publicCloudDatabase
        // Do any additional setup after loading the view, typically from a nib.
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]! ){
    //var latestLocation: AnyObject = locations[locations.count - 1]
        currentLocation = locations[locations.count - 1] as CLLocation
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePhoto(sender: AnyObject) {
    }

    @IBAction func checkLibrary(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString]
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func Upload(sender: AnyObject) {
        if (photoURL == nil) {
            notifyUser( "No Photo",message:"Use the photo option to choose a photo for the record")
            return
        }
        let asset = CKAsset(fileURL: photoURL!)
        let myRecord = CKRecord(recordType: "pedia")
        
        myRecord.setObject(textView.text, forKey: "comment")
        myRecord.setObject(asset, forKey: "photo")
        if let cl = currentLocation {
        myRecord.setObject(cl.coordinate.longitude as Double, forKey: "longitude")
        myRecord.setObject(cl.coordinate.latitude as Double, forKey: "latitude")
        }
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
    
}
