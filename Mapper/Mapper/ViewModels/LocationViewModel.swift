//
//  LocationViewModel.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 18/08/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
  // All loaded locations
  @Published var locations: [Location]
  // Current location on map
  @Published var mapLocation: Location {
    didSet {
      updateMapRegion(location: mapLocation)
    }
  }
  // current region on map
  @Published var mapRegion = MKCoordinateRegion()
  let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  
  // show list of locations
  @Published var showLocationsList = false
  
  // show location detail sheet
  @Published var sheetLocation: Location?
  
  init() {
    let locations = LocationsDataService.locations
    self.locations = locations
    // swiftlint:disable force_unwrapping
    self.mapLocation = locations.first!
    self.updateMapRegion(location: locations.first!)
    // swiftlint:enable force_unwrapping
  }
  
  private func updateMapRegion(location: Location) {
    withAnimation(.easeOut) {
      mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
  }
  
  public func locationsListToggle() {
    withAnimation(.easeInOut) {
      showLocationsList.toggle()
    }
  }
  
  public func showNextLocation(location: Location) {
    withAnimation(.easeInOut) {
      self.mapLocation = location
      showLocationsList = false
    }
  }
  
  public func nextButtonPressed() {
    // get current index
    guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
      return
    }
    
    // check if next nextIndex is valid
    let nextIndex = currentIndex + 1
    guard locations.indices.contains(nextIndex) else {
      guard let firstLocation = locations.first else { return }
      showNextLocation(location: firstLocation)
      return
    }
    
    let nextLocation = locations[nextIndex]
    showNextLocation(location: nextLocation)
  }
}
