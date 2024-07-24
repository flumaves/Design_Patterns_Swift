//
//  AbstractFactory.swift
//  Design_Patterns
//
//  Created by xiong_jia on 2024/7/24.
//

import Foundation

enum AuthType {
    case login
    case signUp
}

// MARK: Abstact Factory
protocol AuthViewFactory {
    static func authView(with type: AuthType) -> AuthView
    
    static func authController(with type: AuthType) -> AuthViewController
}


// MARK: Concrete Factory
class StudentAuthViewFactory: AuthViewFactory {
    class func authView(with type: AuthType) -> AuthView {
        print("Student View has been created.\n")
        switch type {
        case .login:
            return StudentLoginView()
        case .signUp:
            return StudentSignUpView()
        }
    }
    
    class func authController(with type: AuthType) -> AuthViewController {
        let controller = StudentAuthController(contentView: authView(with: type))
        print("Student View Controller has been created.\n")
        return controller
    }
}

class TeacherAuthViewFactory: AuthViewFactory {
    static func authView(with type: AuthType) -> AuthView {
        print("Teacher View has been created.\n")
        switch type {
        case .login:
            return TeacherLoginView()
        case .signUp:
            return TeacherSignUpView()
        }
    }
    
    static func authController(with type: AuthType) -> AuthViewController {
        let controller = TeacherAuthController(contentView: authView(with: type))
        print("Teacher View Controller has been created.\n")
        return controller
    }
}


// MARK: Abstract Product
protocol AuthView {
    typealias AuthAction = (AuthType) -> ()
    
    var contentView: UIView { get }
    var authHandler: AuthAction? { get set }
    
    var description: String { get }
}

class AuthViewController: UIViewController {
    fileprivate var contentView: AuthView
    
    init(contentView: AuthView) {
        self.contentView = contentView
    }
}


// MARK: Concrete Product
class StudentLoginView: UIView, AuthView {
    
    var contentView = UIView()
    var authHandler: AuthAction?
    
    override var description: String {
        "This view's class is StudentLoginView.\n"
    }
}

class StudentSignUpView: UIView, AuthView {
    
    var contentView = UIView()
    var authHandler: AuthAction?
    
    override var description: String {
        "This view's class is StudentSignUpView.\n"
    }
}

class TeacherLoginView: UIView, AuthView {
    
    var contentView = UIView()
    var authHandler: AuthAction?
    
    override var description: String {
        "This view's class is TeacherLoginView.\n"
    }
}

class TeacherSignUpView: UIView, AuthView {
    
    var contentView = UIView()
    var authHandler: AuthAction?
    
    override var description: String {
        "This view's class is TeacherSignUpView.\n"
    }
}

class StudentAuthController: AuthViewController {
    
    /// features for students
}

class TeacherAuthController: AuthViewController {
    
    /// features for teacher
}


// MARK: Client
private class Client {
    
    private var currentController: AuthViewController?
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    func presentLogin() -> AuthViewController {
        return factoryType.authController(with: .login)
    }
    
    func presentSignUp() -> AuthViewController {
        return factoryType.authController(with: .signUp)
    }
    
    /// some other methods
}


class AbstractFactoryDemo {
    
    func demo() {
        
        #if teacherMode
        let client = Client(factoryType: TeacherAuthViewFactory.self)
        #else
        let client = Client(factoryType: StudentAuthViewFactory.self)
        #endif
        
        _  = client.presentLogin()
        print("Login screen has been presented.\n")
        
        _ = client.presentSignUp()
        print("Sign up screen has been presented.\n")
    }
}
