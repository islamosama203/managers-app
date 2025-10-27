//
//  LoseConnectionInternetView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import SwiftUI

struct LoseConnectionInternetView: View {

    
    var didTapRetry: (() -> ())
    
    var body: some View {

        
        VStack {
            
            Spacer().frame(height: 50)

            LottieView(lottieFile: "InternetError")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)

            Text("checkInternetConnection")
                .font(.system(size: 15))
                .fontWeight(.bold)
                .lineLimit(nil)
            Spacer().frame(height: 50)


            Button(action: {
                // calling retry func on appState
                didTapRetry()
                
            }, label: {
                Text("btnRetry")
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                })
                .containerShape(Rectangle())
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .foregroundColor(.white)
                .background(Color(.mainPurple))
                .cornerRadius(5)
                .font(.system(size: 18))
                .fontWeight(.bold)

            Spacer()
        }
        .background(SwiftUI.Color.white)
       
    }
}

#if DEBUG
struct LoseConnectionInternetView_Previews: PreviewProvider {
    static var previews: some View {
        LoseConnectionInternetView(didTapRetry: {})
    }
}
#endif
