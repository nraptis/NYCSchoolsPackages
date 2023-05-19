//
//  NYCSchoolsApp.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import SwiftUI

@main
struct NYCSchoolsApp: App {
    let application = Application()
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(schoolViewModel: application.schoolViewModel)
        }
    }
}
