//
//  CounterCardView.swift
//  MidManagers
//
//  Created by Khaled on 06/03/2024.
//

import SwiftUI

struct CounterCardView: View {
    
    @State var title: String
    @State var value: String
    @State var color: Color
    @State var isButton: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Poppins-Medium", size: 12))
                .foregroundColor(.gray)
            Text(value)
                .font(.custom("Poppins-Medium", size: 12))
                .foregroundColor(Color(.mainPurple))
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 65, alignment: .center)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(color: color.opacity(0.1), radius: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(color.opacity(0.1), lineWidth: 1)
        )
        
        
    }
}

#if DEBUG
#Preview {
    CounterCardView(title: "Title", value: "00", color: .gray)
}
#endif
