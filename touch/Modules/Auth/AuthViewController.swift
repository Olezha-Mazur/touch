//
//  AuthViewController.swift
//  touch
//
//  Created by Oleg Mazur on 12.03.2026.
//

import UIKit

final class AuthViewController: UIViewController {
    private lazy var customView = AuthView()
    private var viewModel: AuthViewModelProtocol
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.emailField.delegate = self
        customView.passwordField.delegate = self
        setupActions()
        setupBindings()
        setupKeyboardObservers()
        setupHideKeyboardOnTap()
    }
    
    private func setupActions() {
        customView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc private func didTapLogin() {
        let email = customView.emailField.text
        let pass = customView.passwordField.text
        customView.errorLabel.isHidden = true
        view.endEditing(true)
        viewModel.login(emailO: email, passO: pass)
    }

    private func setupBindings() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: AuthViewState) {
            switch state {
            case .initial:
                customView.loginButton.setIsLoading(false)
                customView.errorLabel.isHiddenWhenEmpty = true
                
            case .loading:
                customView.loginButton.setIsLoading(true)
                customView.errorLabel.isHiddenWhenEmpty = true
                
            case .error(let message):
                customView.loginButton.setIsLoading(false)
                customView.errorLabel.text = message
                customView.errorLabel.isHiddenWhenEmpty = false
            }
        }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillHide(_ note: Notification) {
        customView.scrollView.contentInset = .zero
        customView.scrollView.scrollIndicatorInsets = .zero
    }
    
    private func setupHideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ note: Notification) {
        guard let userInfo = note.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 20, right: 0)
        customView.scrollView.contentInset = insets
        customView.scrollView.scrollIndicatorInsets = insets
        let buttonRect = customView.loginButton.convert(customView.loginButton.bounds, to: customView.scrollView)
        customView.scrollView.scrollRectToVisible(buttonRect, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == customView.emailField {
            customView.passwordField.becomeFirstResponder()
        } else if textField == customView.passwordField {
            view.endEditing(true)
            didTapLogin()
        }
        
        return true
    }
}

