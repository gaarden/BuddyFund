//
//  Mypage.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/18.
//

import SwiftUI

struct Mypage: View {
    let product : Product
    
    var body: some View {
        VStack{
            ProfileBox(product: product)
                .scaleEffect(0.8)
            HStack{
                Button(
                    action: {print("버튼")}
                ){Text("참여한 펀딩")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width:130,height: 40)
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(6)
                Button(
                    action: {print("버튼")}
                ){Text("진행한 펀딩")}
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width:130,height: 40)
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(6)
                Spacer()
            }
            List{
                Text("진행한 펀딩이 없습니다.")
                FundingProduct(product: product)
                FundingProduct(product: product)
                
            }.listStyle(.plain)
            Spacer()
        }.padding()
    }
}

struct Mypage_Previews: PreviewProvider {
    static var previews: some View {
        Mypage(product: productSamples[2])
        ProfileBox(product: productSamples[1])
        
    }
}
