//
//  FakeUIKit.swift
//  Design_Patterns
//
//  Created by xiong_jia on 2024/7/24.
//

import Foundation

class UIView {
    
    public var description: String {
         "This view's class is UIView.\n"
    }
}


class UIViewController {
    
    public var view = UIView()
}
