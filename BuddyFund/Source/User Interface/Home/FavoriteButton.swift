//
//  FavoriteButton.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/31.
//

import SwiftUI
import Firebase

struct FavoriteButton: View {
//    @EnvironmentObject private var present: Present
    let product: Product
    @EnvironmentObject private var present: ProductsViewModel
    @EnvironmentObject private var userInfo: UserInfo
    
    private var imageName: String {
        product.isFavorite ? "star.fill" : "star"
    }
    
    var body: some View {
        Image(systemName: imageName)
            .imageScale(.large)
            .foregroundColor(.yellow)
            .frame(width: 32, height: 32)
            .onTapGesture {
                self.present.toggleFavorite(of: self.product)
                uploadFavorites()
            }
    }
    
    func uploadFavorites() {
        let userRef = Firestore.firestore().collection("users").document(userInfo.user.uid)
        if self.product.isFavorite == true {
            print("토글 해제")
            userRef.updateData(["favorites": FieldValue.arrayRemove([self.product.pid])]) { error in
                if let error = error {
                    print("Error updating user document's favorites: \(error)")
                }
            }
            
        } else {
            print("토글 활성화")
            userRef.updateData(["favorites": FieldValue.arrayUnion([self.product.pid])]) { error in
                if let error = error {
                    print("Error updating user document's favorites: \(error)")
                }
            }
        }
        
    }
}
struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            FavoriteButton(product: productSamples[0])
//                .environmentObject(ProductsViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
//                .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
            FavoriteButton(product: productSamples[2])
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
