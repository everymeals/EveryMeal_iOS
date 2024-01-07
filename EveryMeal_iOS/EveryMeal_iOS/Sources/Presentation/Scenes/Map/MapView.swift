//
//  MapView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/24.
//

import SwiftUI
import ComposableArchitecture
import Combine

import MapKit

struct MapView: View {
  
  let store: StoreOf<MapViewReducer>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Text(viewStore.data?.data.map { $0.reviewPagingList?.first?.content ?? "" } ?? (viewStore.isLoading ? "로딩중" : "로딩 전"))
          .font(.pretendard(size: 16, weight: .bold))
          .foregroundColor(.black)
        
        if let profileImage = viewStore.data?.data.map({ $0.reviewPagingList?.first?.profileImageURL }) {
          AsyncImage(url: profileImage) { image in
            image.image?
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 140, height: 140)
          }
        }
        
        Button(action: {
          if viewStore.data == nil {
            viewStore.send(.fetchData)
          } else {
            viewStore.send(.removeAllData)
          }
        }, label: {
          Text(viewStore.data == nil ? "Send API" : "remove All")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.everyMealRed)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, 23)
        })
      }
      
    }
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    
    MapView(store: Store(initialState: MapViewReducer.State()) {
    })
  }
}
