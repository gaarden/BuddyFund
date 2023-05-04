//
//  ContentView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{
            FundingProduct()
            FundingProduct()
            FundingProduct()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
