//
//  ChainOfResponsibility.swift
//  Design_Patterns
//
//  Created by xiong_jia on 2024/7/18.
//

import Foundation

/// 责任链
/// 当希望让一个以上的对象有机会能够处理某个请求的时候，就可以使用责任链模式（Chain of Responsibility Pattern）
///
/// 通过责任链模式，可以为某个请求创建一个对象链。每个对象依次检查该请求并进行处理或者将该请求传递给链中的下一个对象。

/// 责任链的优点
/// 1、将请求的发送者和接受者解耦
/// 2、可以简化你的对象，因为他不需要知道链的结构
/// 3、通过改变链内的成员或调动它们的次序，允许动态地新增或删除责任。

/// 责任链的缺点
/// 1、并不保证请求一定会被执行，如果没有任何对象处理请求的话，可能会落在链尾端之外（不一定是缺点）
/// 2、不容易观察运行时的特征，不利于除错

/// 责任链的应用场景
/// 经常被使用在窗口系统中，处理鼠标、键盘、触摸之类的交互事件


protocol Handler: AnyObject {
    
    @discardableResult
    func setNext(_ handler: Handler) -> Handler
    
    func handle(_ request: String) -> String?
    
    var nextHandler: Handler? { get set }
}

extension Handler {
    
    func setNext(_ handler: Handler) -> Handler {
        self.nextHandler = handler
        
        return handler
    }
    
    func handle(_ request: String) -> String? {
        return nextHandler?.handle(request)
    }
}


let kMercedes = "Mercedes"
let kRollsRoyce = "RollsRoyce"
let kFerrari = "Ferrari"
let kLamborghini = "Lamborghini"


class MercedesStore: Handler {
    
    var nextHandler: Handler?
    
    func handle(_ request: String) -> String? {
        if request == kMercedes {
            return kMercedes + " store will sell the " + kMercedes + ".\n"
        } else {
            return nextHandler?.handle(request)
        }
    }
}

class RollsRoyceStore: Handler {
    
    var nextHandler: Handler?
    
    func handle(_ request: String) -> String? {
        if request == kRollsRoyce {
            return kRollsRoyce + " store will sell the " + kRollsRoyce + ".\n"
        } else {
            return nextHandler?.handle(request)
        }
    }
}

class FerrariStore: Handler {
    
    var nextHandler: Handler?
    
    func handle(_ request: String) -> String? {
        if request == kFerrari {
            return kFerrari + " store will sell the " + kFerrari + ".\n"
        } else {
            return nextHandler?.handle(request)
        }
    }
}

class Customer {
    
    let carShoppingList: [String] = [kFerrari, kMercedes, kFerrari, kRollsRoyce, kMercedes, kLamborghini]
    
    func carShopping(handler: Handler) {
        for car in carShoppingList {
            print("Who can sell the customer a \(car)?\n")
            
            guard let result = handler.handle(car) else {
                print("  Dont have \(car) store in this place.\n")
                continue
            }
            
            print("  " + result)
        }
    }
}

class ChainOfResponsibilityDemo {
    
    let mercedesStore = MercedesStore()
    let rollsRoyceStore = RollsRoyceStore()
    let ferrariStore = FerrariStore()
    
    init() {
        mercedesStore.setNext(rollsRoyceStore).setNext(ferrariStore)
    }
    
    func test() {
        
        print("Chain: \(kMercedes) -> \(kRollsRoyce) -> \(kFerrari)\n")
        
        Customer().carShopping(handler: mercedesStore)
    }
}
