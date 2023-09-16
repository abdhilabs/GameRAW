//
//  ProfileView.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import DesignSystem
import SwiftUI

public struct ProfileView: View {
  
  @State private var username = ""
  @State private var email = ""
  @State private var isEditUsername = false
  @State private var isEditEmail = false
  
  public init() {}
  
  public var body: some View {
    VStack(alignment: .center) {
      
      VerticalSpacer(height: 16)
      
      Image("img-me")
        .resizable()
        .frame(width: 100, height: 100)
        .scaledToFill()
        .clipShape(Circle())
      
      VerticalSpacer(height: 24)
      
      VStack(alignment: .center, spacing: 8) {
        HStack(alignment: .top) {
          if isEditUsername {
            TextField("Username", text: $username)
              .textFieldStyle(.roundedBorder)
          } else {
            let username = PersistentManager.getUsername()
            Text(username.isEmpty ? "Muhamad Riza Abdhi Purnama" : username)
              .font(.title3)
              .multilineTextAlignment(.center)
          }
          
          Button(action: {
            PersistentManager.setUsername(value: username)
            isEditUsername.toggle()
          }, label: {
            Image(systemName: isEditUsername ? "checkmark" : "pencil")
              .resizable()
              .frame(width: 10, height: 10)
          })
        }
        
        HStack(alignment: .top) {
          if isEditEmail {
            TextField("Email", text: $email)
              .textFieldStyle(.roundedBorder)
          } else {
            let email = PersistentManager.getEmail()
            Text(email.isEmpty ? "rizaabdhi@gmail.com" : email)
              .font(.subheadline)
              .multilineTextAlignment(.center)
          }
          
          Button(action: {
            PersistentManager.setEmail(value: email)
            isEditEmail.toggle()
          }, label: {
            Image(systemName: isEditEmail ? "checkmark" : "pencil")
              .resizable()
              .frame(width: 10, height: 10)
          })
        }
      }
      .padding(.horizontal, 24)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color.Background.background)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
