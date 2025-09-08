//
//  OnBoardingSectionView.swift
//  MidManagers
//
//  Created by Khaled on 06/03/2024.
//

import SwiftUI

enum SectionTitleType {
    case main
    case sub
}

struct OnBoardingSectionView: View {
    
    @State var model: OnBoardingSectionItem
    @State var tapAction: (() -> ())
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 15)
                Text(model.title)
                    .font(getFont())
                    .foregroundColor(getHeaderTextColor())
                Spacer()
            }
            HStack {
                Spacer().frame(width: 15)
                ForEach(model.items) { item in
                    CounterCardView(title: item.title , value: item.value, color: getCardColor())
                        .onTapGesture {
                            if model.title == "System Reject" && item.title == "Count" {
                                tapAction()
                            }
                        
                    }
                }
                Spacer().frame(width: 15)
            }
        }
    }
    
    func getFont() -> Font {
        switch model.titleType {
        case .main:
            return .custom("Poppins-Medium", size: 16)
        case .sub:
            return .custom("Poppins-Medium", size: 14)

        }
    }
    
    func getHeaderTextColor() -> Color {
        switch model.titleType {
        case .main:
            Color(.mainPurple)
        case .sub:
            Color(.mainGreen)
        }
    }
    
    func getCardColor() -> Color {
        switch model.sectionType {
        case .approval:
            Color(.mainGreen)
        case .pending:
            Color.gray
        case .reject:
            Color.red
        }

    }
    
}

#if DEBUG
#Preview {
    OnBoardingSectionView(model: OnBoardingSectionItem(title: "title", titleType: .main, items: [OnBoardingItem(title: "subTitle", value: "12"), OnBoardingItem(title: "subTitle", value: "12")], sectionType: .approval), tapAction: {})
}
#endif
