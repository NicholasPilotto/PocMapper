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
}
