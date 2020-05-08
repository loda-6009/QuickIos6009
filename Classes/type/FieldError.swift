//
//  FieldError.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 26/11/2018.
//

public enum FieldError: String {
    case passed
    case empty
    case tooShort
    case tooLong
    case alphabetNumberNotMixed
    case specialCharNotContained
    case wrongFormat
    case notEqual
}

public enum FieldTag: Int {
    case linePhone
    case cellularPhone
    case email
    case emailNew
    case password
    case passwordNew
    case passwordNewConfirm
    case name
}

public typealias FieldTagAndString = (FieldTag, String?)
