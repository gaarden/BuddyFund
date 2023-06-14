//
//  ParticipantReview.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/14.
//

import SwiftUI

struct ParticipantReview: View {
    var review : Review
    @EnvironmentObject var participant : ParticipantsDetailViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            participantProfile
            
            VStack(alignment: .leading) {
                participantInfo
                
                Text("\(review.comment)")
                
            }
        }
        .padding(.bottom, 30)
    }
    
    var participantProfile: some View {
        ShowImage(imageURL: "\(participant.user.profileImage)")
            .frame(width: 80,height:80)
            .clipShape(Circle())
    }
    
    var participantInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack{
                    Text("\(participant.user.username)")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(review.username)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Text("\(review.commentDate)")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            
            Spacer()
            
            HStack {
                Image(systemName: "wonsign.circle.fill")
                    .foregroundColor(.yellow)
                Text("\(review.funding)")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(.indigo)
            .cornerRadius(30)
        }
    }
    
//    func pullParticipantInfo(uid: String) {
//        let participant = UserInfo(userid: uid).user
//    }
}

struct ParticipantReview_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantReview(review: reviewSamples[0])
            .environmentObject(ParticipantsDetailViewModel(userid: "0cOa7C63F7uJHbAF7qcw"))
    }
}
