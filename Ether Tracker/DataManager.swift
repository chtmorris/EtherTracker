//
//  DataManager.swift
//  Ether Tracker
//
//  Created by Charlie Morris on 17/05/2016.
//  Copyright © 2016 Mind Fund Studio. All rights reserved.
//

import Foundation

public class DataManager {
    
    public class func getEtherPriceFromUrlWithSuccess(success: ((EtherData: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: "https://coinmarketcap-nexuist.rhcloud.com/api/eth")!, completion:{(data, error) -> Void in
            if let data = data {
                success(EtherData: data)
            }
        })
    }
    
    public class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        }
        
        loadDataTask.resume()
    }
    
}
