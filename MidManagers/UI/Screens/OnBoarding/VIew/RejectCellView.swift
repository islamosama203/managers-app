//
//  RejectCellView.swift
//  MidManagers
//
//  Created by Khaled Mohmed on 11/03/2024.
//

import Foundation
import SwiftUI

struct RejectCellView: View {
    
    var rejection: ActivationUsersCount
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 15)
                VStack {
                    HStack {
                        
                        Text(rejection.statusName)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(rejection.usersCount)".currencyStyle())
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color(.mainPurple))

                    } // HStack
                    .padding(.horizontal, 15)
                } // VStack
            
            .frame(width: UIScreen.main.bounds.width - 50, height: 60)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: Color(uiColor: UIColor(resource: .mainPurple)).opacity(0.2), radius: 8)
            .padding(.horizontal, 10)
            
            
        } // VStack
    } // body
} // MainView
