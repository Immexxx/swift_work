//
//  reviewViewController.swift
//  WherePedia
//
//  Created by yeshaokai on 3/18/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit
import MapKit
class reviewViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var reviewimageView: UIImageView!
    @IBOutlet weak var reviewmapView: MKMapView!
    var prepimage: UIImage?
    var preptext: String?
    var Pin  : MKPointAnnotation?
    var preplocation : CLLocation?
    @IBOutlet weak var reviewtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Pin = MKPointAnnotation()
        Pin!.coordinate = preplocation!.coordinate as CLLocationCoordinate2D
        Pin!.title = preptext
        
        reviewmapView.addAnnotation(Pin)
        reviewmapView.addSubview(backButton)
        reviewmapView.addSubview(reviewimageView)
        reviewmapView.showsUserLocation = true
        reviewmapView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func mapView(mapView: MKMapView! , didUpdateUserLocation userLocation: MKUserLocation){
        mapView.centerCoordinate = userLocation.location.coordinate
    }
     override func viewDidAppear(animated: Bool) {
        
        reviewmapView.showsUserLocation = true
        let userLocation = reviewmapView.userLocation
        println(userLocation.location.coordinate)
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000)
        reviewmapView.setRegion(region , animated: false)
        
        //reviewmapView.addAnnotation(Pin)
        
        //reviewmapView.addAnnotation(annotation)
        //reviewimageView.image = prepimage
        //reviewtextField.text = preptext
        
    }
    func mapView (mapView: MKMapView! , viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation is MKUserLocation){
            return nil
        }
        
        var annotationView = MKAnnotationView()
        annotationView.annotation = Pin
        var imageView = UIImageView(frame: CGRectMake(0, 0, 50, 50)) // set as you want
        var newLabel = UILabel(frame:CGRectMake(0,50,50,50))
        newLabel.text = "i am not sure"
        imageView.image = prepimage
        //annotationView.addSubview(newLabel)
        //annotationView.addSubview(imageView)
        
        //annotationView.image = prepimage!
        //annotationView.image.size
        annotationView.canShowCallout = true
        annotationView.enabled = true
        let deleteButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        deleteButton.frame.size.width = 44
        deleteButton.frame.size.height = 44
        deleteButton.backgroundColor = UIColor.redColor()
        annotationView.leftCalloutAccessoryView = deleteButton
        return annotationView
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func `return`(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func returned(segue: UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
