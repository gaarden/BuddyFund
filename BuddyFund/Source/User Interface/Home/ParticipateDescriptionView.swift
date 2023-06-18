//
//  ParticipateDescriptionView.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/14.
//

import SwiftUI

struct ParticipateDescriptionView: View {
    @EnvironmentObject private var reviewInfo : ReviewInfo
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text("펀딩 참여자 내역")
                .font(.title)
                .fontWeight(.bold)
                .padding(25)
            
            ScrollView {
                ForEach(reviewInfo.reviews, id: \.self) { review in
                    ParticipantReview(review: review)
                        .padding(.horizontal, 10)
                        .environmentObject(ParticipantsDetailViewModel(userid: review.uid))
                }
            }
            .padding(.top, 70)
        }
    }
}

struct ParticipateDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipateDescriptionView()
            .environmentObject(ReviewInfo(pid: "RK0jXlcAcvM0EUQf93Hj"))
    }
}

