//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Gordon Seto on 2016-10-20.
//  Copyright © 2016 gordonseto. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedMessage = activeConversation?.selectedMessage {
            print("hi")
        } else {
            print("yo")
        }
    }
    
    @IBAction func onRequestButtonPressed(_ sender: AnyObject) {
        if let image = createImageForMessage(), let conversation = activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = image
            layout.caption = "Pic Requested!"
            
            let message = MSMessage()
            message.layout = layout
            message.url = URL(string: "emptyURL")
            
            conversation.insert(message, completionHandler: { error in
                if error != nil {
                    print(error)
                }
            })
        }
    }
    
    func createImageForMessage() -> UIImage? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        background.backgroundColor = UIColor.black
        
        let picPleaseLogo = UIImage(named: "picpleaselogo")
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        imageView.image = picPleaseLogo
        
        background.addSubview(imageView)
        background.frame.origin = CGPoint(x: view.frame.size.width, y: view.frame.size.height)
        view.addSubview(background)
        
        UIGraphicsBeginImageContextWithOptions(background.frame.size, false, UIScreen.main.scale)
        background.drawHierarchy(in: background.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        background.removeFromSuperview()
        
        return image
    }

}
