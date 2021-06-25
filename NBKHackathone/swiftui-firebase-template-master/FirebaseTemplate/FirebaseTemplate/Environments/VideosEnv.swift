//
//  VideosEnv.swift
//  FirebaseTemplate
//
//  Created by Haider Alboloushi on 25/06/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

class VideoEnv: ObservableObject{
    let collectionName = "videos" // ضع اسم للمكان الذي سيتم فيه الحفظ في قاعدة البيانات
    @Published var items: [VideoItem] = [] // هنا تضع العناصر من النوع الذي قمت بإنشائه
    
    
    func loadItems(){
        Networking.getListOf(COLLECTION_NAME: collectionName) { (items: [VideoItem]) in // تقوم هنا بتعديل النوع أيضاً
            self.items = items
        }
    }
}
