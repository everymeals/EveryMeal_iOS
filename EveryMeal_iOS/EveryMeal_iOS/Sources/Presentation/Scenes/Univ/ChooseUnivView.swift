//
//  ChooseUnivView.swift
//  EveryMeal_iOS
//
//  Created by 김광록 on 2023/07/31.
//

import SwiftUI

struct ChooseUnivView: View {
  @State var isSelected: Bool = false
  @Binding var isFirstLaunching: Bool
  @State private var universities: [UnivsEntity] = []

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        VStack(alignment: .leading, spacing: 12) {
          Image("school")
            .resizable()
            .frame(width: 64, height: 64)
          
          Text("반가워요!\n대학을 선택해주세요")
            .font(.pretendard(size: 24, weight: .bold))
            .foregroundColor(.grey9)
        }
        .padding(.top, 32)
        .padding(.leading, 24)
        
        Spacer()
      }
      
      .task {
        do {
          universities = try await UnivsService().fetchUniversities()
        } catch {
          print("⁉️ Error: \(error.localizedDescription)")
        }
      }
      
      UnivGridView(isSelected: $isSelected, universities: universities)
        .padding(.top, 28)
        .overlay(alignment: .bottom, content: {
          GradationView()
        })
      ChooseButtonView(isSelected: $isSelected, isFirstLaunching: $isFirstLaunching)
    }
  }
}

struct UnivGridView: View {

  @Binding var isSelected: Bool
  @State var selectedIndex: Int?
  var universities: [UnivsEntity]

  var body: some View {
    let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    ScrollView {
      LazyVGrid(columns: columns, spacing: 10) {
        ForEach(universities, id: \.id) { university in
          VStack(spacing: 8) {
            Text(university.universityShortName)
              .font(.pretendard(size: 14, weight: .semibold))
              .foregroundColor(.grey8)
            if !university.campusName.isEmpty {
              Text(university.campusName)
                .font(.pretendard(size: 13, weight: .regular))
                .foregroundColor(.grey6)
            }
          }
          .frame(maxWidth: .infinity)
          .frame(height: 90)
          .background(selectedIndex == university.id - 1 ? Color.grey3 : Color.grey1)
          .cornerRadius(10)
          .onTapGesture {
            if selectedIndex == university.id - 1 {
              selectedIndex = nil
            } else {
              selectedIndex = university.id - 1
            }
            isSelected = selectedIndex != nil
            print("👆 tapped university cell: \(university.universityShortName)")
          }
        }
      }
      .padding(.horizontal, 24)
    }
  }
}


struct ChooseButtonView: View {
  @Binding var isSelected: Bool
  @Binding var isFirstLaunching: Bool

  var body: some View {
    VStack(spacing: 20) {
      AddUnivView()
        .onTapGesture {
          if let url = URL(string: "https://forms.gle/dWY6rnUzkdGbrVs47") {
            UIApplication.shared.open(url)
          }
        }
      SelectUnivButton(isSelected: $isSelected, isFirstLaunching: $isFirstLaunching)
    }
  }
}

struct AddUnivView: View {
  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 14) {
        Image("icon-chat-bubble-dots-mono")
          .frame(width: 24, height: 24)
        
        VStack(alignment: .leading, spacing: 2) {
          Text("여기에 없어요")
            .font(.pretendard(size: 15, weight: .semibold))
            .foregroundColor(.grey8)
          
          Text("학교 신청하러 가기")
            .font(.pretendard(size: 14, weight: .medium))
            .foregroundColor(.grey5)
        }
      }
      .padding(.horizontal, 10)
      
      Spacer()
      
      Image("icon-arrow-right-small-mono")
        .frame(width: 20, height: 20)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.grey2)
    .cornerRadius(100)
    .padding(.horizontal, 22)
  }
}

struct SelectUnivButton: View {
  @Binding var isSelected: Bool
  @Binding var isFirstLaunching: Bool

  var bottomPadding: CGFloat {
    DeviceManager.shared.hasPhysicalHomeButton ? 24 : 0
  }
  
  var body: some View {
    Button {
      if isSelected {
        print("선택하기 버튼 클릭")
        isFirstLaunching = false
      }
    } label: {
      Text("선택하기")
        .frame(maxWidth: .infinity)
        .padding()
        .background(isSelected ? Color.everyMealRed : Color.grey3)
        .font(.pretendard(size: 16, weight: .medium))
        .foregroundColor(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.bottom, bottomPadding)
    }
    .disabled(!isSelected)
  }
}

struct ChooseUnivView_Previews: PreviewProvider {
  static var previews: some View {
    ChooseUnivView(isSelected: true, isFirstLaunching: .constant(true))
  }
}
