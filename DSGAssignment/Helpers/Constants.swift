//
//  Constants.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import Foundation

// MARK: - Base URL
let ApiBaseUrl = "https://api.seatgeek.com/2/"

// MARK: - Client Id
let CLIENTID = "MjI4NzYyNDV8MTYyODc1OTQzNi41NzU2MjU"

// MARK: - TableView Cell Identifier
let CellIdentifier = "cell"

// MARK: - Normal String
let CellCoderFatalError = "init(coder:) has not been implemented"
let AlertTitle = "Alert"
let DismissButtonTitle = "Dismiss"
let NoConnectivityMessage = "No Internet Connection"
let StartNotifierErrorMessage = "Unable to start notifier"
let StopNotifierErrorMessage = "Error stopping notifier"

// MARK: - Date formater
let ServerUTCFormat = "yyyy-MM-dd'T'HH:mm:ss"
let DisplayFormat = "EEE, dd MMM yyyy h:mm a"

enum UserDefaultsKeys:String {
    case favorited = "favorited"
}
