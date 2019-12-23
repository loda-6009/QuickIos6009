//
//  CreateViaStoryboard.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 2017. 11. 7..
//  Copyright © 2018년 Hansoolabs. All rights reserved.
//

import UIKit

/// create ViewController via storyboard.
public protocol CreateViaStoryboard {
    static var storyboardName: String { get }
    static var storyboardIdentity: String { get }
    static func newInstance() -> UIViewController
}

public extension CreateViaStoryboard {
    
    static func newInstance() -> UIViewController {
        let story = UIStoryboard(name: storyboardName, bundle: nil)
        return story.instantiateViewController(withIdentifier: storyboardIdentity)
    }
}
