//
//  Toggle.swift
//  SwitchExample
//
//  Created by Sachin Kumar on 24/10/20.
//  Copyright © 2020 Sachin Kumar. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class Toggle: UIControl {
    
    // MARK: - Interface Builder Inspectables
    @IBInspectable public var isOn: Bool = false {
        didSet {
            self.setUpViewsOnAction(isOn: isOn)
        }
    }
    
    @IBInspectable public var onTintColor: UIColor = .green {
        didSet {
            self.refreshBackgroundColor()
        }
    }
    
    @IBInspectable public var offTintColor: UIColor = .lightGray {
        didSet {
            self.refreshBackgroundColor()
        }
    }
    
    @IBInspectable public var toggleViewShadowColor: UIColor = .white {
        didSet {
            toggleView.layer.shadowColor = toggleViewShadowColor.cgColor
        }
    }
    
    @IBInspectable public var toggleViewShadowOffset: CGSize = CGSize(width: -0.75, height: 1) {
        didSet {
            toggleView.layer.shadowOffset = toggleViewShadowOffset
        }
    }
    
    @IBInspectable public var toggleViewShadowRadius: CGFloat = 4 {
        didSet {
            toggleView.layer.shadowRadius = toggleViewShadowRadius
        }
    }
    
    @IBInspectable public var toggleViewShadowOpacity: Float = 0.7 {
        didSet {
            toggleView.layer.shadowOpacity = toggleViewShadowOpacity
        }
    }
    
    @IBInspectable public var thumbTintColor: UIColor = .white {
        didSet {
            thumbView.backgroundColor = thumbTintColor
        }
    }
    
    @IBInspectable public var thumbShadowColor: UIColor = .black {
        didSet {
            thumbView.layer.shadowColor = thumbShadowColor.cgColor
        }
    }
    
    @IBInspectable public var thumbShadowOffset: CGSize = CGSize(width: -0.75, height: 1) {
        didSet {
            thumbView.layer.shadowOffset = thumbShadowOffset
        }
    }
    
    @IBInspectable public var thumbShadowRadius: CGFloat = 4 {
        didSet {
            thumbView.layer.shadowRadius = thumbShadowRadius
        }
    }
    
    @IBInspectable public var thumbShadowOpacity: Float = 0.4 {
        didSet {
            thumbView.layer.shadowOpacity = thumbShadowOpacity
        }
    }
    
    
    // MARK: - Instance Variables
    private let toggleInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    private let toggleHeight: CGFloat = 24
    private let toggleWidth: CGFloat = 48
    private let thumbViewWidthAndHeight: CGFloat = 16
    private let thumbViewLeadingAndTrailingConstant: CGFloat = 5
    
    private var containerWidth: CGFloat {
        toggleInsets.left + toggleWidth + toggleInsets.right
    }
    
    private var containerHeight: CGFloat {
        toggleInsets.top + toggleHeight + toggleInsets.bottom
    }
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toggleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: toggleWidth, height: toggleHeight))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: thumbViewWidthAndHeight, height: thumbViewWidthAndHeight))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbViewHeightConstraint: NSLayoutConstraint = {
        thumbView.heightAnchor.constraint(equalToConstant: thumbViewWidthAndHeight)
    }()
    
    private lazy var thumbViewWidthConstraint: NSLayoutConstraint = {
        thumbView.widthAnchor.constraint(equalToConstant: thumbViewWidthAndHeight)
    }()
    
    private lazy var thumbViewLeadingConstraint: NSLayoutConstraint = {
        thumbView.leadingAnchor.constraint(equalTo: toggleView.leadingAnchor, constant: thumbViewLeadingAndTrailingConstant)
    }()
    
    private lazy var thumbViewTrailingConstraint: NSLayoutConstraint = {
        thumbView.trailingAnchor.constraint(equalTo: toggleView.trailingAnchor, constant: -thumbViewLeadingAndTrailingConstant)
    }()

    
    // MARK: - Initializers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    
    // MARK: - Overrides
    public override var intrinsicContentSize: CGSize {
        CGSize(width: containerWidth, height: containerHeight)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpUI()
    }
    
    
    // MARK: - Helpers
    private func setUpUI() {
        self.clearViews()
        
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: containerWidth),
            containerView.heightAnchor.constraint(equalToConstant: containerHeight)
        ])
        
        containerView.addSubview(toggleView)
        NSLayoutConstraint.activate([
            toggleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: toggleInsets.top),
            toggleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: toggleInsets.left),
            toggleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -toggleInsets.bottom),
            toggleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -toggleInsets.right)
        ])
        
        toggleView.addSubview(thumbView)
        NSLayoutConstraint.activate([
            thumbViewLeadingConstraint,
            thumbView.centerYAnchor.constraint(equalTo: toggleView.centerYAnchor),
            thumbViewHeightConstraint,
            thumbViewWidthConstraint
        ])
        
        self.setUp()
    }
    
    private func clearViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setUp() {
        self.setUpViewsOnAction(isOn: isOn)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.refreshBackgroundColor()
        }
        thumbView.backgroundColor = thumbTintColor
        
        toggleView.layer.cornerRadius = toggleHeight / 2
        toggleView.layer.shadowColor = toggleViewShadowColor.cgColor
        toggleView.layer.shadowRadius = toggleViewShadowRadius
        toggleView.layer.shadowOpacity = toggleViewShadowOpacity
        toggleView.layer.shadowOffset = toggleViewShadowOffset
        
        thumbView.layer.cornerRadius = thumbViewWidthAndHeight / 2
        thumbView.layer.shadowColor = thumbShadowColor.cgColor
        thumbView.layer.shadowRadius = thumbShadowRadius
        thumbView.layer.shadowOpacity = thumbShadowOpacity
        thumbView.layer.shadowOffset = thumbShadowOffset
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction)))
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(gesture:)))
        longPressRecognizer.minimumPressDuration = 0
        containerView.addGestureRecognizer(longPressRecognizer)
    }
    
    private func refreshBackgroundColor() {
        toggleView.backgroundColor = isOn ? onTintColor : offTintColor
    }
    
    @objc private func tapGestureAction() {
        isOn.toggle()
        self.toggleValueChangedWithAnimation(isOn: isOn)
    }
    
    @objc private func longPressed(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.animationOnHold(shouldAnimate: true)
        case .changed:
            let location = gesture.location(in: toggleView)
            self.longPressGestureAction(location: location)
        case .ended:
            self.animationOnHold(shouldAnimate: false)
        default:
            break
        }
    }
    
    private func toggleValueChangedWithAnimation(isOn: Bool = false) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: { [weak self] in
            self?.setUpViewsOnAction(isOn: isOn)
        }, completion: { [weak self] (_) in
            self?.completeAction()
        })
    }
    
    private func setUpViewsOnAction(isOn: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.refreshThumbViewConstraint(isOn: isOn)
            self.refreshBackgroundColor()
            self.layoutIfNeeded()
        }
    }
    
    private func completeAction() {
        self.sendActions(for: .valueChanged)
    }
    
    private func longPressGestureAction(location: CGPoint) {
        let onPoint = toggleHeight + 5
        let offPoint = toggleHeight - 5
        
        if location.x > onPoint {
            self.setUpViewsOnAction(isOn: true)
        }
        else if location.x < offPoint {
            self.setUpViewsOnAction(isOn: false)
        }
    }
    
    private func animationOnHold(shouldAnimate: Bool) {
        let constant = self.thumbViewWidthAndHeight
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if (shouldAnimate == false) {
                self.tapGestureAction()
            }
            
            self.thumbViewHeightConstraint.constant = shouldAnimate ? (constant + 5) : constant
            self.thumbViewWidthConstraint.constant = shouldAnimate ? (constant + 10) : constant
            self.thumbView.layer.cornerRadius = shouldAnimate ? (constant + 5) / 2 : constant / 2
            self.layoutIfNeeded()
        }
    }
    
    private func refreshThumbViewConstraint(isOn: Bool) {
        if isOn {
            NSLayoutConstraint.deactivate([thumbViewLeadingConstraint])
            NSLayoutConstraint.activate([thumbViewTrailingConstraint])
        }
        else {
            NSLayoutConstraint.deactivate([thumbViewTrailingConstraint])
            NSLayoutConstraint.activate([thumbViewLeadingConstraint])
        }
        self.layoutIfNeeded()
    }
    
}

