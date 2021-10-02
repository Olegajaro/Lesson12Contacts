//
//  StorageManager.swift
//  Lesson12Contacts
//
//  Created by Олег Федоров on 02.10.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "contacts"
    
    private init() {}

    // метод для добавление объекта в массив сохраняемых контактов
    // для начала восстанавливаем массив
    func save(contact: String) {
        var contacts = fetchContacts()
        contacts.append(contact)
        userDefaults.set(contacts, forKey: key)
    }
    
    // метод для загрузки данных
    func fetchContacts() -> [String] {
        if let contacts = userDefaults.value(forKey: key) as? [String] {
            return contacts
        }
        
        return []
    }
    
    // метод для удаления данных
    // в начале восстанавливаем массив, в котором мы хотим удалить объект
    // далее удаляем объект по нужному индексу в массиве
    // затем снова устанавливаем параметры для массива объектов 
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        userDefaults.set(contacts, forKey: key)
    }
}
