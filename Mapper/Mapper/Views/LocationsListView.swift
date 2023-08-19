//
//  LocationsList.swift
//  Mapper
//
//  Created by Nicholas Pilotto on 19/08/23.
//

import SwiftUI

struct LocationsListView
: View {
  @EnvironmentObject private var viewModel: LocationViewModel
  
  var body: some View {
    List {
      ForEach(viewModel.locations) { location in
        Button {
          viewModel.showNextLocation(location: location)
        } label: {
          listRowView(location: location)
        }
          .padding(.vertical, 4)
          .listRowBackground(Color.clear)
      }
    }
    .listStyle(.plain)
  }
}

extension LocationsListView {
  private func listRowView(location: Location) -> some View {
    return HStack {
      if let imageName = location.imageNames.first {
        Image(imageName)
          .resizable()
          .scaledToFill()
          .frame(width: 45, height: 45)
          .cornerRadius(10)
      }
      
      VStack(alignment: .leading) {
        Text(location.name)
          .font(.headline)
        Text(location.cityName)
          .font(.subheadline)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}


struct LocationsListView_Previews: PreviewProvider {
  static var previews: some View {
    LocationsListView()
      .environmentObject(LocationViewModel())
  }
}
