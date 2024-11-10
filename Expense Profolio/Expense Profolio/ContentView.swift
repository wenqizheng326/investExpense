//
//  ContentView.swift
//  Expense Profolio
//
//  Created by Wenqi Zheng on 11/9/24.
//

import SwiftUI
import Auth0

struct ContentView: View {
    
    @State private var isAuthenticated:Bool = false;
    @State var userProfile:Profile = Profile.empty
    
    var body: some View {
        
        //MARK: When User Is Logged In
        
        if isAuthenticated{
            
            VStack {
                Text("User Logged In")
                    .font(.system(size:30))
                    .bold()
                Text("Email: \(userProfile.email)")
                    .padding(.bottom, 15)
                
                Button(action: {
                    logout()
                }, label:{
                    Text("Log Out")
                        .padding(20)
                        .background(Color(red:70/255.0, green: 28/255.0, blue: 137/255.0))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
            }
            
        }else{
            VStack {
                Text("User Login")
                    .font(.system(size:30))
                    .bold()
                Button(action: {
                    login()
                }, label:{
                    Text("Login")
                        .padding(20)
                        .background(Color(red:70/255.0, green: 28/255.0, blue: 137/255.0))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
            }
            .padding()
        }
    }
}

extension ContentView {
  
  private func login() {
      Auth0
          .webAuth()
          .start{ result in
              print("logged in")
              switch result {
              case .failure(let error):
                  print("Failed: \(error)")
                  
              case .success(let credentials):
                  self.isAuthenticated = true
                  self.userProfile = Profile.from(credentials.idToken)
                  print("idToken: \(credentials.idToken)")
              }
          }
  }
  
  private func logout() {
      Auth0
          .webAuth()
          .clearSession{ result in
              switch result{
              case  .failure(let error):
                  print("Failed: \(error)")
              case .success:
                  self.isAuthenticated = false
              }
          }
  }
  
}

#Preview{
    ContentView()
}

