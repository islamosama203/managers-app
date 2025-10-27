//
//  Routing.swift
//  MidManagers
//
//  Created by Khaled on 22/07/2023.
//

import SwiftUI

//enum NavigationRoute: Hashable {
//    case navigateTo(Route)
//    case root(Bool)
//    case back(String)
//}

enum Route: Hashable {

    case back(backId: String)
    case home
    case bookingCountView
    case merchantCount(categoryId: Int)
    case bookingSumView
    case merchantSum(categoryId: Int)
    case onBoarding
    case rejectDetailsView(rejectionDetails: [ActivationUsersCount])

}

struct RouterViewFactory {

    @ViewBuilder // the swiftUI expect you to build a view
    static func buildView(for route: Route, container: DIContainer) -> some View {

        switch route {
        case .bookingCountView:
            BookingCountView(viewModel: .init(container: container))
                .toolbar(.hidden)
        case .merchantCount(let categoryId):
            MerchantsCountView(viewModel: .init(container: container, categoryId: categoryId))
                .toolbar(.hidden)
        case .bookingSumView:
            BookingSumView(viewModel: .init(container: container))
                .toolbar(.hidden)
        case .merchantSum(let categoryId):
            MerchantsSumView(viewModel: .init(container: container, categoryId: categoryId))
                .toolbar(.hidden)
        case .onBoarding:
            DetailsView(viewModel: .init(container: container))
                .toolbar(.hidden)
        case .rejectDetailsView(let rejectionDetails):
            RejectDetailsView(viewModel: .init(container: container, rejectionDetails: rejectionDetails))
                .toolbar(.hidden)
        default:
            HomeView(viewModel: .init(container: container))
                .toolbar(.hidden)
        }
    }
}
