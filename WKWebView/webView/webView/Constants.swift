//
//  Constants.swift
//  webView
//
//  Created by Kautilya Save on 10/27/22.
//

import Foundation


// MARK: Constants
enum AppConstants: String {
    // App Links strings
    case mainURL = "https://costco.com"
    case baseURL = "http://wsdot.wa.gov/Traffic/api/"
    case pathName = "/MountainPassConditions/MountainPassConditionsREST.svc/"
    case methodName = "GetMountainPassConditionAsJon"
    case accessCodeString = "AccessCode="
    case accessCode = "d6701759-bf55-49e3-a2a7-dac879575026"
    case passConditionString = "PassConditionID"
}

enum MountainPassName: Int {
    case stevensPass = 10
    case snoqualmie = 11
}
