//
//  YearCellView.swift
//  MidManagers
//
//  Created by Khaled on 10/07/2023.
//

import SwiftUI

struct YearCellView: View {
    
    var year: Int
    @Binding var selectedYear: Int
    private var cornerRadius: CGFloat {
        return 20
    }
    
    
    var body: some View {
        
        VStack {
            ZStack {
                
                Text(String("\(year)"))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
                    .foregroundColor(forgroundColor)
                
            } // ZStack
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(uiColor: UIColor(resource: .mainPurple)), lineWidth: 1)
            )
            .onTapGesture {
                selectedYear = year
            }
            
        } // VStack
        .padding(.vertical, 4)
    } // body
    
    private var backgroundColor: Color {
        return year == selectedYear ? Color(uiColor: UIColor(resource: .mainPurple)) : .white
    }
    private var forgroundColor: Color {
        return year == selectedYear ? .white : Color(uiColor: UIColor(resource: .mainPurple))
    }
    
} // MainView
