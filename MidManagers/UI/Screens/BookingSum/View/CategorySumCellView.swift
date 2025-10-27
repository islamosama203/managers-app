//
//  CategorySumCellView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 13/07/2023.
//


import SwiftUI

struct CategorySumCellView: View {
    
    var category: CategorySum
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 15)
                VStack {
                    HStack {
                        
                        Text(category.categoryName)
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                         
                        Text("\(Int(category.categoryTotalSum))".currencyStyle() + " EGP")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color(.mainGreen))

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
