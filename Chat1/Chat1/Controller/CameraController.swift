//
//  ViewController.swift
//  Build-A-Bod2
//
//  Created by Micah Yong on 2/9/19.
//  Copyright © 2019 Micah Yong. All rights reserved.
//

import UIKit
import AVKit
import Vision

protocol ClassBDelegate {
    func passingSomeValue(val : String)
}

class CameraController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    var goodCount = 0;
    
    var user: MyUser? {
        didSet {
            navigationItem.title = "PUSHUP TIME"
        }
    }
    
    let identifierLabel: UILabel = {
        let label = UILabel() // may add if statements here
        label.backgroundColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete", style: .plain, target: self, action: #selector(handleCancel))
        
        
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        // guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func handleCancel() {
        
        let alert = UIAlertController(title: "Hi \(self.user?.name ?? "User")!", message: "You gained \(self.goodCount) FitCoins!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.handleDismiss()
                print("default") 
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                self.handleDismiss()
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //        print("Camera was able to capture a frame:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: mlModel().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                if (((firstObservation.confidence * 100) > 50.0) && (firstObservation.identifier == "good pushup")) {
                    self.identifierLabel.backgroundColor = .green
                    self.goodCount += 1
                    self.user?.points += 1
                    self.navigationItem.title = String(self.goodCount)
                } else {
                    self.identifierLabel.backgroundColor = .red
                }
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    
}

