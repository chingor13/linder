//
//  AvvoAPIClient.swift
//  Linder
//
//  Created by Kyle on 10/14/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import Foundation

class AvvoAPIClient {
    
    class func fetchLawyers(lawyerHandler: (Array<Lawyer>) -> ()) -> Void {
        var lawyers: Array<Lawyer> = [
            Lawyer(firstname: "Jackie", lastname: "Chiles", headshotUrl: "http://www.thehollywoodnews.com/wp-content/uploads/Jackie-Chiles1.jpg"),
            Lawyer(firstname: "Bob", lastname: "Loblaw", headshotUrl: "http://img3.wikia.nocookie.net/__cb20121117203508/arresteddevelopment/images/e/e6/3x3_Bob_Loblaw.png"),
            Lawyer(firstname: "Barry", lastname: "Zuckercorn", headshotUrl: "http://i.guim.co.uk/static/w-620/h--/q-95/sys-images/Media/Columnists/Columnists/2011/6/14/1308048837538/Arrested-Development-Henr-007.jpg")
        ]
        
        lawyerHandler(lawyers)
    }
    
//    class func fetchLawyers(lawyerHandler: (NSArray) -> ()) -> Void {
//        // TODO: Handle errors.
//        // TODO: Pass location to the server
//        
//        // TODO: Move the queryString generation into the apiRequestForPath method.
//        var request = apiRequestForPath("/lawyers")
//        
//        var lawyers: NSArray = NSArray()
//        
//        // DEBUG: print out request body
//        println("=== Request: \(request.URL) ===")
//        println(request.HTTPBody)
//        
//        var queue: NSOperationQueue = NSOperationQueue()
//        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var dataStr: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)
//            
//            // DEBUG: print out response
//            println("=== Response ===")
//            println(dataStr)
//            
//            // Deserialize response
//            var response: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            
//            lawyers = response.objectForKey("lawyers") as NSArray
//            
//            lawyerHandler(lawyers)
//        })
//    }
//    
//    class func apiRequestForPath(requestPath: NSString, requestMethod: NSString = "GET") -> NSMutableURLRequest {
//        var url = NSURL(string: "http://api.avvo.com/api/3\(requestPath)")
//        var request = NSMutableURLRequest(URL: url)
//        
//        // Set the request method
//        request.HTTPMethod = requestMethod
//        
//        // Set Content-Type
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Set Authorization header
//        request.addValue("Token token=[TOKEN HERE]", forHTTPHeaderField: "Authorization")
//        
//        return request
//    }
}