//
//  LocationView.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 18/08/23.
//

import MapKit
import SwiftUI

struct LocationView: View {
  @EnvironmentObject private var viewModel: LocationViewModel
  
  var body: some View {
    ZStack {
      Map(coordinateRegion: $viewModel.mapRegion)
        .ignoresSafeArea()
    }
  }
}

struct LocationView_Previews: PreviewProvider {
  static var previews: some View {
    LocationView()
      .environmentObject(LocationViewModel())
  }
}
