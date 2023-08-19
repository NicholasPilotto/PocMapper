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
      
      VStack(spacing: 0) {
        header
          .padding()
        
        Spacer()
      }
    }
  }
}

extension LocationView {
  private var header: some View {
    VStack {
      Button {
        viewModel.locationsListToggle()
      } label: {
        Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
          .font(.title2)
          .fontWeight(.black)
          .foregroundColor(.primary)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .animation(.none, value: viewModel.mapLocation)
          .overlay(alignment: .leading) {
            Image(systemName: "arrow.down")
              .font(.headline)
              .foregroundColor(.primary)
              .padding()
              .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
          }
      }

      if viewModel.showLocationsList {
        LocationsListView()
      }
    }
    .background(.thickMaterial)
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
  }
}

struct LocationView_Previews: PreviewProvider {
  static var previews: some View {
    LocationView()
      .environmentObject(LocationViewModel())
  }
}
