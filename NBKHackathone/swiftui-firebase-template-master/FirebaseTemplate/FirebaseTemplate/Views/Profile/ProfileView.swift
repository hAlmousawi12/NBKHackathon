//
//  ProfileView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var env: FirebaseEnv
    @EnvironmentObject var userEnv: UserEnv
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            VStack {
                accounts
                Spacer()
                SignOutButton(env: env)
            }.navigationBarHidden(true)
        }.onAppear {
            userEnv.getOtherUsersData()
        }
    }
}

extension ProfileView {
    private var accounts: some View {
        
        VStack {
            HStack {
                Text("Accounts")
                    .foregroundColor(.theme.text)
                    .bold()
                    .font(.title2)
                Spacer()
                NavigationLink(destination: AddAnotherAccount().environmentObject(UserEnv())) {
                    Text("+ Add New")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                }
            }.padding(.horizontal, 30)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(userEnv.otherUsers, id: \.self) { user in
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text(user.fullName)
                                .font(.title2)
                                .bold()
                            
                            Text("\(user.budget.balance)")
                                .font(.title2)
                                .bold()
                            HStack {
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.theme.green)
                                    .frame(width: 30, height: 30)
                                    .background(Color.theme.secondary)
                                    .cornerRadius(10)
                                
                                Text("\(user.budget.income)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                            HStack {
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.theme.red)
                                    .frame(width: 30, height: 30)
                                    .background(Color.theme.secondary)
                                    .cornerRadius(10)
                                
                                Text("\(user.budget.expense)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 150, height: 180)
                        .padding()
                        .background(Color.theme.orange)
                        .cornerRadius(15)
                        .padding(.leading, 30)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
