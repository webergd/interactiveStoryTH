//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Gregory Weber on 6/3/16.
//  Copyright © 2016 Freedom Electric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Error: ErrorType {
        case NoName
    }
    
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" { //that way this shit only happens when a specific seque is activated
            
            
            
            do {
                if let name = nameTextField.text {
                    //this returns an optional but actually always has a value of an empty string or text. So we need an additional check:
                    if name == "" {
                        throw Error.NoName //this must be handled within the method because prepareForSegue is a non-throwing method and we can't change that.
                    }
                    
                    if let PageController = segue.destinationViewController as? PageController {
                        PageController.page = Adventure.story(name)
                    }
                }
            } catch {
                //this will be tackled in next video
            }
            
        }
    }


}

