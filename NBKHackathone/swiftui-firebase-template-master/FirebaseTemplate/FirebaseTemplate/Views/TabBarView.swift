//
//  TabBarView.swift
//  FirebaseTemplate
//
//  Created by Hussain on 6/25/21.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Home().environmentObject(UserEnv()).tabItem {
                Image(systemName: "house.fill")
            }
            
            Planning().tabItem {
                Image(systemName: "creditcard.fill")
            }
            
            ProfileView().environmentObject(FirebaseEnv()).tabItem {
                Image(systemName: "person.fill")
            }
            
            Video().tabItem {
                Image(systemName: "video.fill")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
