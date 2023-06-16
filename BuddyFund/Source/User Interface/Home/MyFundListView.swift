//
//  MyFundListView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/22.
//

import SwiftUI

struct MyFundListView: View {
    
    var body: some View {
        FundingProgress(product: productSamples[1])
    }
}

struct MyFundListView_Previews: PreviewProvider {
    static var previews: some View {
        MyFundListView()
    }
}
