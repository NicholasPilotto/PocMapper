//
//  Location.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 18/08/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
  let name: String
  let cityName: String
  let coordinates: CLLocationCoordinate2D
  let description: String
  let imageNames: [String]
  let link: String
  
  var id: String {
    name + cityName
  }
  
  static func == (lhs: Location, rhs: Location) -> Bool {
    return lhs.id == rhs.id
  }
}
