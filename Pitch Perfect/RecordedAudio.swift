//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Gershy Lev on 4/8/15.
//  Copyright (c) 2015 Gershy Lev. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var title: String!
    
    init(filePath: NSURL, title: String) {
        filePathURL = filePath
        self.title = title
    }
    
}
