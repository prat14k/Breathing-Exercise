//
//  XIBView.swift
//  BreatheExerciseDemo
//
//  Created by Prateek Sharma on 4/4/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

class XIBView: UIView {

    weak var contentView: UIView?
    @IBInspectable private var nibName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}


