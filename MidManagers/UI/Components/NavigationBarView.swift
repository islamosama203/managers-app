//
//  NavigationBarView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 25/12/2022.
//

import SwiftUI

struct NavigationBarView: View {
    
    var title: String
    var container : DIContainer
    
    var body: some View {
        HStack {
            Spacer().frame(width: 15)
            Button {
                container.appState[\.currentRoute] = .back(backId: UUID().uuidString)
            } label: {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .foregroundColor(Color(uiColor: UIColor(resource: .mainPurple)))
                    .frame(width: 20, height: 15)
            }
            Spacer().frame(width: 15)
            Text(title)
                .font(.body)
                .foregroundColor(.black)
                .fontWeight(.semibold)
            
            Spacer()
            Image("logoRed")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 50)
            Spacer().frame(width: 15)
        }
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBarView(title: "Test", container: .preview)
//            .previewLayout(.fixed(width: 375, height: 80))
//    }
//}
