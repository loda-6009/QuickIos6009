//
//  Validation.swift
//  StudioBase
//
//  Created by brownsoo han on 2017. 12. 22..
//  Copyright © 2017년 StudioMate. All rights reserved.
//

import Foundation

public class Validation {

    public static var minPasswordCount = 8
    public static var maxPasswordCount = 32
    
    public static func checkField(tag: FieldTag, text: String?) -> (FieldTag, FieldError) {
        guard let text = text else {
            return (tag, .empty)
        }
        if text.isEmpty {
            return (tag, .empty)
        }
        switch tag {
        case .cellularPhone:
            if text.count < 11 {
                return (tag, .tooShort)
            }
            if !text.isCellularPhoneFormat {
                return (tag, .wrongFormat)
            }
        case .email, .emailNew:
            if !text.isEmailFormat {
                return (tag, .wrongFormat)
            }
        case .name:
            if text.hasSpecialChar {
                return (tag, .wrongFormat)
            }
        case .password: // 현재 비번에 대해서는 길이만 체크
            if text.count < Validation.minPasswordCount {
                return (tag, .tooShort)
            }
            if text.count > Validation.maxPasswordCount {
                return (tag, .tooLong)
            }
        case .passwordNew, .passwordNewConfirm:
            if text.count < Validation.minPasswordCount {
                return (tag, .tooShort)
            }
            if text.count > Validation.maxPasswordCount {
                return (tag, .tooLong)
            }
            if text.hasOnlyNumber || !text.hasNumber {
                return (tag, .wrongFormat)
            }
        default:
            break
        }
        return (tag, .passed)
    }
    
}
