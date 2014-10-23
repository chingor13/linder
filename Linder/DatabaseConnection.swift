//
//  DatabaseConnection.swift
//  Linder
//
//  Created by Jeffrey Ching on 10/22/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

import Foundation
import CoreData

class DatabaseConnection {
    var databaseDocument: UIManagedDocument
    var documentIsReady = false
    var callback: ((Bool) -> Void)
    
    init(name: String, completionHandler:((Bool) -> Void)) {
        self.callback = completionHandler
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectory = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL
        let databaseURL = documentsDirectory.URLByAppendingPathComponent(name)
        self.databaseDocument = UIManagedDocument(fileURL: databaseURL)
        if(fileManager.fileExistsAtPath(databaseURL.path!)) {
            databaseDocument.openWithCompletionHandler({ (success) -> Void in
                self.completion(success)
            })
        } else {
            databaseDocument.saveToURL(databaseURL, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: { (success) -> Void in
                self.completion(success)
            })
        }
    }
    
    func completion(success: Bool) {
        self.callback(success)
        self.documentIsReady = true
    }
    
    func managedObjectContext() -> NSManagedObjectContext? {
        if(documentIsReady) {
            return databaseDocument.managedObjectContext
        } else {
            return nil
        }
    }
    
}
    
