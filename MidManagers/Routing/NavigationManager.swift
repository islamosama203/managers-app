//
//  NavigationManager.swift
//  MidManagers
//
//  Created by Khaled on 23/07/2023.
//

import SwiftUI

class NavigationManager: ObservableObject {
    
    private var container: DIContainer
    private var cancelBag = CancelBag()
    
    @Published var currentRoute: Route = .home
    @Published var navigationPath = NavigationPath()
    
    init(container: DIContainer) {
        self.container = container
        let appState = container.appState
        
        appState.map(\.currentRoute)
            .removeDuplicates()
            .weakAssign(to: \.currentRoute, on: self)
            .store(in: cancelBag)
        $currentRoute.removeDuplicates().sink { route in
            if route != .home {
                if case .back(_) = route {
                    self.navigateBack()
                } else {
                    self.navigate(to: route)
                }
                
            } else {
                self.navigateToRoot()
            }
        }
        .store(in: cancelBag)
    }
    
    func navigate(to route: Route) {
        navigationPath.append(route)
    }
    
    func navigateBack() {
        guard navigationPath.count > 0 else {return}
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath = NavigationPath()
    }
    
    
}
