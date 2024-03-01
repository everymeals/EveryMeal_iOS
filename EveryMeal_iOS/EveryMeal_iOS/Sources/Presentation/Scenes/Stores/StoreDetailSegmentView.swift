//
//  StoreDetailSegmentView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 3/1/24.
//

import SwiftUI

struct SegmentedView: View {
  let segments: [StoreDetailSegmentType] = StoreDetailSegmentType.allCases
  @Binding var selected: StoreDetailSegmentType
  var buttomTapped: (StoreDetailSegmentType) -> Void
  
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
              }
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            print("seg1 \(segment) \(selected)")
            selected = segment
            buttomTapped(segment)
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
