//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by yeshaokai on 2/13/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class CustomPickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var winLabel: UILabel!
    private var images:[UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = [ UIImage(named:"seven")!,UIImage(named: "bar")! ,UIImage(named: "crown")!,UIImage(named: "cherry")!,UIImage(named: "lemon")!,UIImage(named: "apple")! ]
        winLabel.text = " "

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func spin(sender: AnyObject) {
        var win = false
        var numberInRow = -1
        var lastVal = -1
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal{
                numberInRow++
            }else{
                numberInRow = 1
            }
            lastVal = newValue
            picker.selectRow(newValue,inComponent: i , animated: true)
            picker.reloadComponent(i)
            if numberInRow >= 3{
                win = true
            }
        }
        winLabel.text = win ? "Winner!" : " "
        
    }
  // MARK :- Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)-> Int {
        return images.count
    }
    //MARK:-
    //MARK: Picker Delegate Methods
    func pickerView(pickerView:UIPickerView, viewForRow row: Int, forComponent component: Int,reusingView view:
        UIView!) -> UIView {
            let image = images[row]
            let imageView = UIImageView(image:image)
            return imageView
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int)->CGFloat {
        return 64
    }
    
   

}
