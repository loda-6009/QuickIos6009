//
//  DeviceUtil.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 4. 10..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import Foundation

public class DeviceUtil {
    
    public enum DeviceType {
        case small
        case normal
        case plus
        case x
        case xr
        case max
        case unknown
    }
    
    // https://stackoverflow.com/questions/11197509/how-to-get-device-make-and-model-on-ios/11197770#11197770
    public static func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    /// 작은 화면이니?
    public static func isSmall() -> Bool {
        return getDeviceType() == .small
    }
    /// 작은 화면에서 포인트 간격을 조정하기 위해 사용
    public static func dividerRatio() -> CGFloat {
        return isSmall() ? 1.6 : 1
    }

    public static func screenRadius() -> CGFloat {
        return isRoundedScreen() ? 44 : 0
    }

    public static func isRoundedScreen() -> Bool {
        let type = getDeviceType()
        switch type {
        case .x, .xr, .max:
            return true
        default:
            return false
        }
    }

    // https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/
    public static func getDeviceType() -> DeviceType {
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            //print("iPhone 5 or 5S or 5C")
            return .small
        case 1334:
            //print("iPhone 6/6S/7/8")
            return .normal
        case 1792:
            return .xr
        case 2208:
            //print("iPhone 6+/6S+/7+/8+")
            return .plus
        case 2436:
            //print("iPhone X, XS")
            return .x
        case 2688: // iPhone XS Max
            return .max
        default:
            print("unknown")
            return .unknown
        }
    }
}
