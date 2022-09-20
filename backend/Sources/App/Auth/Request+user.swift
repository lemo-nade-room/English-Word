import Vapor

extension Request {
    
    func user() throws -> User {
        return try auth.require(User.self)
    }
}
