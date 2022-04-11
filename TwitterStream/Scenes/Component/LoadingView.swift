//
//  LoadingView.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//


import UIKit

class LoadingView: UIView {
    
    internal var iconImage: UIImage? = #imageLiteral(resourceName: "loading")
    
    fileprivate lazy var indicatore: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = iconImage
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraint()
    }
    
    private func setupConstraint() {
        addSubview(indicatore)
        NSLayoutConstraint.activate([
            indicatore.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatore.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatore.heightAnchor.constraint(equalToConstant: 28),
            indicatore.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    @objc fileprivate func animateImageView() {
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.duration = 0.5
        fullRotation.repeatCount = Float.greatestFiniteMagnitude
        indicatore.layer.add(fullRotation, forKey: "360")
    }
    
    deinit {
        print("-- deinit of LoadingView Instance --")
    }
}

protocol LoadState {
    func startAnimating()
    func stopAnimating()
}

extension LoadState where Self: LoadingView {
    
    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
            self.animateImageView()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(animateImageView), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func stopAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.1) {
                self.alpha = 0
            }
        })
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoadingView: LoadState { }

protocol Loadable {
    func add(loading: UIView)
}

extension Loadable where Self: UIView {
    
    func add(loading: UIView) {
        self.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.leadingAnchor.constraint(equalTo: leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: trailingAnchor),
            loading.topAnchor.constraint(equalTo: topAnchor),
            loading.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension UIView: Loadable { }

