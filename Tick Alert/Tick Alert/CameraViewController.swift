//
//  CameraViewController.swift
//  Tick Alert
//
//  Created by David Freeman on 10/8/17.
//  Copyright © 2017 David Freeman. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet var helpButton: UIButton!
    @IBOutlet weak var guideBox: UIImageView!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var capturePhotoButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    @IBAction func helpButtonPressed(_ sender: Any) {
        let tipsController = storyboard?.instantiateViewController(withIdentifier: "CameraTips") as! CameraTipsViewController
        navigationController?.pushViewController(tipsController, animated: true)
    }
    // TODO: Add functionality to the button being pressed
//    @IBAction func captureButtonPressed(_ sender: Any) {
//        capturePhotoButton.currentImage = captureButton
//    }
    
    // Captures a photo after the button is pressed
    @IBAction func onTapCapture(_ sender: Any) {
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        
        let photoSettings = AVCapturePhotoSettings()
        
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    // Sets the View up once it is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            
            captureSession?.addOutput(capturePhotoOutput!)
        } catch {
            print(error)
        }
        
        guideBox.layer.zPosition = 1
        guideLabel.layer.zPosition = 1
        capturePhotoButton.layer.zPosition = 1
        helpButton.layer.zPosition = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CameraViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error == nil {
                print("Error capturing photo: \(String(describing: error))")
                return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
                return
        }
        // Initialise a UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let image = capturedImage {
            // Save our captured image to photos album
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}
