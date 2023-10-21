//
//  WidgetAPPApp.swift
//  WidgetAPP
//
//  Created by MRX on 10/20/23.
//

import SwiftUI

@main
struct WidgetAPPApp: App {
    
    var body: some Scene {
        WindowGroup {
            let dateHodel = DateHolder()
            ContentView()
                .environmentObject(dateHodel)
        }
    }
}
