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
        SegmentedView(selected: $currentSegment)
//          .frame(height: 48)
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
          .coordinateSpace(name: "scroll")
          .frame(width: UIScreen.main.bounds.width,
                 height: UIScreen.main.bounds.width,
                 alignment: .center)
        }
      }

//      Spacer()
    }
  }
}

struct StoreDetailLikeButton: View {
  @State var isPressed: Bool = false
  
  var likesCount: Int
  var selectedColor: Color = .everyMealRed
  
  var body: some View {
    HStack(spacing: 4) {
      Spacer()
      Image("icon-heart-mono")
        .renderingMode(.template)
        .foregroundColor(isPressed ? selectedColor : .grey4)
        .frame(width: 24)
      
      Text(String(likesCount))
        .font(.pretendard(size: 15, weight: .semibold))
        .foregroundColor(isPressed ? selectedColor : .grey5)
      Spacer()
    }
    .padding(.vertical, 12)
    .background(.white)
    .frame(height: 48)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .inset(by: 0.5)
        .stroke(isPressed ? selectedColor : .grey3, lineWidth: 1)
    )
    .contentShape(Rectangle())
  }
}

struct StoreDetailShareButton: View {
  var body: some View {
    HStack(spacing: 4) {
      Spacer()
      Image(.iconShareMono)
        .renderingMode(.template)
        .foregroundColor(.grey6)
        .frame(width: 24)
      
      Text("공유하기")
        .font(.pretendard(size: 15, weight: .semibold))
        .foregroundColor(.grey6)
      Spacer()
    }
    .padding(.vertical, 12)
    .background(Color.grey1)
    .frame(width: 111, height: 48)
    .cornerRadius(12)
    .contentShape(Rectangle())
  }
}

enum StoreDetailSegmentType: CaseIterable {
  case 정보, 사진, 리뷰
  
  var title: String {
    switch self {
    case .정보: return "정보"
    case .사진: return "사진"
    case .리뷰: return "리뷰"
    }
  }
}
struct SegmentedView: View {
  let segments: [StoreDetailSegmentType] = StoreDetailSegmentType.allCases
  @Binding var selected: StoreDetailSegmentType
  @Namespace var name
  
  var body: some View {
    VStack {
      HStack(spacing: 0) {
        ForEach(segments, id: \.self) { segment in
          VStack(spacing: 11) {
            Text(segment.title)
              .font(.pretendard(size: 16, weight: .medium))
              .foregroundColor(selected == segment ? .grey9 : .grey5)
              .padding(.top, 14)
            ZStack {
              Capsule()
                .fill(Color.clear)
                .frame(height: 2)
              if selected == segment {
                Capsule()
                  .fill(Color.grey9)
                  .frame(height: 2)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            print("seg1 \(segment) \(selected)")
            selected = segment
            print("seg2 \(segment) \(selected)")
          }
        }
      }
      
      /*
      LazyHStack(spacing: 0) {
        ForEach(segments, id: \.self) { segment in
          switch segment {
          case .정보:
            VStack {
              Text(segment.rawValue)
            }
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width,
                   alignment: .center)
          case .사진:
            VStack {
              Text(segment.rawValue)
            }
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width,
                   alignment: .center)
          case .리뷰:
            VStack {
              Text(segment.rawValue)
            }
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.width,
                   alignment: .center)
          }
        }
      }
       */
    }
  }
}


struct StoreDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = CampusStoreContent(idx: nil, name: "수아당", address: nil, phoneNumber: nil, categoryDetail: "분식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 24, images: ["https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80", "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1752&q=80"], isLiked: true)
    StoreDetailView(storeModel: dummy)
  }
}
