//
//  FilterOptionView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2/9/24.
//

import SwiftUI

enum FilterCategoryOption: String, CaseIterable {
  case all = "전체"
  case restaurant = "밥집"
  case cafe = "카페"
  case bar = "술집"
  case korean = "한식"
  case chinese = "중식"
  case western = "양식"
  case japanese = "일식"
  
  var title: String {
    return self.rawValue
  }
  
  var toCategoryType: CampusStoreGroupType {
    switch self {
    case .all: return .all
    case .restaurant: return .restaurant  // 밥집 > 전체
    case .cafe: return .cafe
    case .bar: return .bar
    case .korean: return .korean
    case .chinese: return .chinese
    case .western: return .western
    case .japanese: return .japanese
    }
  }
  
  var image: String? {
    switch self {
    case .all: return "ic_FilterMenu_all"
    case .restaurant: return "ic_HomeMenu_bap"
    case .cafe: return "ic_HomeMenu_cake"
    case .bar: return "ic_HomeMenu_beer"
    case .korean: return nil
    case .chinese: return nil
    case .western: return nil
    case .japanese: return nil
    }
  }
  
}

enum RestaurantDetailType: String, CaseIterable {
  case restaurant = "전체"
  case korean = "한식"
  case chinese = "중식"
  case western = "양식"
  case japanese = "일식"
  
  var title: String {
    return self.rawValue
  }
  
}

struct FilterCategoryOptionView: View {
  var moreViewType: MoreStoreViewType? = nil
  @Binding var selectedCategory: FilterCategoryOption?
  /// 카테고리 중 '밥집'을 선택한 경우 보여지는 밥집 상세
  @Binding var selectedRestaurantDetail: RestaurantDetailType?
  var action: ((FilterCategoryOption) -> Void)?
  
  var body: some View {
    VStack(spacing: 0) {
      if moreViewType != .cafe && moreViewType != .alcohol {
        HStack {
          Text("음식종류")
            .font(.pretendard(size: 17, weight: .semibold))
            .foregroundStyle(Color.grey9)
          Spacer()
        }
        .padding(.bottom, 20)
        
        FilterCategoryView(
          selectedCategory: $selectedCategory,
          selectedRestaurantDetail: $selectedRestaurantDetail,
          moreViewType: moreViewType,
          action: action
        )
      
      Rectangle()
        .frame(maxWidth: .infinity)
        .frame(height: 1)
        .foregroundStyle(Color.grey2)
        .padding(.bottom, 20)
      }
      
    }
  }
}

struct FilterCategoryView: View {
  @Binding var selectedCategory: FilterCategoryOption?
  @Binding var selectedRestaurantDetail: RestaurantDetailType?
  var moreViewType: MoreStoreViewType? = nil
  let categories = FilterCategoryOption.allCases
  var action: ((FilterCategoryOption) -> Void)?
  
  var body: some View {
    VStack(spacing: 0) {
      if let moreViewType = moreViewType {
        if moreViewType != .meal {
          categoryView
        }
      } else {
        categoryView
      }
      if selectedCategory == .restaurant {
        restaurantDetailView
      }
    }
  }
  
  private var categoryView: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 0) {
      ForEach(categories, id: \.self) { category in
        Button(action: {
          self.selectedCategory = category
          action?(category)
        }) {
          if category.image != nil {
            FilterCategoryButton(
              title: category.title,
              image: category.image,
              isSelected: selectedCategory == category
            )
          }
        }
      }
    }
    .padding(.bottom, 20)
  }
  
  private var restaurantDetailView: some View {
    HStack {
      ForEach(RestaurantDetailType.allCases, id: \.self) { restaurantDetailType in
        Text(restaurantDetailType.title)
          .foregroundStyle(selectedRestaurantDetail == restaurantDetailType ? Color.red : Color.grey6)
          .font(.pretendard(size: 14, weight: .bold))
          .padding(.vertical, 6)
          .padding(.horizontal, 12)
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: 100))
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(selectedRestaurantDetail == restaurantDetailType ? Color.red : Color.grey5, lineWidth: 1)
          )
          .onTapGesture {
            print("\(restaurantDetailType.title) 선택함")
            self.selectedRestaurantDetail = restaurantDetailType
          }
      }
      
      Spacer()
    }
    .padding(.bottom, 20)
  }
  
}

struct FilterCategoryButton: View {
  var title: String
  var image: String?
  var isSelected: Bool
  
  var body: some View {
    VStack(spacing: 1) {
      if let image = image {
        Image(image)
          .frame(width: 40, height: 40)
        
        Text(title)
          .font(.pretendard(size: 14, weight: .regular))
          .foregroundColor(Color.grey9)
      }
    }
    .frame(width: 77)
    .padding(.vertical, 9)
    .background(isSelected ? Color.grey2 : Color.clear)
    .cornerRadius(12)
  }
}

// MARK: - 별점 선택하는 뷰

struct FilterGradeOptionView: View {
  var moreViewType: MoreStoreViewType? = nil
  @Binding var selectedGrade: CampusStoreGradeType?
  var action: ((CampusStoreGradeType?) -> Void)?
  
  var body: some View {
    VStack(spacing: 0) {
      header
      gradeOptions
    }
  }
  
  private var header: some View {
    HStack {
      Text("별점순")
        .font(.pretendard(size: 17, weight: .semibold))
        .foregroundStyle(Color.grey9)
      Spacer()
    }
    .padding(.bottom, 20)
  }
  
  private var gradeOptions: some View {
    HStack(spacing: 8) {
      ForEach(CampusStoreGradeType.allCases, id: \.self) { grade in
        gradeButton(for: grade)
      }
      Spacer()
    }
  }
  
  private func gradeButton(for grade: CampusStoreGradeType) -> some View {
    HStack(spacing: 4) {
      Image("icon-star-mono")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(isGradeSelected(grade) ? Color.red : Color.grey6)
        .frame(width: 14, height: 14)
      Text(grade.rawValue)
        .font(.pretendard(size: 14, weight: .semibold))
        .foregroundStyle(isGradeSelected(grade) ? Color.red : Color.grey6)
    }
    .frame(width: 51, height: 32)
    .background(isGradeSelected(grade) ? Color.redLight : Color.grey2)
    .clipShape(RoundedRectangle(cornerRadius: 100))
    .onTapGesture {     
      if selectedGrade == grade {
        selectedGrade = nil
        action?(nil)
      } else {
        selectedGrade = grade
        action?(grade)
      }
    }
  }
  
  private func isGradeSelected(_ grade: CampusStoreGradeType) -> Bool {
    return selectedGrade == grade
  }
}

#Preview {
  FilterCategoryOptionView(
    moreViewType: .recommend,
    selectedCategory: .constant(FilterCategoryOption.restaurant),
    selectedRestaurantDetail: .constant(RestaurantDetailType.korean)
  )
//  FilterGradeOptionView(
//    moreViewType: MoreStoreViewType.cafe,
//    selectedGrade: .constant(nil)
//  )
}
