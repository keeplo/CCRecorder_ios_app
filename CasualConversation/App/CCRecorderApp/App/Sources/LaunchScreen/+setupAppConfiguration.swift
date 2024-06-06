//
//  +setupAppConfiguration().swift
//  CCRecorderApp
//
//  Created by 김용우 on 6/2/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Foundation

extension LaunchScreenView {
    
    func setupAppConfiguration() {
        guard let filePath = Bundle.main.path(forResource: "URLs", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("URLs.plist 불러오기 실패")
        }
        Self.mainURL = plist.object(forKey: "Main") as! String
        Self.cafeURL = plist.object(forKey: "Cafe") as! String
        Self.eLearningURL = plist.object(forKey: "eLearning") as! String
        Self.tasteURL = mainURL + (plist.object(forKey: "TastePage") as! String)
        Self.testURL = mainURL + (plst.object(forKey: "TestPage") as! String)
        Self.receptionTel = plist.object(forKey: "ReceptionPhoneNumber") as! String
    }
    
}
