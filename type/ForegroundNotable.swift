//
//  ForegroundNotable.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 26/11/2018.
//

protocol ForegroundNotable {
    
    /// notify that app is foreground
    func didForeground()
    
    /// notify that app go to background
    func didBackground()
}

