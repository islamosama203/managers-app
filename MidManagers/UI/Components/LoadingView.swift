//
//  LoadingView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingView: View {

    @Binding var isVisible: Bool


    var body: some View {
        ZStack {
            if isVisible {
//                SwiftUI.Color.gray
//                    .opacity(0.5)
                
                LinearGradient(
                    colors: [Color(uiColor: .black)],
                    startPoint: .top,
                    endPoint: .bottom

                )
                    .opacity(0.4)
                    .ignoresSafeArea()

                ActivityIndicatorView(isVisible: $isVisible,
                                      type: .gradient([Color(uiColor: UIColor(resource: .mainPurple)).opacity(0.4),
                                        Color(uiColor: UIColor(resource: .mainPurple))]))
                    .frame(width: 75, height: 75)
            }
        }
    }
}
