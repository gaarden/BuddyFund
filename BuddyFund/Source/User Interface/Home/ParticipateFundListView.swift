//
//  ParticipateFundListView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/22.
//

import SwiftUI

struct ParticipateFundListView: View {
    @EnvironmentObject var participatesList: ParticipateFundListViewModel
    let user: User
    
    var body: some View {
        
        let participates = participatesList.participateList.sorted { $0.date > $1.date }

        List(participates){ participate in // DB 연결
            VStack {
                FundingParticipate(participant: participate, user: user)
            }
        }
        .listStyle(.plain)
    }
}



struct ParticipateFundListView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipateFundListView(user: userSample)
            .environmentObject(ParticipateFundListViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
//            .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
    }
}
