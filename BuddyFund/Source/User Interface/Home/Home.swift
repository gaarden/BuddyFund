//
//  ContentView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI

struct Home: View {
    let present : Present
    
    var body: some View {
        NavigationView {
              List(present.products){ product in
                ZStack {
                  NavigationLink(
                    destination: {
                        ProductDetailView(product: product)
//                          .navigationBarBackButtonHidden()
                    },
                    label: {
                      EmptyView()
                    }
                  )
                  .opacity(0)
                  
                  HStack {
                      FundingProduct(product: product)
                  }
                }
              }
              .navigationTitle("진행중인 펀딩")
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(present: Present())
    }
}
