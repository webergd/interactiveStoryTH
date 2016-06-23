//
//  PageController.swift
//  InteractiveStory
//
//  Created by Gregory Weber on 6/3/16.
//  Copyright © 2016 Freedom Electric. All rights reserved.
//

import UIKit

class PageController: UIViewController { //we want to make it so PageController is not called without an instance of Page
    
    var page: Page? //we made this a var optional so we won't have to initialize it right away since its default is nil
    
    let artwork = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .System)
    let secondChoiceButton = UIButton(type: .System)
    
    required init?(coder aDecoder: NSCoder) { //this is that standard bullshit we have to add since we added a stored property (in this case: page)
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil) //this must be present because we are using this as the designated initializer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()

        // Do any additional setup after loading the view.
        if let page = page {
            artwork.image = page.story.artwork
            let attributedString = NSMutableAttributedString(string: page.story.text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            //now we need to pass this attribute into the attributes dictionary
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            //when using attributed strings we have to store the words to the "attributedText" property of the label
            storyLabel.attributedText = attributedString
            
            if let firstChoice = page.firstChoice {
                firstChoiceButton.setTitle(firstChoice.title, forState: .Normal)
                //this Selector("loadFirstChoice") notation is used in lieu of #selector(PageController.loadFirstChoice) becuase that shit only works in swift 7.3. Pasan seems to thing the hashtag shit is better though. Same difference from what I can tell.
                firstChoiceButton.addTarget(self, action: Selector("loadFirstChoice"), forControlEvents: .TouchUpInside)
            } else { //because if the firstChoice is nil, we've reached the end of our story
                firstChoiceButton.setTitle("Play Again", forState: .Normal)
                firstChoiceButton.addTarget(self, action: Selector("playAgain"), forControlEvents: .TouchUpInside)
            }
            
            if let secondChoice = page.secondChoice {
                secondChoiceButton.setTitle(secondChoice.title, forState: .Normal)
                secondChoiceButton.addTarget(self, action: Selector("loadSecondChoice"), forControlEvents: .TouchUpInside)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(artwork)
        artwork.translatesAutoresizingMaskIntoConstraints = false //if you don't do this, for every view that you add as a subview, then the parent view adds its own contraints which conflict with ours
        
        //connect the top anchor of the artwork view to the top anchor of the parent view
        NSLayoutConstraint.activateConstraints([ //we have this to just turn all the constraints on at once
            artwork.topAnchor.constraintEqualToAnchor(view.topAnchor), //note the commas because this is an array
            artwork.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            artwork.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
            artwork.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        ])
        
        view.addSubview(storyLabel)
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        storyLabel.numberOfLines = 0 //allows the label to figure out how many lines it needs rather than defaulting to 1
        NSLayoutConstraint.activateConstraints([
            storyLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 16.0), //the constant is an offeset
            storyLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -16.0),// that is from that anchor
            storyLabel.topAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -48.0)
            
            ])
        
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            firstChoiceButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -80.0)
            ])
        
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            secondChoiceButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -32)
            ])
    }
    
    func loadFirstChoice() {
        if let page = page, firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            //now that we have a page, we can create a page controller instance:
            let pageController = PageController(page: nextPage)
            
            //this in optional because we may not be imbedded in a view controller:
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func loadSecondChoice() {
        if let page = page, secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func playAgain() { //the purpose of this method is to unwind the stack to the root view controller
        navigationController?.popToRootViewControllerAnimated(true)
    }
}






























