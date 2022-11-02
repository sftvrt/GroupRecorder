//
//  RootViewModel.swift
//

import SwiftUI

class RootViewModel: ObservableObject {

    /// tab
    @Published var tabSelection: Int = 0
    
    @Published var isPop: Bool = false

    /// hide navigationtab
    @Published var tabNavigationHidden: Bool = false
    
    /// title
    @Published var tabNavigationTitle: LocalizedStringKey = ""
    
    /// left button
    @Published var tabNavigationBarLeadingItems: AnyView = .init(EmptyView())

    /// right button
    @Published var tabNavigationBarTrailingItems: AnyView = .init(EmptyView())
    
}

