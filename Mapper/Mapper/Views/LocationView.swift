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
  private let maxWidthForIpad: CGFloat = 700
  
  var body: some View {
    ZStack {
      mapLayer
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        header
          .padding()
          .frame(maxWidth: maxWidthForIpad)
        Spacer()
        locationPreviewStack
      }
    }
    .sheet(item: $viewModel.sheetLocation) {
      LocationDetailView(location: $0)
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
  
  private var mapLayer: some View {
    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
      MapAnnotation(coordinate: location.coordinates) {
        LocationMapAnnotationView()
          .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
          .shadow(radius: 10)
          .onTapGesture {
            viewModel.showNextLocation(location: location)
          }
      }
    }
  }
  
  private var locationPreviewStack: some View {
    ZStack {
      ForEach(viewModel.locations) { location in
        if viewModel.mapLocation == location {
          LocationPreviewView(location: location)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
            .padding()
            .frame(maxWidth: maxWidthForIpad)
            .frame(maxWidth: .infinity)
            .transition(
              .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
              )
            )
        }
      }
    }
  }
}

struct LocationView_Previews: PreviewProvider {
  static var previews: some View {
    LocationView()
      .environmentObject(LocationViewModel())
  }
}
