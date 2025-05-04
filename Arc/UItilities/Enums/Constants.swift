//
//  Constants.swift
//  Arc
//
//  Created by Ahmed El Gndy on 26/04/2025.
//


import UIKit

enum Colors{
    static let main:UIColor = .systemPurple
}
enum SFSymbols {
    static let star =  UIImage(systemName: "star.fill")!
    static let clock = UIImage(systemName: "clock")!
    static let movieclapper  = UIImage(systemName: "movieclapper" )!
    static let arrowRight = UIImage(systemName: "arrow.right" )!
    static let heart  = UIImage(systemName: "heart" )!
    static let heartFill =  UIImage(systemName: "heart.fill" )!
    static let presonWithExclamationmark =  UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill" )!
    static let home =  UIImage(systemName: "house" )!
    static let homeFill =  UIImage(systemName: "house.fill")!
    static let squareAndArrowUp =  UIImage(systemName: "square.and.arrow.up")!   
    static let checkmarkCircle =  UIImage(systemName: "checkmark.circle")!
    static let xmarkCircle =  UIImage(systemName: "xmark.circle")!    
    static let playCircleFill =  UIImage(systemName: "play.circle.fill")!
}

enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE2ndAnd3rdGen   = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
