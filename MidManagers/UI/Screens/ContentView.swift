//
//  ContentView.swift
//  MidManagers
//
//  Created by Khaled on 22/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var navigationManager: NavigationManager
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
        self.navigationManager = NavigationManager(container: container)
        
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        // Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(resource: .mainPurple)
        // Changes the text color for the selected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        // Changes the text color for the unselected item
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(resource: .mainPurple)], for: .normal)
        
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack {
                if UserSession.shared.isUserLogedIn {
                    HomeView(viewModel: HomeView.ViewModel(container: container))
                } else {
                    LoginView(viewModel: LoginView.ViewModel(container: container))
                }
                
            }
                .navigationDestination(for: Route.self) { route in
                    RouterViewFactory.buildView(for: route, container: container)
                }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
