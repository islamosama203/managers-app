//
//  MerchantCountCellView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 13/07/2023.
//

import Foundation
import SwiftUI

struct MerchantCountCellView: View {
    
    var merchant: MerchantCount
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 15)
                VStack {
                    HStack {
                        
                        Text(merchant.merchantName)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(merchant.laonCount)".currencyStyle())
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
