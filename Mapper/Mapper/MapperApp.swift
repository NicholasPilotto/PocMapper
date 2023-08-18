//
//  MapperApp.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 18/08/23.
//

import SwiftUI

@main
struct MapperApp: App {
  @StateObject private var locationViewModel = LocationViewModel()
  
  var body: some Scene {
    WindowGroup {
      LocationView()
        .environmentObject(locationViewModel)
    }
  }
}
