//
//  BDUIActionHandler.swift
//  touch
//
//  Created by Oleg Mazur on 23.04.2026.
//

import UIKit

protocol BDUIActionHandlerProtocol {
    func handle(action: BDUIAction)
}

final class BDUIActionHandler: BDUIActionHandlerProtocol {
    weak var viewController: UIViewController?
    
    var onReload: (() -> Void)?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func handle(action: BDUIAction) {
        switch action.type {
        case .print:
            let message = action.context?["message"] ?? "Пустое сообщение"
            print("[BDUI Action]: \(message)")
            
        case .route:
            let screen = action.context?["screen"] ?? "Unknown"
            if screen == "profile" {
                viewController?.tabBarController?.selectedIndex = 1
                viewController?.navigationController?.popToRootViewController(animated: false)
                
            } else if screen == "auth" {
                let authVC = AuthViewController(viewModel: AuthViewModel(service: AuthService(), router: AuthRouter(window: viewController?.view.window)))
                viewController?.view.window?.rootViewController = authVC
                
            } else {
                let alert = UIAlertController(title: "В разработке", message: "Экран \(screen) еще не готов", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .default))
                viewController?.present(alert, animated: true)
            }
            
        case .reload:
            print("[BDUI Action]: Отправлен сигнал на перезагрузку данных экрана")
            onReload?()
        }
    }
}
