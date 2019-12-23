//
// Created by brownsoo han on 2019-02-21.
//

import Foundation

public protocol IntentContainer {
    var intent: NSMutableDictionary { get }
    @discardableResult
    func setIntent(_ key: String, value: Any?) -> Self
    func getIntent(_ key: String) -> Any?
}

public extension IntentContainer {

    @discardableResult
    func setIntent(_ key: String, value: Any?) -> Self {
        if value == nil {
            intent.removeObject(forKey: key)
            return self
        }
        intent[key] = value
        return self
    }

    func getIntent(_ key: String) -> Any? {
        return intent.object(forKey: key)
    }
}