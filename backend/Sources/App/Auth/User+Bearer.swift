import Vapor

fileprivate var tokens = [String: (user: User, last: Date)]()

/** 20分 */
fileprivate let TOKEN_LIMIT: TimeInterval = 20 * 60

fileprivate func clean() {
    for (token, value) in tokens {
        if Date().timeIntervalSince(value.last) > TOKEN_LIMIT {
            tokens[token] = nil
        }
    }
}

extension User: Authenticatable {
    struct Authenticator: AsyncBearerAuthenticator {
    
        typealias User = App.User
        
        func authenticate(
            bearer: BearerAuthorization,
            for request: Request
        ) async throws {
            clean()
            guard let value = tokens[bearer.token] else { return }
            tokens[bearer.token]!.last = Date()
            request.auth.login(value.user)
        }
        
    }
    
    func verifyUser() -> String {
        let token = UUID().uuidString
        tokens[token] = (user: self, last: Date())
        return token
    }
    
}
