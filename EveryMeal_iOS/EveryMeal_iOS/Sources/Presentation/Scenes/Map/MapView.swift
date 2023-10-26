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
  // Tabbar corner radius를 위해 지도 하단 내려주는 margin. 추후 문제시 삭제
  private let bottomMargin: CGFloat = -39
  
  var body: some View {
    Map(coordinateRegion: $region)
      .padding(.bottom, Constants.tabBarHeight + bottomMargin)
      .edgesIgnoringSafeArea(.bottom)
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
