//
//  CreateStorageView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 03/04/22.
//

import SwiftUI

struct CreateStorageView: View {
    @ObservedObject var viewModel: PantryManagerViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CreateStorageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateStorageView(viewModel: PantryManagerViewModel())
    }
}
