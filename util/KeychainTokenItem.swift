//
//  KeychainTokenItem.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 10. 31..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import Foundation

public struct KeychainTokenItem {
    enum KeychainTokenError: Error {
        case noToken
        case unexpectedTokenData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    //MARK: Properties
    public let service: String
    public let accessGroup: String?
    public var account: String
    
    public init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    public func readToken() throws -> String {
        // Build a query to find the item that matches the service, account
        // and access group
        var query = KeychainTokenItem.keychainQuery(with: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        //check return status
        guard status != errSecItemNotFound else { throw KeychainTokenError.noToken }
        guard status == noErr else { throw KeychainTokenError.unhandledError(status: status) }
        // parse the string
        guard let item = result as? [String : AnyObject],
            let data = item[kSecValueData as String] as? Data,
            let token = String(data: data, encoding: String.Encoding.utf8) else {
                throw KeychainTokenError.unexpectedTokenData
        }
        return token
    }
    
    public func saveToken(_ token: String) throws {
        // Encode string into data object
        let encodedToken = token.data(using: String.Encoding.utf8)
        do {
            // Check for an existing item
            try _ = readToken()
            // Update the existing item with new token
            var attributes = [String : AnyObject]()
            attributes[kSecValueData as String] = encodedToken as AnyObject?
            let query = KeychainTokenItem.keychainQuery(with: service, account: account, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            
            guard status == noErr else {
                throw KeychainTokenError.unhandledError(status: status)
            }
            
        } catch KeychainTokenError.noToken {
            // no token was found
            var item = KeychainTokenItem.keychainQuery(with: service, account: account, accessGroup: accessGroup)
            item[kSecValueData as String] = encodedToken as AnyObject?
            // add new item
            let status = SecItemAdd(item as CFDictionary, nil)
            guard status == noErr else {
                throw KeychainTokenError.unhandledError(status: status)
            }
        }
    }

    public mutating func renameAccount(_ newAccount: String) throws {
        // Try to update an existing item 
        var attributes = [String : AnyObject]()
        attributes[kSecAttrAccount as String] = newAccount as AnyObject?
        let query = KeychainTokenItem.keychainQuery(with: service, account: self.account, accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        // check Error
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainTokenError.unhandledError(status: status)
        }
        self.account = newAccount
    }

    public func deleteItem() throws {
        print("delete the existing item")
        let query = KeychainTokenItem.keychainQuery(with: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        // check Error
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainTokenError.unhandledError(status: status)
        }
    }

    public static func tokenItems(with service: String, accessGroup: String? = nil) throws -> [KeychainTokenItem] {
        // Build a query for all tokenItems
        var query = KeychainTokenItem.keychainQuery(with: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse

        // Fetch
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        // if empty array
        guard status != errSecItemNotFound else {
            return []
        }
        // unexpected error
        guard status == noErr else {
            throw KeychainTokenError.unhandledError(status: status)
        }
        // cast result to an array of dictionaries
        guard let resultData = result as? [[String : AnyObject]] else {
            throw KeychainTokenError.unexpectedItemData
        }
        // Create KeychainTokenItem array
        var items = [KeychainTokenItem]()
        for dic in resultData {
            guard let account = dic[kSecAttrAccount as String] as? String else {
                throw KeychainTokenError.unexpectedItemData
            }
            let item = KeychainTokenItem(service: service, account: account, accessGroup: accessGroup)
            items.append(item)
        }
        return items
    }
    
    //MARK: Convenience
    
    private static func keychainQuery(with service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject
        }
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject
        }
        return query
    }
}
