//
//  CameraViewController.swift
//  instagram
//
//  Created by Reis Sirdas on 3/3/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    let size = UIScreen.mainScreen().applicationFrame.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            photo.image = originalImage
            // Do something with the images (based on your use case)
            photo.image = self.resize(originalImage!, newSize: resizeHelper())
            // Dismiss UIImagePickerController to go back to your original view controller
            self.selectButton.titleLabel!.hidden = true
            dismissViewControllerAnimated(true, completion: {})
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: {
            if self.photo.image != nil {
                self.selectButton.titleLabel!.hidden = true
            } else {
                self.selectButton.titleLabel!.hidden = false
            }
        })
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        if self.photo.image != nil {
            Post.postUserImage(self.photo.image, withCaption: self.captionField.text, withCompletion: nil)
            self.photo.image = nil
            self.captionField.text = nil
            self.selectButton.titleLabel!.hidden = false
            sleep(2)
            tabBarController?.selectedIndex = 0
        }
    }
    
    @IBAction func onSelect(sender: AnyObject) {
    
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(vc, animated:true, completion: {})
    }
    
    func resizeHelper() -> CGSize {
        let width = Int(self.size.width)
        let ratio = photo.image!.size.width / photo.image!.size.height
        let height = Int(CGFloat(width)/ratio)
        return CGSize(width: width, height: height)
    }

    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
