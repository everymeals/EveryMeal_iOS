//
//  EverymealAlertView.swift
//  EveryMeal_iOS
//
//  Created by 김하늘 on 2023/10/04.
//

import SwiftUI

struct EverymealAlertView: View {
  var title: String? = nil
  var description: String? = nil
  var okButtonTitle: String = "확인"
  var cancelButtonTitle: String = "취소"
  
  var okButtonTapped: () -> Void
  var cancelButtonTapped: () -> Void
  var backgroundTouchEnabled: Bool = false
  
  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 24) {
        VStack(alignment: .leading, spacing: 8) {
          if let title = title {
            Text(title)
              .font(.pretendard(size: 18, weight: .bold))
              .foregroundColor(.black)
          }
          if let description = description {
            Text(description)
              .font(.pretendard(size: 15, weight: .regular))
              .foregroundColor(.grey7)
          }
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
        
        HStack(alignment: .center, spacing: 10) {
          Button(action: {
            okButtonTapped()
          }, label: {
            Spacer()
            Text(okButtonTitle)
              .font(.pretendard(size: 16, weight: .medium))
              .foregroundColor(.grey7)
            Spacer()
          })
          .frame(height: 54)
          .background(Color.grey2)
          .cornerRadius(12)
          
          Button(action: {
            cancelButtonTapped()
          }, label: {
            Spacer()
            Text(cancelButtonTitle)
              .font(.pretendard(size: 16, weight: .medium))
              .foregroundColor(.white)
            Spacer()
          })
          .frame(height: 54)
          .background(Color.everyMealRed)
          .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        
      }
      .frame(width: UIScreen.main.bounds.width - 56)
      .background(Color.white)
      .cornerRadius(10)
    }
    .background(Background(backgroundTouchEnabled: true, backgroundTapped: {
      cancelButtonTapped()
    }))
  }
}

struct Background: UIViewControllerRepresentable {
  var backgroundTouchEnabled: Bool = false
  var backgroundTapped: (() -> Void)?
  
  public func makeUIViewController(context: UIViewControllerRepresentableContext<Background>) -> UIViewController {
    return Controller(backgroundTouchEnabled: backgroundTouchEnabled,
                      backgroundTapped: backgroundTapped)
  }
  
  public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Background>) {
  }
  
  class Controller: UIViewController, UIGestureRecognizerDelegate {
    var backgroundTouchEnabled: Bool = false
    var backgroundTapped: (() -> Void)?
    
    init(backgroundTouchEnabled: Bool, backgroundTapped: (() -> Void)? = nil) {
      self.backgroundTouchEnabled = backgroundTouchEnabled
      self.backgroundTapped = backgroundTapped
      
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
      
      if backgroundTouchEnabled {
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
      }
    }
    
    override func willMove(toParent parent: UIViewController?) {
      super.willMove(toParent: parent)
      parent?.view?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
      parent?.modalPresentationStyle = .overCurrentContext
    }
    
    @objc private func tapped(_ gesture: UITapGestureRecognizer) {
      if gesture.state == .ended {
        backgroundTapped?()
      }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      if gestureRecognizer.state == .ended {
        backgroundTapped?()
      }
      return true
    }
  }
}

struct EverymealAlertView_Previews: PreviewProvider {
  static var previews: some View {
    EverymealAlertView(
      title: "타이틀",
      description: "내용",
      okButtonTapped: {
        print("ok button tapped")
      },
      cancelButtonTapped: {
        print("cancel button tapped")
      })
  }
}
