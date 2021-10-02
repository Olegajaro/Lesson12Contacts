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
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveURL: URL
    
    private init() {
        archiveURL = documentDirectory.appendingPathComponent("Contacts").appendingPathExtension("plist")
    }

    // метод для добавление объекта в массив сохраняемых контактов
    // для начала восстанавливаем массив
    func save(contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
//        userDefaults.set(data, forKey: key)
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    // метод для загрузки данных
    func fetchContacts() -> [Contact] {
//        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([Contact].self, from: data) else { return [] }
        
        return contacts
    }
    
    // метод для удаления данных
    // в начале восстанавливаем массив, в котором мы хотим удалить объект
    // далее удаляем объект по нужному индексу в массиве
    // затем снова устанавливаем параметры для массива объектов 
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
//        guard let data = try? JSONEncoder().encode(contacts) else { return }
//        userDefaults.set(data, forKey: key)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
}
