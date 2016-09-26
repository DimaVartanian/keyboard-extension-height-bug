//
//  KeyboardViewController.swift
//  keyboard-test
//
//  Created by Dima Vartanian on 9/25/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(advanceToNextInputMode), for: .touchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        
        let anotherView = UIView()
        anotherView.backgroundColor = UIColor.red
        anotherView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anotherView)
        anotherView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        anotherView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        anotherView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        // Looks fine on iOS 9 and iOS 10
        // red view stretches to fit whatever the default automatic size of the keyboard is, and resizes its height to fit with rotations
       // anotherView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Looks fine on iOS 9 (as above) red view fits the default keyboard height and anchors to the top of the next keyboard button
        // on iOS 10, the red view sizes down to a height of 0 and brings the entire container down with it, the entire view is only the size of the next keyboard button
        anotherView.bottomAnchor.constraint(equalTo: self.nextKeyboardButton.topAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
