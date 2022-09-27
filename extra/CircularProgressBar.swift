//
//  CircularProgressBar.swift
//  ShurjopaySdk
//
//  Created by Rz Rasel on 2022-05-12
//

import Foundation
import UIKit

public class CircleProgress: UIView {
    /*private func on() {
        let circleProgress = CircleProgress(
            frame: CGRect(x: viewController.view.center.x - 50, y: viewController.view.center.x - 50, width: 100, height: 100)
        )
        viewController.view.addSubview(circleProgress)
    }*/
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var progressLyr = CAShapeLayer()
    var trackLyr    = CAShapeLayer()
    var progressClr = UIColor.red {
        didSet {
            progressLyr.strokeColor = progressClr.cgColor
        }
    }

    var trackClr = UIColor.black {
        didSet {
            trackLyr.strokeColor = trackClr.cgColor
        }
    }

    private func setupView() {
        self.backgroundColor    = UIColor.red
        let centre = CGPoint(x: frame.size.width/2, y: frame.size.height/2)

        let circlePath = UIBezierPath (
            arcCenter:  centre,
            radius:     50,
            startAngle: 0,
            endAngle:   2 * CGFloat.pi,
            clockwise:  true
        )

        trackLyr.path           = circlePath.cgPath
        trackLyr.fillColor      = UIColor.clear.cgColor
        trackLyr.strokeColor    = trackClr.cgColor
        trackLyr.lineWidth      = 5.0
        trackLyr.strokeEnd      = 1.0
        layer.addSublayer(trackLyr)
    }
}
