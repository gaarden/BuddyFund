//
//  ContentView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI

struct Home: View {
//    @EnvironmentObject private var present : Present
    @EnvironmentObject private var productsInfo : ProductsViewModel
    
    var body: some View {
        NavigationView {
            List(productsInfo.products){ product in // DB 연결
//            List(present.products){ product in
                ZStack {
                  NavigationLink(
                    destination: {
                        ProductDetailView(product: product)
                            .environmentObject(ReviewInfo(pid: product.pid))
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
        Preview(source:Home())
//            .environmentObject(Present())
            .environmentObject(ProductsViewModel(uid: "testid"))
//            .environmentObject(ParticipateFundingViewModel())
    }
}
