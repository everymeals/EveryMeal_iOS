//
//  StoreDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/25/24.
//

import SwiftUI

struct StoreDetailView: View {
  var storeModel: CampusStoreContent
  @State private var currentSegment: StoreDetailSegmentType = .정보
  @State private var segments = StoreDetailSegmentType.allCases
  @State private var segmentTapped: StoreDetailSegmentType = .정보
  
  var body: some View {
    VStack {
      MultipleImagesView(urls: storeModel.images ?? [])
        .aspectRatio(contentMode: .fit)
        .frame(width: UIScreen.main.bounds.width)
      
      HStack {
        VStack(alignment: .leading) {
          if let categoryDetail = storeModel.categoryDetail {
            Text(categoryDetail)
              .foregroundColor(Color.grey6)
              .font(.pretendard(size: 12, weight: .medium))
              .padding(.horizontal, 6)
              .padding(.vertical, 3)
              .background(Color.grey2)
              .cornerRadius(4)
              .padding(.bottom, 3)
          }
          
          Text(storeModel.name ?? "")
            .foregroundColor(Color.grey9)
            .font(.pretendard(size: 22, weight: .bold))
            .padding(.bottom, 4)
          
          HStack(spacing: 0) {
            Image("icon-star-mono")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 14)
              .padding(.trailing, 2)
            Text(String(storeModel.grade ?? 5.0))
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
            Text("(5)")
              .foregroundColor(Color.grey7)
              .font(.pretendard(size: 12, weight: .medium))
          }
          .padding(.bottom, 24)
          
          HStack(spacing: 8) {
            StoreDetailLikeButton(likesCount: 3)
              .onTapGesture {
                print("didTapped")
              }
            StoreDetailShareButton()
          }
        }
        .padding(.horizontal, 20)
        
        Spacer()
      }
      .padding(.bottom, 20)
      
      VStack(spacing: 0) {
        SegmentedView(selected: $currentSegment) { tappedSeg in
          segmentTapped = tappedSeg
        }
        .padding(.horizontal, 20)
        
        Rectangle()
          .frame(height: 1)
          .foregroundColor(Color.clear)
          .background(Color.grey3)
        
        ScrollViewReader { value in
          ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 0) {
              ForEach(segments, id: \.self) { segment in
                VStack {
                  Text(segment.title)
                }
                .id(segment.rawValue)
                .background(.red)
                .frame(width: UIScreen.main.bounds.width)
                /*
                switch segment {
                case .정보:
                  VStack {
                    Text(segment.title)
                  }
                  .background(.red)
                  .frame(width: UIScreen.main.bounds.width,
                         height: UIScreen.main.bounds.width,
                         alignment: .center)
                case .사진:
                  VStack {
                    Text(segment.title)
                  }
                  .frame(width: UIScreen.main.bounds.width,
                         height: UIScreen.main.bounds.width,
                         alignment: .center)
                case .리뷰:
                  VStack {
                    Text(segment.title)
                  }
                  .frame(width: UIScreen.main.bounds.width,
                         height: UIScreen.main.bounds.width,
                         alignment: .center)
                }
                 */
              }
            }
            .background(GeometryReader { geometry in
              Color.clear
                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
              let offset = value.x == 0 ? 0 : -value.x
              let screenWidth = UIScreen.main.bounds.width
              let centerX = offset + (screenWidth / 2)
              currentSegment = segments[Int(floor(centerX/screenWidth))]
            }
          }
          .onChange(of: segmentTapped) { segment in
            DispatchQueue.main.async {   // <--- workaround
              withAnimation(Animation.easeInOut(duration: 1)) {
                value.scrollTo(segment.rawValue, anchor: .center)
              }
            }
          }
          .coordinateSpace(name: "scroll")
          .frame(width: UIScreen.main.bounds.width,
                 height: UIScreen.main.bounds.width,
                 alignment: .center)
        }
      }
    }
  }
}

enum StoreDetailSegmentType: Int, CaseIterable {
  case 정보, 사진, 리뷰
  
  var title: String {
    switch self {
    case .정보: return "정보"
    case .사진: return "사진"
    case .리뷰: return "리뷰"
    }
  }
}

struct StoreDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = CampusStoreContent(idx: 0, name: "수아당", address: nil, phoneNumber: nil, categoryDetail: "분식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 24, images: ["https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80", "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80"], isLiked: true)
    StoreDetailView(storeModel: dummy)
  }
}
