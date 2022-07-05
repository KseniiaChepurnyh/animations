//
//  CALayerSubclassesViewController.swift
//  UIKitAnimations
//
//  Created by Ксения Чепурных on 10.05.2022.
//

import UIKit

final class CALayerSubclassesViewController: UIViewController {

    let gradientLayer: CAGradientLayer = {
      let gradientLayer = CAGradientLayer()
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
      let colors = [
        UIColor.systemPink.cgColor,
        UIColor.purple.cgColor,
        UIColor.blue.cgColor
      ]
      gradientLayer.colors = colors

      let locations: [NSNumber] = [
        0.1, 0.3, 0.9
      ]
      gradientLayer.locations = locations

      return gradientLayer
    }()
    
    @IBAction func drowShape(_ sender: UIButton) {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: view.center.x, y: 50))
        path.addLine(to: CGPoint(x: view.center.x + 100, y: 250))
        path.addLine(to: CGPoint(x: view.center.x - 100, y: 250))
        path.addLine(to: CGPoint(x: view.center.x, y: 50))

        layer.path = path.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = nil
        view.layer.addSublayer(layer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        layer.add(animation, forKey: "line")

        layer.addSublayer(gradientLayer)
    }

    @IBAction func addGradient(_ sender: Any) {
        let view = UIView()
        view.frame = CGRect(origin: CGPoint(x: self.view.center.x - 50, y: 200), size: CGSize(width: 100, height: 100))
        self.view.addSubview(view)

        gradientLayer.frame = CGRect(
            x: view.bounds.origin.x,
            y: view.bounds.origin.y,
            width: view.bounds.size.width,
            height: view.bounds.size.height)
        view.layer.addSublayer(gradientLayer)
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.1, 0.3, 0.8]
        gradientAnimation.toValue = [0.3, 0.6, 1]
        gradientAnimation.duration = 2
        gradientAnimation.autoreverses = true
        gradientAnimation.repeatCount = Float.infinity

        gradientLayer.add(gradientAnimation, forKey: nil)
    }
}
