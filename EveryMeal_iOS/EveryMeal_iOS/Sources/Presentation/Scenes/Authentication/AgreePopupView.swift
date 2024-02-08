//
//  AgreePopupView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2/6/24.
//

import SwiftUI

struct AgreePopupView: View {
//  @Environment(\.dismiss) private var dismiss
  @State var types: [AgreeOptionType] = AgreeOptionType.allCases
  @State private var goToNotionWebViewWithType: AgreeOptionType? = nil
  @State private var agreedTerms: Set<AgreeOptionType> = []
  @State private var goToNotionWebView: Bool = false
  @Binding var nextButtonEnabled: Bool
  
  private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 1)
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: 14) {
      ForEach(types, id: \.title) { type in
        AgreeOptionCellView(type: type, goToNotionWebViewWithType: $goToNotionWebViewWithType, cellDidTapped: { cellType, didAgree in
          if didAgree {
            agreedTerms.insert(cellType)
          } else {
            agreedTerms.remove(cellType)
          }
        })
      }
    }
    .onChange(of: goToNotionWebViewWithType) { value in
      if value != nil {
        goToNotionWebView = true
      }
    }
    .fullScreenCover(isPresented: $goToNotionWebView, content: {
      VStack {
        CustomNavigationView(
          title: "이용 약관 동의",
          rightItem: Image(systemName: "xmark"),
          rightItemTapped: {
            goToNotionWebView = false
          })
        BaseWebView(url: goToNotionWebViewWithType?.url ?? "")
      }
    })
    .onChange(of: agreedTerms) { terms in
      nextButtonEnabled = Set(AgreeOptionType.allCases.filter { $0.isRequired }).isSubset(of: terms)
    }
  }
}

struct AgreeOptionCellView: View {
  var type: AgreeOptionType
  @State var didAgree: Bool = false
  @Binding var goToNotionWebViewWithType: AgreeOptionType?
  @State var cellDidTapped: (AgreeOptionType, Bool) -> Void
  
  var body: some View {
    HStack {
      HStack {
        Image(.iconCheckMono)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .foregroundColor(didAgree ? .everyMealRed : .grey4)
          .frame(width: 24)
        Text(type.title)
          .font(.pretendard(size: 15, weight: .medium))
          .foregroundColor(.grey7)
        Spacer()
      }
      .onTapGesture {
        didAgree.toggle()
        cellDidTapped(type, didAgree)
      }
      
      
      Image(.iconArrowRightSmallMono)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.grey5)
        .frame(width: 18)
        .onTapGesture {
          goToNotionWebViewWithType = self.type
        }
    }
  }
}

enum AgreeOptionType: CaseIterable {
  case termsAndConditions
  case PersonalInfo
  case marketing
  
  private var description: String {
    switch self {
    case .termsAndConditions:
      return "이용 약관 동의"
    case .PersonalInfo:
      return "개인정보 수집 및 이용 동의"
    case .marketing:
      return "마케팅 정보 수집 동의"
    }
  }
  
  var url: String { // FIXME: 노션 URL 나오면 수정
    switch self {
    case .termsAndConditions:
      return "https://www.naver.com/"
    case .PersonalInfo:
      return "https://www.naver.com/"
    case .marketing:
      return "https://www.naver.com/"
    }
  }
  
  var isRequired: Bool {
    switch self {
    case .termsAndConditions, .PersonalInfo:
      return true
    case .marketing:
      return false
    }
  }
  
  var title: String {
    let required = self.isRequired ? "[필수]" : "[선택]"
    return "\(required) \(self.description)"
  }
}

struct AgreePopupView_Previews: PreviewProvider {
  static var previews: some View {
    @State var nextButtonEnabled: Bool = false
    AgreePopupView(nextButtonEnabled: $nextButtonEnabled)
  }
}
