//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Gregory Weber on 6/3/16.
//  Copyright © 2016 Freedom Electric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
            if let PageController = segue.destinationViewController as? PageController {
                PageController.page = Adventure.story
            }
        }
    }


}

