//
//  ModalProtocol.swift
//  TwitterStream
//
//  Created by javad Arji on 4/11/22.
//


import PanModal

public protocol ModalProtocol: PanModalPresentable {
}

extension ModalProtocol where Self: UIViewController {
    
    public var panScrollable: UIScrollView? {
        return nil
    }
    
    public var showDragIndicator: Bool { false }
    
    public var transitionDuration: Double { 0.6 }
    
    public var springDamping: CGFloat { 1 }
    
    public var cornerRadius: CGFloat { 16 }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(50)
    }
    
    public var panModalBackgroundColor: UIColor {
        UIColor.black.withAlphaComponent(0.5)
    }
    
}
