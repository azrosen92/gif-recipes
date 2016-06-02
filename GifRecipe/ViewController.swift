//
//  ViewController.swift
//  GifRecipe
//
//  Created by Aaron Rosen on 5/13/16.
//  Copyright © 2016 Aaron Rosen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    let movieCaptureOutput = AVCaptureVideoDataOutput()
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    @IBAction func toggleRecording(sender: UIButton) {
        if captureSession.running {
            captureSession.stopRunning()
        } else {
            captureSession.startRunning()
            saveVideo()
        }
    }
    
    func saveVideo() {
        
    }
    
    func prepareForVideoCapture() {
        captureSession.addInput(
            try? AVCaptureDeviceInput(device: captureDevice))
        if captureSession.canAddOutput(movieCaptureOutput) {
            captureSession.addOutput(movieCaptureOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil {
            prepareForVideoCapture()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

