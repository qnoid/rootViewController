//
//  RootViewController.swift
//  StateRestoration
//
//  Created by Markos Charatzas on 15/02/2019.
//  Copyright © 2019 qnoid. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

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
