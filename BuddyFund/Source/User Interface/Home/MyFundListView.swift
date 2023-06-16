//
//  MyFundListView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/22.
//

import SwiftUI

struct MyFundListView: View {
    @EnvironmentObject var creates: CreateFundListVIewModel
    var body: some View {
        List(creates.createsFund){ product in
            FundingProgress(product: product)
        }
    }
}

struct MyFundListView_Previews: PreviewProvider {
    static var previews: some View {
        MyFundListView()
            .environmentObject(CreateFundListVIewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
    }
}
