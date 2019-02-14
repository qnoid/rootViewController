//
//  ViewController.swift
//  StateRestoration
//
//  Created by Markos Charatzas on 12/02/2019.
//  Copyright © 2019 qnoid. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    static let NotificationDone = NSNotification.Name(rawValue: "Done")
    
    @IBAction func didTouchUpInsideDone(_ sender: Any) {
        NotificationCenter.default.post(name: DoneViewController.NotificationDone, object: nil)
    }
}
