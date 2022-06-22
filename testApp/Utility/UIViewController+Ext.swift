//
//  UIViewController+Ext.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

extension UIViewController {
    func showError(
        title: String?,
        message: String?,
        image: UIImage? = UIImage(systemName: "info"),
        buttonTitle: String?,
        handler: ((UIAlertAction) -> Void)?
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: handler))
    }
}
