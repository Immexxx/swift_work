//
//  MasterViewController.swift
//  TinyPix
//
//  Created by yeshaokai on 2/28/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet var colorControl: UISegmentedControl!
    private var documentFileNames: [String] = []
    private var chosenDocument: TinyPixDocument?
    
    private func urlForFileName(fileName: NSString)
        -> NSURL {
            let fm = NSFileManager.defaultManager()
            let urls = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,inDomains: NSSearchPathDomainMask.UserDomainMask) as [NSURL]
            let directoryURL = urls[0]
            let fileURL = directoryURL.URLByAppendingPathComponent(fileName)
            return fileURL
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add,target:self,
            action:"insertNewObject")
        navigationItem.rightBarButtonItem = addButton
        let prefs = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = prefs.integerForKey("selectedColorIndex")
        setTintColorForIndex(selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
        reloadFiles()
        
    }
    func insertNewObject() {
        let alert = UIAlertController(title:"Choose File Name",message: "Enter a name for your new TinyPix document",preferredStyle:.Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title:"Create",style:.Default){
            action in let textField = alert.textFields![0] as UITextField
            self.createFileNamed(textField.text)
        };
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    private func createFileNamed(fileName: String) {
        let trimmedFileName = fileName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if !trimmedFileName.isEmpty {
            let targetName = ".tinypix"
            let saveUrl = urlForFileName(targetName)
            chosenDocument = TinyPixDocument(fileURL:saveUrl)
            chosenDocument?.saveToURL(saveUrl, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: {
                success in if success {
                    println ("save ok")
                    self.reloadFiles()
                    self.performSegueWithIdentifier("masterToDetail", sender: self)
                    
                }else {
                    println ("Failed to save!")
                }
            })
        }
    }
    private func reloadFiles(){
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
        NSSearchPathDomainMask.UserDomainMask,true) as [String]
        let path = paths[0]
        let fm = NSFileManager.defaultManager()
        var error:NSError? = nil;
        let files = fm.contentsOfDirectoryAtPath(path, error: &error) as? [String]
        if files != nil {
            let sortedFileNames = sorted(files!) {
                fileName1, fileName2 in let file1Path = path.stringByAppendingPathComponent(fileName1)
                let file2Path = path.stringByAppendingPathComponent(fileName2)
                let attr1 = fm.attributesOfItemAtPath(file1Path, error: nil)
                let attr2 = fm.attributesOfItemAtPath(file2Path, error: nil)
                let file1Date = attr1! [NSFileCreationDate] as NSDate
                let file2Date = attr2! [NSFileCreationDate] as NSDate
                let result = file1Date.compare(file2Date)
                return result == NSComparisonResult.OrderedAscending
            }
            documentFileNames = sortedFileNames
            tableView.reloadData()
        }else {
            println("Error listing files in directory \(path): \(error)")
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func prepareForSegue(segue: UIStoryboardSegue,sender:AnyObject?){
        let destination = segue.destinationViewController as UINavigationController
        let detailVC = destination.topViewController as DetailViewController
        if sender === self {
            // if sender === self, a new document has been created
            // and chosenDocument is already set
            detailVC.detailItem = chosenDocument
        }else {
            // find the chosen document from the tableview
            let indexPath = tableView.indexPathForSelectedRow()!
            let filename = documentFileNames[indexPath.row]
            let docURL = urlForFileName(filename)
            chosenDocument = TinyPixDocument(fileURL:docURL)
            chosenDocument?.openWithCompletionHandler(){success in if success{
                println("load ok")
                detailVC.detailItem = self.chosenDocument
            }else {
                println("Failed to load!")
                }
            }
        }
    }
    override func tableView(tableView: UITableView,numberOfRowsInSection section:Int) -> Int {
        return documentFileNames.count
    }
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FileCell") as UITableViewCell
        let path = documentFileNames[indexPath.row]
        cell.textLabel?.text = path.lastPathComponent.stringByDeletingPathExtension
        return cell
    }
    @IBAction func chooseColor(sender: UISegmentedControl){
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(selectedColorIndex)
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
    }
    private func setTintColorForIndex(colorIndex: Int) {
        colorControl.tintColor = TinyPixUtils.getTintColorForIndex(colorIndex)
    }
    
}

