//
//  FilterBarView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/10/30.
//

import SwiftUI

struct FilterBarView: View {
  // FIXME: 나중에 확인 후 타입 분기가 필요 없을 시 제거할 것
  enum ViewType {
    case reviews
    case stores
  }
  
  var moreViewType: MoreStoreViewType? = nil
  @State var viewType: ViewType = .reviews
  @Binding var selectedSortOption: SortOption?
  @Binding var selectedFilterCategoryOption: FilterCategoryOption?
  @Binding var selectedFilterGradeOption: CampusStoreGradeType?
  var sortCompletionHandler: (() -> Void)?
  var filterCompletionHandler: (() -> Void)?
  
  /// 카테고리 필터를 골라서 생성된 뷰 영역에 대한 클릭 이벤트 처리
  var categoryCompletionHandler: (() -> Void)?
  /// 별점 필터를 골라서 생성된 뷰 영역에 대한 클릭 이벤트 처리
  var gradeCompletionHandler: (() -> Void)?
  /// 카테고리 필터를 골라서 생성된 뷰 영역 안에 X 버튼에 대한 클릭 이벤트 처리
  var categoryCloaseButtonCompletionHandler: (() -> Void)?
  /// 별점 필터를 골라서 생성된 뷰 영역 안에 X 버튼에 대한 클릭 이벤트 처리
  var gradeCloaseButtonCompletionHandler: (() -> Void)?
  
  var body: some View {
    HStack {
      orderView
      filterView
      if moreViewType != .meal && moreViewType != .cafe && moreViewType != .alcohol {
        if selectedFilterCategoryOption != nil && selectedFilterCategoryOption != .all {
          selectedCategoryView
        }
        if selectedFilterGradeOption != nil {
          selectedGradeView
        }
      }
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
    
  }
  
  private var orderView: some View {
    HStack(alignment: .center, spacing: 4) {
      Text(selectedSortOption?.title ?? SortOption.registDate.title)
        .font(.pretendard(size: 14, weight: .semibold))
        .multilineTextAlignment(.center)
        .foregroundColor(Color.grey7)
      
      Image("icon-arrow-right-small-mono")
        .resizable()
        .renderingMode(.template)
        .frame(width: 12, height: 12)
        .rotationEffect(Angle(degrees: 90))
        .foregroundStyle(Color.grey7)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(Color.grey2)
    .cornerRadius(100)
    .onTapGesture {
      sortCompletionHandler?()
    }
  }
  
  private var filterView: some View {
    HStack(alignment: .center, spacing: 4) {
      Text("필터")
        .font(.pretendard(size: 14, weight: .semibold))
        .multilineTextAlignment(.center)
        .foregroundColor(isSelectedCategoryOrGrade() ? Color.everyMealRed : Color.grey7)
      
      Image("icon-arrow-right-small-mono")
        .renderingMode(.template)
        .resizable()
        .frame(width: 12, height: 12)
        .rotationEffect(Angle(degrees: 90))
        .foregroundColor(isSelectedCategoryOrGrade() ? Color.everyMealRed : Color.grey7)
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(isSelectedCategoryOrGrade() ? Color.redLight : Color.grey2)
    .cornerRadius(100)
    .onTapGesture {
      filterCompletionHandler?()
    }
  }
  
  /// 카테고리 또는 별점 필터가 선택된 경우 true를 반환
  private func isSelectedCategoryOrGrade() -> Bool {
    if moreViewType == .meal || moreViewType == .cafe || moreViewType == .alcohol {
      return false
    } else {
      return (selectedFilterCategoryOption != nil && selectedFilterCategoryOption != .all) || selectedFilterGradeOption != nil
    }
  }
  
  /// 필터에서 카테고리가 선택된 경우 나타나는 뷰
  private var selectedCategoryView: some View {
    HStack(alignment: .center, spacing: 4) {
      Text(selectedFilterCategoryOption?.title ?? "")
        .font(.pretendard(size: 14, weight: .semibold))
        .multilineTextAlignment(.center)
        .foregroundColor(Color.everyMealRed)
      
      Image("icon-x-mono")
        .renderingMode(.template)
        .resizable()
        .foregroundStyle(Color.everyMealRed)
        .frame(width: 12, height: 12)
        .onTapGesture {
          print("별점 영역 안에 X버튼 선택함")
          categoryCloaseButtonCompletionHandler?()
        }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(Color.redLight)
    .cornerRadius(100)
    .onTapGesture {
      print("카테고리 영역 선택함")
      categoryCompletionHandler?()
    }

  }
  
  /// 필터에서 별점이 선택된 경우 나타나는 뷰
  private var selectedGradeView: some View {
    HStack(alignment: .center, spacing: 0) {
      Image("icon-star-mono")
        .renderingMode(.template)
        .resizable()
        .foregroundStyle(Color.everyMealRed)
        .frame(width: 16, height: 16)
        .padding(.trailing, 2)
      
      Text(selectedFilterGradeOption?.rawValue ?? "")
        .font(.pretendard(size: 14, weight: .semibold))
        .multilineTextAlignment(.center)
        .foregroundColor(Color.everyMealRed)
        .padding(.trailing, 4)
      
      Image("icon-x-mono")
        .renderingMode(.template)
        .resizable()
        .foregroundStyle(Color.everyMealRed)
        .frame(width: 12, height: 12)
        .onTapGesture {
          print("별점 영역 안에 X버튼 선택함")
          gradeCloaseButtonCompletionHandler?()
        }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(Color.redLight)
    .cornerRadius(100)
    .onTapGesture {
      print("별점 영역 선택함")
      gradeCompletionHandler?()
    }

  }
  
  
}

struct FilterBarView_Previews: PreviewProvider {
  static var previews: some View {
    FilterBarView(
      moreViewType: MoreStoreViewType.recommend,
      selectedSortOption: .constant(.popularity),
      selectedFilterCategoryOption: .constant(FilterCategoryOption.korean),
      selectedFilterGradeOption: .constant(CampusStoreGradeType.four)
    )
  }
}
