//
//  ProduceFundingView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/23.
//

import SwiftUI

struct ProduceFundingView: View {
    @State private var setTitle: String = ""
    @State private var setDetail: String = ""
    @State private var setPrice: String = ""
    @State private var setBanking: String = ""
    @State private var showEmptyFieldsAlert = false
    @State private var showConfirmationAlert = false
    @State private var showSaveAlert = false
    
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
                    .background(Color(uiColor: .secondarySystemBackground))
                
                Text("가격")
                    .font(.title2)
                    .bold()
                TextField("가격을 입력하세요", text: $setPrice)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                
                Text("계좌번호")
                    .font(.title2)
                    .bold()
                TextField("계좌번호를 입력하세요", text: $setBanking)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                
                Text("사진 업로드")
                    .font(.title2)
                    .bold()
                
                HStack {
                    Spacer()
                    Button(action: {
                        showSaveAlert = true
                    }) {
                        Text("임시저장")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $showSaveAlert) {
                        Alert(
                            title: Text("알림"),
                            message: Text("임시저장되었습니다."),
                            dismissButton: .default(Text("확인"))
                        )
                    }
                    
                    Spacer()
                    
                    Button(action:{
                        if fieldsAreNotEmpty() {
                            showConfirmationAlert = true
                        } else {
                            showEmptyFieldsAlert = true
                        }
                    }) {
                        Text("펀딩 생성하기")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $showEmptyFieldsAlert) {
                        Alert(
                            title: Text("알림"),
                            message: Text("정보를 올바르게 입력해주세요."),
                            dismissButton: .default(Text("확인"))
                        )
                    }
                    .alert(isPresented: $showConfirmationAlert) {
                        Alert(
                            title: Text("알림"),
                            message: Text("펀딩을 생성하시겠습니까?"),
                            primaryButton: .default(Text("확인"), action: {
                                // 펀딩 생성 로직을 여기에 추가하세요.
                            }),
                            secondaryButton: .cancel(Text("취소"))
                        )
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationTitle("펀딩 생성하기")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
        }
    }
    
    func fieldsAreNotEmpty() -> Bool {
        return !setTitle.isEmpty && !setDetail.isEmpty && !setBanking.isEmpty && !setPrice.isEmpty && Double(setPrice) != nil && Double(setPrice)! > 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProduceFundingView()
    }
}
