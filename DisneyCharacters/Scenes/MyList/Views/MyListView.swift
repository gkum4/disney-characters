//
//  MyListView.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 02/01/25.
//

import SwiftUI

struct MyListView: View {
    @StateObject private var viewModel: MyListViewModel
    
    private init(viewModel: MyListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("MyListView")
    }
}

extension MyListView {
    static func create() -> Self {
        return MyListView(viewModel: MyListViewModel())
    }
}

#Preview {
    MyListView.create()
}
