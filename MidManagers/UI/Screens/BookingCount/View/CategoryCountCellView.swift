//
//  CategoryCellView.swift
//  MidManagers
//
//  Created by Khaled on 13/07/2023.
//

import SwiftUI

struct CategoryCountCellView: View {
    
    var category: CategoryCount
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 15)
                VStack {
                    HStack {
                        
                        Text(category.categoryName)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(category.categoryTotalCount)".currencyStyle())
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color(.mainPurple))

                    } // HStack
                    .padding(.horizontal, 15)
                } // VStack
            
            .frame(width: UIScreen.main.bounds.width - 50, height: 60)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: Color(.mainPurple).opacity(0.2), radius: 8)
            .padding(.horizontal, 10)
            
            
        } // VStack
    } // body
} // MainView
