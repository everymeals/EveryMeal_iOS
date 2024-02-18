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
  
  var title: String {
    return self.rawValue
  }
  
  var toCategoryType: CampusStoreGroupType {
    switch self {
    case .all: return .all
    case .restaurant: return .korean
    case .cafe: return .cafe
    case .bar: return .bar
    }
  }
  
  var image: String {
    switch self {
    case .all: return "ic_FilterMenu_all"
    case .restaurant: return "ic_HomeMenu_bap"
    case .cafe: return "ic_HomeMenu_cake"
    case .bar: return "ic_HomeMenu_beer"
    }
  }
  
}

struct FilterCategoryOptionView: View {
  @Binding var selectedCategory: FilterCategoryOption
  var action: ((FilterCategoryOption) -> Void)?
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("음식종류")
          .font(.pretendard(size: 17, weight: .semibold))
          .foregroundStyle(Color.grey9)
        Spacer()
      }
      .padding(.bottom, 20)
      
      FilterCategoryView(selectedCategory: $selectedCategory, action: action)
        .padding(.bottom, 20)
      
      Rectangle()
        .frame(maxWidth: .infinity)
        .frame(height: 1)
        .foregroundStyle(Color.grey2)
        .padding(.bottom, 20)
      
    }
  }
}

struct FilterCategoryView: View {
  @Binding var selectedCategory: FilterCategoryOption
  let categories = FilterCategoryOption.allCases
  var action: ((FilterCategoryOption) -> Void)?
  
  var body: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
      ForEach(categories, id: \.self) { category in
        Button(action: {
          self.selectedCategory = category
          action?(category)
        }) {
          FilterCategoryButton(title: category.title,
                               image: category.image,
                               isSelected: selectedCategory == category)
        }
      }
    }
  }
}

struct FilterCategoryButton: View {
  var title: String
  var image: String
  var isSelected: Bool
  
  var body: some View {
    VStack(spacing: 1) {
      Image(image)
        .frame(width: 40, height: 40)
      Text(title)
        .font(.pretendard(size: 14, weight: .regular))
        .foregroundColor(Color.grey9)
    }
    .frame(width: 77)
    .padding(.vertical, 9)
    .background(isSelected ? Color.grey2 : Color.clear)
    .cornerRadius(12)
  }
}

struct FilterGradeOptionView: View {
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
  FilterCategoryOptionView(selectedCategory: .constant(.bar))
//  FilterGradeOptionView(selectedGrade: .constant(nil))
}
