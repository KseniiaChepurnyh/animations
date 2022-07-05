//
//  UIVIewAnimateViewController.swift
//  UIKitAnimations
//
//  Created by Ксения Чепурных on 06.04.2022.
//

import UIKit

class UIVIewAnimateViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelTopInset: NSLayoutConstraint!
    @IBOutlet weak var labelRightInset: NSLayoutConstraint!
    @IBOutlet weak var labelLeftInset: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func animateView(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut]) {
            self.titleLabel.alpha = 0
        } completion: { _ in
            self.titleLabel.alpha = 1
        }

    }
    
    @IBAction func animateWithSprings(_ sender: UIButton) {
        labelTopInset.constant = labelTopInset.constant - 95
        view.layoutIfNeeded()

        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []) {
            self.labelTopInset.constant = self.labelTopInset.constant + 95
            self.view.layoutIfNeeded()
        }

    }

    @IBAction func animateWithTransition(_ sender: UIButton) {
        UIView.transition(with: titleLabel, duration: 2, options: [.curveEaseOut, .transitionFlipFromBottom]) {
            self.titleLabel.alpha = 0
        } completion: { _ in
            self.titleLabel.alpha = 1
        }

    }

    @IBAction func animateWithKeyframes(_ sender: UIButton) {
        let startTop = labelTopInset.constant
        let startLeft = labelLeftInset.constant
        let startRifht = labelRightInset.constant

        UIView.animateKeyframes(withDuration: 3, delay: 0, options: [.autoreverse, .calculationModeCubic]) { [weak self] in

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self?.labelLeftInset.constant += 100
                self?.labelRightInset.constant -= 100
                self?.labelTopInset.constant += 70
                self?.titleLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi) / 2)
                self?.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 1) {
                self?.labelRightInset.constant += 200
                self?.labelLeftInset.constant -= 200
                self?.titleLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
                self?.view.layoutIfNeeded()
            }

            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 1) {
                self?.labelLeftInset.constant = startLeft
                self?.labelRightInset.constant = startRifht
                self?.labelTopInset.constant = startTop
                self?.titleLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi) * 2)
                self?.view.layoutIfNeeded()
            }
        }

    }
    
}
