//
//  Errors.swift
//  Arc
//
//  Created by Ahmed El Gndy on 21/04/2025.
//


import Foundation

enum ErrorMassages: String, Error {
    
    case invalidUsername     = "This username created an invalid resquest. Please try again."
    case unableToComplete    = "Unable to complete your request. Please Check your internet"
    case invalidResponse     = "Invalid response from the server. Please try again."
    case invalidDate         = "The data received from the server was invalid. Please try again."
    case unabelToFavorie     = "There was an error favoriting this user. Please try again"
    case alreadyInFavorite   = "this user is already in Favorites "
    case defulatErrorMassage  = "SomeThing Went Wrong" //used
}
