//
//  FactoryMethod.swift
//  Design_Patterns
//
//  Created by xiong_jia on 2024/7/22.
//

import Foundation

// MARK: Creator
/// Creator 接口声明了工厂方法，该方法应返回一个产品类的新对象。创造者的子类通常会提供该方法的该方法的实现。
protocol Creator {
    
    func factoryMethod() -> Product
    
    func someOperation() -> String
}

/// 提供一些接口的默认实现
extension Creator {
    
    func someOperation() -> String {
        let product = factoryMethod()
        
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
}


// MARK: Concrete Creators
/// Concrete Creators 中重写工厂方法来改变返回的产品的类型
class ConcreteCreator1: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}


// MARK: Product
/// Product 接口中声明了所有产品必须实现的方法
protocol Product {
    
    func operation() -> String
}


// MARK: Concrete Products
/// Concrete Products 中提供了各种产品方法的实现
class ConcreteProduct1: Product {
    
    public func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class ConcreteProduct2: Product {
    
    public func operation() -> String {
        return "{Result of the ConcreteProduct2}"
    }
}


// MARK: Client
private class Client {
    
    class func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the cretor's class, but it still works.\n" + creator.someOperation())
    }
}


class FactoryMethodDemo {
    
    func demo() {
        print("App: Launched with the ConcreteCreator1.\n")
        Client.someClientCode(creator: ConcreteCreator1())
        
        print("App: Launched with the ConcreteCreator2.\n")
        Client.someClientCode(creator: ConcreteCreator2())
    }
}
