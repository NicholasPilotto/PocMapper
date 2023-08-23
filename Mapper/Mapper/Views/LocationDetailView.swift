//
//  LocationDetailView.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 23/08/23.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
  @EnvironmentObject private var viewModel: LocationViewModel
  private let location: Location
  
  init(location: Location) {
    self.location = location
  }
  
  var body: some View {
    ScrollView {
      VStack {
        imagesSection
          .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        
        VStack(alignment: .leading, spacing: 16) {
          titleSection
          Divider()
          descriptionSection
          Divider()
          mapLayer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
      }
    }
    .ignoresSafeArea()
    .background(.thinMaterial)
    .overlay(alignment: .topLeading) {
      backButton
    }
  }
}

extension LocationDetailView {
  private var imagesSection: some View {
    TabView {
      ForEach(location.imageNames, id: \.self) {
        Image($0)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width)
          .clipped()
      }
    }
    .frame(height: 500)
    .tabViewStyle(.page)
  }
  
  private var titleSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(location.name)
        .font(.largeTitle)
        .fontWeight(.semibold)
      
      Text(location.cityName)
        .font(.title3)
        .foregroundColor(.secondary)
    }
  }
  
  private var descriptionSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(location.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
      
      if let url = URL(string: location.link) {
        Link("Read more on Wikipedia", destination: url)
          .font(.headline)
          .tint(.blue)
      }
    }
  }
  
  private var mapLayer: some View {
    Map(
      coordinateRegion: .constant(
        MKCoordinateRegion(
          center: location.coordinates,
          span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
      annotationItems: [location]) {
      MapAnnotation(coordinate: $0.coordinates) {
        LocationMapAnnotationView()
          .shadow(radius: 10)
      }
    }
      .allowsHitTesting(false)
      .aspectRatio(1, contentMode: .fit)
      .cornerRadius(30)
  }
  
  private var backButton: some View {
    Button {
      viewModel.sheetLocation = nil
    } label: {
      Image(systemName: "xmark")
        .font(.headline)
        .padding(16)
        .foregroundColor(.primary)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding()
    }
  }
}

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    // swiftlint:disable force_unwrapping
    LocationDetailView(location: LocationsDataService.locations.first!)
      .environmentObject(LocationViewModel())
    // swiftlint:enable force_unwrapping
  }
}
