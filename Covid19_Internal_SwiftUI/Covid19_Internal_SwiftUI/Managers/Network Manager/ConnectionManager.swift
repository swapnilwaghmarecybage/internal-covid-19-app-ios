//
//  ConnectionManager.swift
//  VungleShowcase
//
//  Created by Vilas on 1/18/18.
//  Copyright © 2018 Cybage. All rights reserved.
//

import UIKit
import Foundation

struct ErrorMessage {
    
    // MARK: Instance properties
    
    /// It says about http status code
    private let statusCode : Int?
    
    /// It says about status message
    private let statusMessage : String?
    
    /// It says about error message
    private let errorMessage : String?
    
    // MARK: Initializers
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - sCode: Http Status code
    ///   - sMessage: Http Status message.
    ///   - eMessage: Error message to be shown.
    init(statuCode sCode: Int? , statusMessage sMessage: String?, errorMessage eMessage: String?) {
        self.statusCode = sCode
        self.statusMessage = sMessage
        self.errorMessage = eMessage
    }
    
    // MARK: Instance Methods
   
    /// It says about http status code
    ///
    /// - Returns: http status code.
    func statusCodeValue() -> Int? {
        return self.statusCode
    }
    
    /// It says about status message
    ///
    /// - Returns: http status message.
    func statusMessageValue() -> String? {
        return self.statusMessage
    }
    
    /// It says about error message
    ///
    /// - Returns: http error message.
    func errorMessageValue() -> String? {
        return self.errorMessage
    }
}

class ConnectionManager : NSObject {
    
    // MARK: - Properties
    
    /// array of active connections.
    var activeConnections = [URLSessionDataTask : Request]()
    
    /// download session for DownloadManager
    lazy var connectionSession : URLSession = { [unowned self] in
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
        }()
    
    /// ConnectionManager sharedInstance
    static let sharedInstance = ConnectionManager()
    
    // MARK: - Class LifeCycle Methods
    
     override init() {
        
        super.init()
        
        _ = self.connectionSession
    }
    
    deinit {
        //print("download manager deinit")
        
    }
    
    // MARK: - Instance methods
    
    /// start downloading with download object
    ///
    /// - Parameter requestObject: Download object which represent remote url and other stuff
    func start(request requestObject : Request) {
        
        let request = NSMutableURLRequest(url: requestObject.requestURL() as URL)
        
        for key in requestObject.dictHeaderKeyValues.keys {
            if let value = requestObject.dictHeaderKeyValues[key] {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // If condition goes if request is POST
        if requestObject.httpMethod == .post {
            
            // This is post request
            request.httpMethod = "POST"
            
            //define the multipart request type
            let boundary = "com.cybage.salesdemoapp"
            
            //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let body = NSMutableData()
            
            //define the data post parameter
            
            if requestObject.dictParams.isEmpty == false {
                let dictParams = requestObject.dictParams
                for key in dictParams.keys {
                    body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                    body.append("Content-Disposition:form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                    if let value = dictParams[key] {
                        body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
                    }
                }
            }
            
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
            
            request.httpBody = body as Data
            
        }
        
        let dataTask = self.connectionSession.dataTask(with: request as URLRequest)
        
        activeConnections[dataTask] = requestObject
        dataTask.resume()
        
    }
}

extension ConnectionManager : URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let credential:URLCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, credential)
    }
}

extension ConnectionManager : URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        if let request = activeConnections[dataTask] {
            let responseData = request.responseData
            responseData.append(data)
            
            if request.expectedContentLength > 0 {
                request.progress = Float(responseData.length) / Float(request.expectedContentLength)
            }
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
        
        //let expectedContentLength = Int(response.expectedContentLength)
        if let request = activeConnections[dataTask] {
            request.expectedContentLength = response.expectedContentLength
            print("expectedContentLength  === \(request.expectedContentLength)")
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        //print("did complete with error")
        
        if let dataTask = task as? URLSessionDataTask, let request = activeConnections[dataTask] {
            
            let httpResponse = dataTask.response as? HTTPURLResponse
            
//            print("staus code == \(httpResponse?.statusCode)")
            
            if let errorObject = error {
                print("error found in connecting == \(errorObject.localizedDescription)")
                
                request.failureHandler?(nil,httpResponse)
                activeConnections[dataTask] = nil
            } else {
                
                // Success
                let responseData = request.responseData
                if let handler = request.successHandler {
                    handler(responseData as Data?, httpResponse)
                }
                //request.successHandler?(responseData as Data?,httpResponse)
                //activeConnections[dataTask] = nil
            }
        }
    }
}
