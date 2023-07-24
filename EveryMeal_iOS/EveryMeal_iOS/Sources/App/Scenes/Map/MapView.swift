//
//  MapView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI
import MapKit

struct MapView: View {
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.493932, longitude: 127.030902),
    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
  )
  
  var body: some View {
    Map(coordinateRegion: $region)
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
