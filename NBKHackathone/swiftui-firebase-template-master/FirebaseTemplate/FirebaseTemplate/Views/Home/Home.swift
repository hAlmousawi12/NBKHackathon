//
//  Home.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 12/27/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct SignOutButton: View{
    var env: FirebaseEnv
    var body: some View{
        Button("Signout") {
            env.signOut()
        }
        .foregroundColor(Color.theme.red)
    }
}

struct Home: View {
    @EnvironmentObject var userEnv: UserEnv
    var body: some View {
        ZStack {
            Color.theme.bg.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    VStack(spacing: 14) {
                        head
                        balance
                    }
                    .padding(.horizontal, 30)
                    incomeAndExpense
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                    wallet
                    Spacer()
                    recent
                        .padding(.horizontal, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            userEnv.getUser()
            userEnv.getOtherUsersData()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserEnv())
    }
}

extension Home {
    private var head: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .foregroundColor(.secondary)
                
                Text(userEnv.user.fullName)
                    .font(.title2)
                    .foregroundColor(Color.theme.text)
                    .bold()
            }
            Spacer()
            Image(systemName: "bell.fill")
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
    
    private var balance: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("$\(userEnv.totalBalance)")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Text("Total Balance")
                    .font(.footnote)
                    .foregroundColor(.white)
            }.padding(.leading, 30)
            Spacer()
            Image("graph")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 100)
        .background(Color.theme.blue)
        .cornerRadius(15)
    }
    
    private var incomeAndExpense: some View {
        HStack {
            Image(systemName: "arrow.down")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.theme.blue)
                .frame(width: 45, height: 45)
                .background(Color.theme.secondary)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Income")
                    .foregroundColor(.secondary)
                Text("$\(userEnv.totalIncome)")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .padding(.leading, 2)
            }
            Spacer()
            Image(systemName: "arrow.up")
                .foregroundColor(Color.theme.orange)
                .font(.system(size: 20, weight: .bold))
                .frame(width: 45, height: 45)
                .background(Color.theme.secondary)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Expense")
                    .foregroundColor(.secondary)
                Text("$\(userEnv.totalExpense)")
                    .foregroundColor(Color.theme.text)
                    .bold()
                    .padding(.leading, 2)
            }
            
        }
    }
    
    private var wallet: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Wallet")
                        .bold()
                    Text("2 Budget, 1 Savings")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .padding(.leading, 2)
                }
                Spacer()
                Button(action: {
                    print("added new")
                }, label: {
                    Text("+ Add New")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                })
            }.padding(.horizontal, 30)
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 20) {
                    itemInWallet(color: Color.theme.blue, money: "$45.00", category: "Food")
                    itemInWallet(color: Color.theme.orange, money: "$150.00", category: "Clothing")
                    itemInWallet(color: Color.theme.blue, money: "$60.50", category: "Parking")
                }.padding(.leading, 30)
            })
        }
    }
    
    private var recent: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Recent Transaction")
                    .bold()
                    .foregroundColor(Color.theme.text)
                Spacer()
                Button(action: {
                    print("seen all")
                }, label: {
                    Text("See All")
                        .foregroundColor(Color.theme.blue)
                        .fontWeight(.semibold)
                })
            }
            VStack(spacing: 20) {
                Transaction(onWhat: "Food & Beverage", time: "Today . Makan Bakso", price: "-$15.00", imageName: "food-orange")
                Transaction(onWhat: "Medicine", time: "Yesterday . Pharmacy", price: "-$15.50", imageName: "medicine")
                Transaction(onWhat: "Clothing", time: "2 Weeks ago . Tommy Helfiger", price: "-$55.46", imageName: "clothing")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
        }.padding(.top, 10)
    }
}

struct Transaction: View {
    var onWhat: String
    var time: String
    var price: String
    var imageName: String
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            VStack(alignment: .leading) {
                Text(onWhat)
                    .foregroundColor(Color.theme.text)
                    .bold()
                Text(time)
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(price)
                .foregroundColor(Color.theme.red)
        }
        
    }
}

struct itemInWallet: View {
    var color: Color
    var money: String
    var category: String
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Spacer()
                Text(money)
                    .bold()
                    .font(.title3)
                Text(category)
                    .font(.callout)
            }.padding()
            Spacer()
        }
        .foregroundColor(.white)
        .frame(width: 130, height: 150)
        .background(color)
        .cornerRadius(15)
        
    }
}
