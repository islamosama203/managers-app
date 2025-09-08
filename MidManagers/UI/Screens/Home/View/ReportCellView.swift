//
//  ReportCellView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/04/2023.
//

import SwiftUI

struct ReportCellView: View {

    @State var report: Report?
    @State var isHidden = false
    @Binding var typeCell: StaticsMode
    @State var indexCell: Int
    @State var specialColor: Color = .white
    @State var allDate: [listModel] = [
            .init(title: "Booking Count", image: "rectangle.3.group.fill"),
            .init(title: "Booking Sum", image: "dollarsign.circle.fill"),
            .init(title: "Signed Contracts", image: "doc.on.clipboard"),
            .init(title: "On Boarding", image: "person.crop.rectangle.stack.fill"),
            .init(title: "Limit Approval", image: "checkmark.seal.fill")
    ]

    var body: some View {

        VStack {
            Spacer().frame(height: 15)
            ZStack {
                SwiftUI.Color.white
                    .cornerRadius(15)
                    .shadow(color: Color(.mainPurple).opacity(0.2), radius: 8)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 95)

                VStack {
                    HStack {
                        Spacer().frame(width: 45)
                        Image(systemName: allDate[indexCell].image)
                            .resizable()
                            .foregroundColor(Color(.mainPurple))
                            .frame(width: 28, height: 28)
                        Spacer().frame(width: 15)
                        Divider().frame(width: 1, height: 95)
                        Spacer().frame(width: 15)
                        VStack(alignment: .leading) {

                            Text(allDate[indexCell].title)
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(Color.gray)
                            ZStack {

                                Text(getTextValue())
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(getForgroundColor())

                            }
                        }
                        Spacer()

                    } // HStack
                } // VStack
                .onAppear {
                    if typeCell == .yearly {
                        allDate[0].title = "YTD Loan Count"
                        allDate[1].title = "YTD Volume"
                    }
                }
            } // ZStack
        } // VStack
    } // body
    
    func getTextValue() -> String {
        if isMoneyField() {
            if getNumberValue() == "0" {
                return "0 EGP"
            } else {
                return formatNumber(Double(getNumberValue()) ?? 0)
            }
            
        } else {
            return getNumberValue().currencyStyle()
        }
    }

    func isMoneyField() -> Bool {
        return report?.name == "2" || report?.name == "5"
    }

    func getNumberValue() -> String {
        switch typeCell {
        case .today:
            report?.dailyNumber ?? ""
        case .monthly:
            report?.monthlyNumber ?? ""
        case .yearly:
            report?.totalNumber ?? ""
        }
    }
    
    func getForgroundColor() -> Color {
        if isMoneyField() {
             return Color(.mainGreen)
        } else {
            return Color(.black)
        }
    }
    
} // MainView


enum StaticsMode: Int {
    case today = 1
    case monthly = 2
    case yearly = 3
}

struct listModel {
    var title: String
    var image: String
}
