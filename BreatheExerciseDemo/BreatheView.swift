//
//  BreatheView.swift
//  BreatheExerciseDemo
//
//  Created by Prateek Sharma on 4/5/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

class BreatheView: UIView {
    
    private enum State: String {
        case expanded, collapsed
        
        static prefix func !(state: State) -> State {
            return state == .expanded ? .collapsed : .expanded
        }
    }
    
    private var currentState: State = .collapsed
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var rotatingImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var minShrinkScale: CGFloat = 0.5
    var breatheDuration = (inhale: 6.0, exhale: 5.0)
    var isBreathing = false {
        didSet {
            guard isBreathing != oldValue  else { return }
            isBreathing ? startAnimation() : stopAnimation()
        }
    }
    
    private var transformForScaling: CGAffineTransform {
        return currentState == .collapsed ? CGAffineTransform(scaleX: minShrinkScale, y: minShrinkScale) : .identity
    }
    
    private var transformForRotation: CGAffineTransform {
        return currentState == .expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.transform = transformForScaling
    }
    
}

extension BreatheView {
    
    private func startAnimation() {
        currentState = !currentState
        animateBreathing()
    }
    
    private func stopAnimation() {
        self.layer.removeAllAnimations()
        self.transform = transformForScaling
        rotatingImageView.transform = transformForRotation
    }
    
    private func animateBreathing() {
        let duration = currentState == .collapsed ? breatheDuration.exhale : breatheDuration.inhale
        titleLabel.text = currentState == .collapsed ? "breathe out" : "breathe in"
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let weakSelf = self  else { return }
            weakSelf.transform = weakSelf.transformForScaling
            weakSelf.rotatingImageView.transform = weakSelf.transformForRotation
        }) { [weak self] (_) in
            guard let weakSelf = self, weakSelf.isBreathing  else  { return }
            weakSelf.currentState = !weakSelf.currentState
            weakSelf.animateBreathing()
        }
    }
    
}
