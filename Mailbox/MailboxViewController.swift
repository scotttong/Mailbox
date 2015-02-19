//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Scott Tong on 2/17/15.
//  Copyright (c) 2015 Scott Tong. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var laterIcon: UIImageView!
	
	// messageContainerView changes the background color
	@IBOutlet weak var messageContainerView: UIView!
	
	// messageView is the actual message
	@IBOutlet weak var messageView: UIImageView!
	
	var originalMessageCenter: CGPoint!
	var originalLaterIconCenter: CGPoint!

	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		//Scroll View
		scrollView.frame.size = view.bounds.size
		scrollView.contentSize = CGSize(width: 320, height: 1432)
		messageContainerView.backgroundColor = UIColor.grayColor()
		originalMessageCenter = messageView.center

		//initial properties of later icon
		laterIcon.alpha = 0
		originalLaterIconCenter = laterIcon.center

		// println("\(messageView.center.x)")
		// println("\(laterIcon.center.x)")
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	// PAN GESTURE RECOGNIZER
	@IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
		
		var location = sender.locationInView(view)
		var translation = sender.translationInView(view)
		var velocity = sender.velocityInView(view)
		
		if (sender.state == UIGestureRecognizerState.Began){
			//set the starting point of the message to its current position
			originalMessageCenter = messageView.center
			originalLaterIconCenter = laterIcon.center
			
		} else if (sender.state == UIGestureRecognizerState.Changed) {
			// as the message is dragged, make the center it's most recent position plus the horizontal difference you drag
			messageView.center = CGPointMake(originalMessageCenter.x + translation.x, originalMessageCenter.y)
			
			// println("\(messageView.center.x)")
			
			//short swipe left for later
			if (messageView.center.x < 100 && messageView.center.x > -40) {
				messageContainerView.backgroundColor = UIColor.yellowColor()
				laterIcon.alpha = 1
//				println("\(messageView.center.x)")
				
				laterIcon.center = CGPointMake(originalLaterIconCenter.x + translation.x, originalLaterIconCenter.y)
				println("\(laterIcon.center.x)")
			
			// long swipe left for list
			}
			else if (messageView.center.x <= -40) {
				messageContainerView.backgroundColor = UIColor.brownColor()

			// short swipe right to archive
			}
			else if (messageView.center.x > 220 && messageView.center.x < 360) {
				messageContainerView.backgroundColor = UIColor.greenColor()
			
			// long swipe right to delete
			}
			else if (messageView.center.x >= 360) {
				messageContainerView.backgroundColor = UIColor.redColor()
			}
			
			// otherwise keep the background gray
			else {
				messageContainerView.backgroundColor = UIColor.grayColor()
			}
			
			
		} else if (sender.state == UIGestureRecognizerState.Ended) {
			//
		}

		
	}

}
