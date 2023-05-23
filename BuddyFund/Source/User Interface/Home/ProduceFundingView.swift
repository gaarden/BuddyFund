//
//  ProduceFundingView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/23.
//

import SwiftUI

struct ProduceFundingView: View {
    @State var setTitle: String = ""
    @State var setDetail: String = ""
    @State var setPrice: String = ""
    @State var setBanking: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("제목")
                    .font(.title2)
                    .bold()
                TextField("제목을 입력하세요", text: $setTitle)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                Text("설명")
                    .font(.title2)
                    .bold()
                TextField("설명을 입력하세요", text: $setDetail)
                    .padding(.bottom, 80)
                    .frame(height: 100)
                    .padding()
                    .background(Color(uiColor:
                            .secondarySystemBackground))
                Text("가격")
                    .font(.title2)
                    .bold()
                TextField("가격을 입력하세요", text: $setPrice)
                    .padding()
                    .background(Color(uiColor:
                            .secondarySystemBackground))
                Text("계좌번호")
                    .font(.title2)
                    .bold()
                TextField("계좌번호를 입력하세요", text: $setBanking)
                    .padding()
                    .background(Color(uiColor:
                            .secondarySystemBackground))
                Text("사진 업로드")
                    .font(.title2)
                    .bold()
            }
            .navigationTitle("펀딩 생성하기")
            .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct ProduceFundingView_Previews: PreviewProvider {
    static var previews: some View {
        ProduceFundingView()
    }
}

