//
//  RootViewController.swift
//  StateRestoration
//
//  Created by Markos Charatzas on 15/02/2019.
//  Copyright © 2019 qnoid. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        self.children.forEach { child in
            if let restorationIdentifier = child.restorationIdentifier {
                coder.encode(child, forKey: restorationIdentifier)
            }
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        if let mainViewController = coder.decodeObject(of: [MainViewController.self], forKey: "MainViewController") as? MainViewController {
            self.addChild(mainViewController)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let registerViewController = self.children.first(where: { $0 is RegisterViewController })
        let mainViewController = self.children.first(where: { $0 is MainViewController })
        
        switch (registerViewController, mainViewController) {
        case (let registerViewController?, let mainViewController?):
            self.transition(from: registerViewController, to: mainViewController)
        default:
            return
        }
        
        super.viewDidLayoutSubviews()    
    }

    private func transition(from: UIViewController, to: UIViewController) {
        from.willMove(toParent: nil)
        self.addChild(to)
        
        self.transition(from: from, to: to, duration: self.transitionCoordinator?.transitionDuration ?? 0.4, options: [], animations: {
            
        }) { (finished) in
            from.removeFromParent()
            to.didMove(toParent: self)
        }
    }

    @IBAction func unwindToRootViewController(_ segue: UIStoryboardSegue) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        
        if let registerViewController = self.children.first(where: { $0 is RegisterViewController }), let mainViewController = storyboard.instantiateInitialViewController() {
            self.transition(from: registerViewController, to: mainViewController)
        }
    }
}
