//
//  CALayerAnimationsViewController.swift
//  UIKitAnimations
//
//  Created by Ксения Чепурных on 18.04.2022.
//

import UIKit

class CALayerAnimationsViewController: UIViewController {

    @IBOutlet weak var viewToAnimate: ProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func basicAnimation(_ sender: Any) {
        CATransaction.begin()
        viewToAnimate.layer.add(createPositionAnimation(), forKey: nil)
        viewToAnimate.layer.add(createBackgroundAnimation(), forKey: nil)
        CATransaction.commit()
    }

    @IBAction func animationDelegate(_ sender: Any) {
        let animation = createBackgroundAnimation()
        animation.autoreverses = false
        animation.repeatCount = 0
        animation.delegate = self
        animation.setValue(viewToAnimate.layer, forKey: "layer")
        viewToAnimate.layer.add(animation, forKey: nil)
    }

    @IBAction func animationGroup(_ sender: Any) {
        let group = createGroupAnimation()
        viewToAnimate.layer.add(group, forKey: nil)
    }

    @IBAction func nsmanaged(_ sender: Any) {
        let progressAnimation = CABasicAnimation(keyPath: "progress")
        progressAnimation.fromValue = 0
        progressAnimation.toValue = 0.8
        progressAnimation.duration = 2

        let colorAnimation = CABasicAnimation(keyPath: "color")
        colorAnimation.fromValue = UIColor.systemYellow.cgColor
        colorAnimation.toValue = UIColor.red.cgColor
        colorAnimation.duration = 2

        CATransaction.begin()
        viewToAnimate.layer.add(progressAnimation, forKey: "progress")
        viewToAnimate.layer.add(colorAnimation, forKey: "color")
        CATransaction.commit()
    }

}

extension CALayerAnimationsViewController: CAAnimationDelegate {

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let layer = anim.value(forKey: "layer") as? CALayer else {
            return
        }

        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1.5
        pulse.toValue = 1.0
        pulse.duration = 0.25
        layer.add(pulse, forKey: nil)
    }

}

private extension CALayerAnimationsViewController {

    func createPositionAnimation() -> CABasicAnimation {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = CGPoint(x: viewToAnimate.layer.position.x, y: viewToAnimate.layer.position.y)
        positionAnimation.toValue = CGPoint(x: viewToAnimate.layer.position.x, y: viewToAnimate.layer.position.y + 200)
        positionAnimation.duration = 1
        positionAnimation.beginTime = CACurrentMediaTime()
        positionAnimation.repeatCount = 1
        positionAnimation.autoreverses = true

        return positionAnimation
    }

    func createBackgroundAnimation() -> CABasicAnimation {
        let backgroundAnimation = CABasicAnimation(keyPath: "backgroundColor")
        backgroundAnimation.fromValue = UIColor.systemYellow.cgColor
        backgroundAnimation.toValue = UIColor.green.cgColor
        backgroundAnimation.duration = 1
        backgroundAnimation.beginTime = CACurrentMediaTime()
        backgroundAnimation.repeatCount = 1
        backgroundAnimation.autoreverses = true

        return backgroundAnimation
    }

    func createGroupAnimation() -> CAAnimationGroup {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.timingFunction = CAMediaTimingFunction(
        name: .easeInEaseOut)
        groupAnimation.duration = 1
        groupAnimation.fillMode = .backwards
        groupAnimation.autoreverses = true

        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 1.0
        scaleDown.toValue = 2.5

        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = .pi / 4.0

        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0

        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0

        groupAnimation.animations = [scaleDown, rotate, fadeIn, fadeOut]
        return groupAnimation
    }

}
