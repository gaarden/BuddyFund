//
//  ParticipateFundListView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/22.
//

import SwiftUI

struct ParticipateFundListView: View {
    var body: some View {
        FundingParticipate(product: productSamples[0])
    }
}



struct ParticipateFundListView_Previews: PreviewProvider {
    static var previews: some View {
        FundingParticipate(product: productSamples[1])
    }
}
