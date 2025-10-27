//
//  MidPickerView.swift
//  MidManagers
//
//  Created by Khaled on 02/03/2024.
//

import SwiftUI

struct MidPickerView: View {

    @Binding var items: [MidPickerItem]
    var onItemSelected: ((Int) -> ())
    
    var body: some View {
        HStack {
            ForEach(items) { item in
                MidPickerItemView(title: item.title, isSelected: item.isSelected)
                    .onTapGesture {
                    for index in items.indices {
                        if item.id == items[index].id {
                            items[index].isSelected = true
                            onItemSelected(index)
                        } else {
                            items[index].isSelected = false
                        }
                    }
                }
            }
            .id(items)

        }
            .cornerRadius(8, antialiased: true)
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.mainPurple), lineWidth: 1)
        )
            
    }
}

struct MidPickerItemView: View {

    @State var title: String
    @State var isSelected: Bool

    var body: some View {
        Text(title)
            .font(.custom("Poppins-Medium", size: 14))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .foregroundStyle(isSelected ? Color(.white) : Color(.mainPurple))
            .background(isSelected ? Color(.mainPurple) : Color(.white))

    }
}


struct MidPickerItem: Identifiable, Hashable {
    var id: Int
    var title: String
    var isSelected: Bool
}

//
//#Preview {
//    MidPickerView()
//}
