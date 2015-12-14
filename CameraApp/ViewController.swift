//
//  ViewController.swift
//  CameraApp
//
//  Created by Fabian on 12/9/15.
//  Copyright © 2015 individual. All rights reserved.
//

import UIKit
import MobileCoreServices
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //setting imageview for displaying the image selected on the app
   @IBOutlet var myImageView : UIImageView?;
    
    var newMedia = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickPhotoCamera(button:UIImageView)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let  controller : UIImagePickerController = UIImagePickerController();
            controller.delegate = self;  //this will allow us to do something in the app when it selects animage
            
            //this will allow us to go to editing mode
            controller.allowsEditing = true;
            controller.sourceType = UIImagePickerControllerSourceType.Camera;
            controller.mediaTypes = [kUTTypeImage as String]
            
            newMedia = true;
            self.presentViewController(controller, animated: true, completion: nil);
        }
    }
    
    @IBAction func onClickVideoCamera(button:UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let  controller : UIImagePickerController = UIImagePickerController();
            controller.delegate = self;  //this will allow us to do something in the pp when it selects animage
            
            //this will allow us to go to editing mode
            controller.allowsEditing = true;
            controller.sourceType = UIImagePickerControllerSourceType.Camera;
            
            //this will add the camera video
            controller.mediaTypes = [kUTTypeMovie as String]
            
            newMedia = true // actually, this line is unnecessary for video.
            self.presentViewController(controller, animated: true, completion: nil);
            // Cannot assign  vaule of type '[CFString]' to a valu of type '[String]'
        }
    }
    
    
    @IBAction func onClickPhotoLibrary(button: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let  controller : UIImagePickerController = UIImagePickerController();
            controller.delegate = self;  //this will allow us to do something in the pp when it selects animage
            
            //this will allow us to go to editing mode
            controller.allowsEditing = true;
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            newMedia = false;
            self.presentViewController(controller, animated: true, completion: nil);
        }
    }
    
    //this is the one that gets called as soon as the user selects an image in th epicker controller.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // PHOTO and PhotoLibrary
        if mediaType.isEqualToString(kUTTypeImage as String) {
            
            //this is when select the prt of the debug window, so in this case we select the item UIImagePickerController so we add it to a variable. and then add it to the image view to display image in the app
            
            let originImage = info[UIImagePickerControllerOriginalImage] as! UIImage        // If you set allowEditing=false, you need to use this one.
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage                // If you set allowEditing=true
            
            // Set ImageView with selected Image
            myImageView!.image = image
            
            if (newMedia) { // Check from Camera or PhotoLibrary
                
                // Save Image to Photo Library
                UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
            }
        // VIDEO
        } else if mediaType.isEqualToString(kUTTypeMovie as String) {
            // Get Video Path in NSURL
            let videoPath = info[UIImagePickerControllerMediaURL] as! NSURL
            
            // Save Video
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath.relativePath!, self, "video:didFinishSavingWithError:contextInfo:", nil)
        }
    }

    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>)
    {
        
        //this will let us if saving was successfull or not
        
        if (error == nil)
        {
            // nothing is wrong
        }   else
        {
            //problem here............
            
        }
        
    }
    

    func video(path: String, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>)
    {
        
        //this will let us if saving was successfull or not
        
        if (error == nil)
        {
            // nothing is wrong
        }   else
        {
            //problem here............
            
        }
        
    }
    //video function\
    
   
    
    
    
    

    
    
    
    
    
    
    
    


}

