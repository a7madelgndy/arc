//
//  UIViewController+EXT.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//

import UIKit

extension UIViewController {

    func presentAler(title: AllertTitles , message: String , buttonTitle : String = "ok") {
        let alertVC = AlertVC(title: title.rawValue, message: message , okButtonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC , animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = AlertVC(title: "Something Went Wrong" ,
                                message: "we were Unable to Complete your task at this time , please try again" ,
                              okButtonTitle: "okay")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC , animated: true)
    }
    
    func presentAlertWithCancelButton(completion :(@escaping (Bool)->())) {
        let alertVC = AlertVC(title: "Delete The Movie Action" ,
                                message: "Do you want to Delete the Movie For your Favorite  List ? " ,
                              okButtonTitle: "ok" ,addCancelButton: true)

        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        print("here in the ")
        present(alertVC , animated: true)
        print(alertVC.didTappedCancelButton)
        completion(alertVC.didTappedCancelButton)
        
    }
    
}
