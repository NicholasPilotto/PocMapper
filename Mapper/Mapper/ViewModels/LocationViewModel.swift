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
  
  @Published var mapRegion = MKCoordinateRegion()
  let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  
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
}
