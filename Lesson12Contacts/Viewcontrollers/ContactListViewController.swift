//
//  ContactListViewController.swift
//  Lesson12Contacts
//
//  Created by Олег Федоров on 02.10.2021.
//

import UIKit

protocol NewContactViewControllerDelegate {
    func saveContact(_ contact: String)
}

class ContactListViewController: UITableViewController {
    
    private var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // После того, как мы сохранили объект в UserDefaults, к нему нужно получить доступ,
        // чтобы после перезапуска приложения мы видели что внесли
        // для этого создаем константу и у экземпляра класса UserDefaults.standart вызываем метод string(forKey:)
        // для того чтобы получить значение по ключу
        // contactName получается опционального типа, поэтому нужно извлечь опционал
        // если значение будет не опциональным, то добавим его в массив contacts
        if let contactName = UserDefaults.standard.string(forKey: "ContactName") {
            contacts.append(contactName)
        }
    }

    // MARK: - Navigation    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactVC = segue.destination as! NewContactViewController
        newContactVC.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        let contact = contacts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = contact
        cell.contentConfiguration = content

        return cell
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle:
                            UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Для того, чтобы  удалялась не только строка с контактом, но и сам этот объект, который мы сохраняем
            // нужно в данном методе так же обратиться к экземпляру класса UserDefaults и вызвать у него метод removeObject
            // в который мы передаем ключ объекта
            UserDefaults.standard.removeObject(forKey: "ContactName")
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

// MARK: - ContactListViewControllerDelegate
extension ContactListViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: String) {
        contacts.append(contact)
        tableView.reloadData()
    }
}
