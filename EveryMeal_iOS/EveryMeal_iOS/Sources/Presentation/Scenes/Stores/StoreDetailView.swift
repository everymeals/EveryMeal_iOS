//
//  StoreDetailView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/25/24.
//

import SwiftUI

import ComposableArchitecture

struct StoreDetailView: View {
  let store: StoreOf<StoreDetailReducer>
  
  @State private var currentSegment: StoreDetailSegmentType = .사진
  @State private var segments = StoreDetailSegmentType.allCases
  @State private var segmentTapped: StoreDetailSegmentType = .사진
  var backButtonTapped: () -> Void
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationView {
        VStack {
          CustomNavigationView(
            title: "",
            leftItem: Image("icon-arrow-left-small-mono"),
            leftItemTapped: backButtonTapped
          )
          
          if let images = viewStore.storeModel.images,
             !images.isEmpty {
            MultipleImagesView(urls: viewStore.storeModel.images ?? [])
              .aspectRatio(contentMode: .fit)
              .frame(width: UIScreen.main.bounds.width)
          }
          
          HStack {
            VStack(alignment: .leading) {
              if let categoryDetail = viewStore.storeModel.categoryDetail {
                Text(categoryDetail)
                  .foregroundColor(Color.grey6)
                  .font(.pretendard(size: 12, weight: .medium))
                  .padding(.horizontal, 6)
                  .padding(.vertical, 3)
                  .background(Color.grey2)
                  .cornerRadius(4)
                  .padding(.bottom, 3)
              }
              
              Text(viewStore.storeModel.name ?? "")
                .foregroundColor(Color.grey9)
                .font(.pretendard(size: 22, weight: .bold))
                .padding(.bottom, 4)
              
              HStack(spacing: 0) {
                Image("icon-star-mono")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 14)
                  .padding(.trailing, 2)
                Text(String(viewStore.storeModel.grade ?? 5.0))
                  .foregroundColor(Color.grey7)
                  .font(.pretendard(size: 12, weight: .medium))
                Text("(5)")
                  .foregroundColor(Color.grey7)
                  .font(.pretendard(size: 12, weight: .medium))
              }
              .padding(.bottom, 24)
              
              HStack(spacing: 8) {
                StoreDetailLikeButton(isPressed: viewStore.storeModel.isLiked, likesCount: viewStore.storeModel.recommendedCount)
                  .onTapGesture {
                    print("didTapped")
                    // TODO: 여기 좋아요 기능 추가
                    
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
//              segmentTapped = tappedSeg
            }
            .padding(.horizontal, 20)
            
            Rectangle()
              .frame(height: 1)
              .foregroundColor(Color.clear)
              .background(Color.grey3)
            
            ScrollViewReader { value in
              ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 0) {
                  ForEach(segments, id: \.self) { segment in
                    switch segment {
                    case .정보:
                      StoreDetailInfoView(location: viewStore.storeModel.address ?? "", number: viewStore.storeModel.phoneNumber ?? "")
                        .id(segment.rawValue)
                        .frame(width: UIScreen.main.bounds.width)
                      
                    case .사진:
                      if let storeReviewData = viewStore.storeReviewData {
                        StoreDetailImageView(storeReviewModel: storeReviewData)
                          .id(segment.rawValue)
                          .frame(width: UIScreen.main.bounds.width)
                      } else {
                        VStack(spacing: 8) {
                          Spacer()
                          Image(.iconPictureMono)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.grey5)
                            .frame(width: 40)
                          Text("사진이 없어요")
                            .font(.pretendard(size: 15, weight: .medium))
                            .foregroundColor(.grey8)
                          Spacer()
                        }
                        .id(segment.rawValue)
                        .frame(width: UIScreen.main.bounds.width)
                      }
                      
                    case .리뷰:
                      if let storeReviewData = viewStore.storeReviewData {
                        VStack {
                          Text(segment.title)
                        }
                        .id(segment.rawValue)
                        .frame(width: UIScreen.main.bounds.width)
                      } else {
                        VStack(spacing: 8) {
                          Spacer()
                          Image(.iconDocumentMono)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.grey5)
                            .frame(width: 40)
                          Text("리뷰가 없어요")
                            .font(.pretendard(size: 15, weight: .medium))
                            .foregroundColor(.grey8)
                          Spacer()
                        }
                        .id(segment.rawValue)
                        .frame(width: UIScreen.main.bounds.width)
                      }
                    }
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
                DispatchQueue.main.async {
                  withAnimation(Animation.easeInOut(duration: 1)) {
//                    proxy.scrollTo(segment.rawValue, anchor: .center)
                    // FIXME: 나중에 수정.. ()
                  }
                }
              }
              
              .coordinateSpace(name: "scroll")
              .frame(width: UIScreen.main.bounds.width,
                     height: UIScreen.main.bounds.width,
                     alignment: .center)
            }
            .onAppear {
              UIScrollView.appearance().isPagingEnabled = true
            }
          }
          
//          Spacer()
        }
      }
      .navigationBarHidden(true)
      .onAppear {
        viewStore.send(.getStoreReviewData(page: 0))
      }
    }
  }
}

struct StoreDetailInfoView: View {
  var location: String
  var number: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 11) {
      HStack(spacing: 6) {
        Image(.iconPinLocationMono)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .foregroundColor(.grey4)
          .frame(width: 20)
        
        Text(location)
          .font(.pretendard(size: 14, weight: .regular))
          .foregroundColor(Color.grey8)
        Spacer()
      }
      HStack(spacing: 6) {
        Image(.iconCallMono)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20)
        Text(number)
          .font(.pretendard(size: 14, weight: .regular))
          .foregroundColor(Color.grey8)
        Spacer()
      }
    }
    .padding(20)
  }
}

struct StoreDetailImageView: View {
  var storeReviewModel: StoreReviewData
  let columns = Array(repeating: GridItem(.fixed(50), spacing: 20), count: 4)
  static let margin: CGFloat = 3
  private var imageSize = UIScreen.main.bounds.width - (margin * 2) / 3
  
  public init(storeReviewModel: StoreReviewData) {
    self.storeReviewModel = storeReviewModel
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 20) {
        if let content = storeReviewModel.content {
          ForEach(content.compactMap { $0.imageURLs }.flatMap { $0 }, id: \.self) { imageURL in
            AsyncImage(url: imageURL) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize)
            } placeholder: {
              Image("dummyImage")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 140, height: 140)
            }
          }
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
    let dummy = CampusStoreContent(idx: 0, name: "수아당", address: "서울 관악구 남부순환로 1817 (우)08758", phoneNumber: "1522-3232", categoryDetail: "분식", distance: nil, grade: 3.0, reviewCount: 5, recommendedCount: 24, images: [], isLiked: true)
    StoreDetailView(store: .init(
      initialState: StoreDetailReducer.State(storeModel: dummy),
      reducer: {
        StoreDetailReducer()
      }), backButtonTapped: { })
  }
}
