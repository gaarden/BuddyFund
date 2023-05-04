//
//  FundingProduct.swift
//  BuddyFund
//
//  Created by dahye on 2023/05/04.
//

import SwiftUI

struct FundingProduct: View {
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80,height:80)
                        .clipShape(Circle())
                    Text("정다혜")
                    Text("D-5")
                        .font(.title2)
                }
                VStack(alignment: .leading){
                    Text("펀딩제목")
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.bottom,6)
                    Spacer()
                    Text("펀딩설명펀딩설명펀딩설명펀딩설명")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }.padding(5)
                Image("slamdunk")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100)
                    .clipped()
            }.frame(height: 140)
                .padding([.horizontal,.top], 5)
            HStack{
                Rectangle()
                    .frame(width:300, height: 10)
                    .overlay(Rectangle()
                        .fill(.green)
                        .frame(width:200)
                             ,alignment:.leading)
                    .cornerRadius(6)
                Text("60%")
                Image(systemName:"star")
            }.padding([.horizontal,.bottom], 8)
        }.background(Color.red.opacity(0.05)/*Color.primary.colorInvert()*/)
            .cornerRadius(6)
            .shadow(color:Color.primary.opacity(0.33), radius: 1,x:2, y:2)
            .padding(.vertical,8)
    }
}

struct FundingProduct_Previews: PreviewProvider {
    static var previews: some View {
        FundingProduct()
    }
}
