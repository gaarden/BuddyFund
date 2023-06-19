//
//  SwiftUIView.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/19.
//

import SwiftUI

struct SwiftUIView: View {
    let product : Product
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        
        let currentDate = Date()
        let currentYear = Calendar.current.component(.year, from: currentDate)
        
        if let birthdayDate = dateFormatter.date(from: product.bday) {
            
            let calendar = Calendar.current
            let birthdayComponents = calendar.dateComponents([.month, .day], from: birthdayDate)
            var nextBirthdayComponents = DateComponents()
            nextBirthdayComponents.year = currentYear
            nextBirthdayComponents.month = birthdayComponents.month
            nextBirthdayComponents.day = birthdayComponents.day
            
            return VStack {
                Text("\(product.bday)")
                Text("\(currentDate)")
                Text("\(currentYear)")
            }
        }
            
        return Text("")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(product: productSamples[1])
    }
}
