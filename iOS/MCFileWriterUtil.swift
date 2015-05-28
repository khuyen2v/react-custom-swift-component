//
//  MCFileWriterUtil.swift
//  CustomSwiftComponent
//
//  Created by Kevin deLeon on 5/28/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

import Foundation

@objc(MCFileWriterUtil)
class MCFileWriterUtil: NSObject {
  
  @objc func writeFile(fileName: String, withContents contents: String, errorCallback failureCallback: RCTResponseSenderBlock, callback successCallback: RCTResponseSenderBlock) -> Void {
    
    if (count(fileName) < 1) {
      // Craft a failure message
      var resultsDict = [
        "success": true,
        "errMsg": "No file name"
      ]
      
      // Execute the JavaScript failure callback handler
      failureCallback([resultsDict])
      
      return; // Halt execution of this function
    }
    
    // Create an array of directory Paths, to allow us to get the documents directory
    var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    // The documents directory is the first item
    var documentsDirectory: AnyObject = paths[0]
    
    // Create a string that prepends the documents directory path to a text file name
    // using NSString's stringWithFormat method.
    var fileName = "\(documentsDirectory)/\(fileName)"
    NSLog("Writing to \(fileName)")
    
    // Initialize an NSError variable
    var writeError: NSError?
    
    // Here we save contents to disk by executing the writeToFile method of
    // the contents String, which is the second argument to this function.
    contents.writeToFile(fileName, atomically: false, encoding: NSUTF8StringEncoding, error: &writeError)
    
    // Error Condition handling
    if ((writeError) != nil) {
      // Craft a failure message
      var resultsDict = [
        "success" : false,
        "errMsg"  : writeError!.localizedDescription
      ];
      
      // Execute the JavaScript failure callback handler
      failureCallback([resultsDict]);
    }
      // Success handling
    else {
      
      // Craft a success return message
      var resultsDict = [
        "success" : true
      ];
      
      // Call the JavaScript sucess handler
      successCallback([resultsDict]);
    }
  }
  
  @objc func readFile(fileName: String, errorCallback failureCallback: RCTResponseSenderBlock, callback successCallback: RCTResponseSenderBlock) -> Void {
    
    if (count(fileName) < 1) {
      // Craft a failure message
      var resultDict = [
        "success": true,
        "errMsg": "No file name"
      ]
      
      // Execute the JavaScript failure callback handler
      failureCallback([resultDict])
      
      return; // Halt execution of this function
    }
    
    // Create an array of directory Paths, to allow us to get the documents directory
    var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    
    // The documents directory is the first item
    var documentsDirectory: AnyObject = paths[0]
    
    // Create a string that prepends the documents directory path to a text file name
    // using NSString's stringWithFormat method.
    var fileName = "\(documentsDirectory)/\(fileName)"
    NSLog("Writing to \(fileName)")
    
    // Initialize an optional NSError variable
    var readError: NSError?
    
    // Allocate a string and initialize it with the contents of the file via
    // the contentsOfFile convenience init.
    var fileContents = NSString(contentsOfFile: fileName, encoding: NSUTF8StringEncoding, error: &readError)
    
    // Error Condition handling
    if ((readError) != nil) {
      // Craft a failure message
      var resultsDict = [
        "success" : false,
        "errMsg"  : readError!.localizedDescription
      ];
      
      // Execute the JavaScript failure callback handler
      failureCallback([resultsDict]);
    }
      // Success handling
    else {
      // Craft a success return message
      var resultsDict = [
        "success"  : true,
        "contents" : fileContents!
      ];
      
      // Call the JavaScript sucess handler
      successCallback([resultsDict]);
    }
  }
}
