//
//  Navigation.swift
//  TwitterStream
//
//  Created by javad Arji on 4/11/22.
//

import UIKit
import PanModal

protocol NavigationProtocol: AnyObject {
    func push(_ vc: UIViewController)
    func presentModal(_ vc: UIViewController & ModalProtocol)

}

extension NavigationProtocol where Self: UIViewController {
    func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentModal(_ vc: UIViewController & ModalProtocol) {
        self.presentPanModal(vc)
    }
}
