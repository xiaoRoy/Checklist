//
//  Checklist.swift
//  Checklist
//
//  Created by Jerry Li on 2019/12/21.
//  Copyright © 2019 Jerry Li. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name: String
    var checklistItems = Array<ChecklistItem>()
    //    var checklistItmeList = [ChecklistItem]()
    
    //    var checklistItmeList: Array<ChecklistItem> = Array<ChecklistItem>()
    //    var checklistItmeList: Array<ChecklistItem> = [ChecklistItem]()
    //    var checklistItmeList: Array<ChecklistItem> = []
    
    //    var checklistItmeList: [ChecklistItem] = Array<ChecklistItem>()
    //    var checklistItmeList: [ChecklistItem] = [ChecklistItem]()
    //    var checklistItmeList: [ChecklistItem] = []
    
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
