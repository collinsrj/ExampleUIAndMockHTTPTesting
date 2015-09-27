//
//  ViewController.swift
//  ExampleUIAndMockHTTPTesting
//
//  Created by Robert Collins on 27/09/2015.
//  Copyright © 2015 Robert Collins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func makeRequest() {
        let url = NSURL(string: "https://bing.com")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let httpResponse = response as? NSHTTPURLResponse
            let status = httpResponse?.statusCode ?? 0
            dispatch_async(dispatch_get_main_queue()) {
                self.resultLabel.text = "\(status)"
            }
        }
        dataTask.resume()
    }
}

