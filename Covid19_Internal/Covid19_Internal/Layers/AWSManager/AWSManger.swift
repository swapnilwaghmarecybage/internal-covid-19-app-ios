//
//  AWSManger.swift
//  Covid19_Internal
//
//  Created by Mayuri Shekhar on 05/10/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import UIKit
import AWSS3


typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void

class AWSS3Manager {
    
    static let shared = AWSS3Manager()
    private init () { }
    let bucketName = "covidcare"
   
    func uploadImage(image: UIImage, completion: completionBlock?) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
            completion?(nil, error)
            return
        }
        
        let tmpPath = NSTemporaryDirectory() as String
        let fileName: String = ProcessInfo.processInfo.globallyUniqueString + (".jpeg")
        let filePath = tmpPath + "/" + fileName
        let fileUrl = URL(fileURLWithPath: filePath)
        
        do {
            try imageData.write(to: fileUrl)
            self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: "image/jpeg", completion: completion)
        } catch {
            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
            completion?(nil, error)
        }
    }
 
    
   
    func getUniqueFileName(fileUrl: URL) -> String {
        let strExt: String = "." + (URL(fileURLWithPath: fileUrl.absoluteString).pathExtension)
        return (ProcessInfo.processInfo.globallyUniqueString + (strExt))
    }
 
    private func uploadfile(fileUrl: URL, fileName: String, contenType: String, completion: completionBlock?) {
        
        let expression = AWSS3TransferUtilityUploadExpression()
        
      var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
      completionHandler = {(task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if error == nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
                    print("Uploaded to:\(String(describing: publicURL))")
                    if let completionBlock = completion {
                        completionBlock(publicURL?.absoluteString, nil)
                    }
                } else {
                    if let completionBlock = completion {
                        completionBlock(nil, error)
                    }
                }
            })
        }
        let awsTransferUtility = AWSS3TransferUtility.default()
        
        awsTransferUtility.uploadFile(fileUrl, bucket: bucketName, key: fileName, contentType: contenType, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
            if let error = task.error {
                print("error is: \(error.localizedDescription)")
            }
            if let _ = task.result {
                print("upload Started")

            }
            return nil
        }
        
      
    }
}
