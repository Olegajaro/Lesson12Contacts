//
//  NewContactViewController.swift
//  Lesson12Contacts
//
//  Created by Олег Федоров on 02.10.2021.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty
    }
    
    private func saveAndExit() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        
        // в приложении необходимо сохранять контакты
        // для этого используем специальный класс UserDefaults, который является синглтоном
        // и у класса вызываем свойство standard, у которого вызываем свойство set для того, чтобы указать там сохраняемый объект и его ключ
        let fullName = "\(firstName) \(lastName)"
        UserDefaults.standard.set(fullName, forKey: "ContactName")
        
        delegate.saveContact(fullName)
        dismiss(animated: true)
    }
}
