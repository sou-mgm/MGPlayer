//
//  Shared.swift
//  MGPlayer
//
//  Created by Matheus Matias on 27/01/23.
//

import UIKit

extension UIViewController {
    // faz uma instancia compartilhada entre as ViewsControllers.
    var MPShared: MPViewModel {
        return MPViewModel.shared
    }
}
