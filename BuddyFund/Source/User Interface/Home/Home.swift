//
//  ContentView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI

struct Home: View {
    let present : Present
    @ObservedObject var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.products){ product in
                ZStack {
                  NavigationLink(
                    destination: {정"
                        ProductDetailView(product: product)
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
              .listStyle(PlainListStyle())
              .navigationTitle("진행중인 펀딩")
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(present: Present())
    }
}
