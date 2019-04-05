//
//  ViewController.swift
//  BreatheExerciseDemo
//
//  Created by Prateek Sharma on 4/4/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var breatheViewContainer: XIBView?
    weak private var breatheView: BreatheView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        breatheView = breatheViewContainer?.contentView as? BreatheView
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.breatheView?.isBreathing = true
        }
    }

}

