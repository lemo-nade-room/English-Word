import Vapor
import Fluent

extension Question {
    
    /** このメソッドは事前にignoresとuserをloadしておく必要がある */
    func isIgnore(for user: User) throws -> Bool {
        let userId = try user.requireID()
        let ignore = ignores.filter { ignore in
            ignore.user.id == userId
        }
            .max { $0.createdAt! < $1.createdAt! }
        return ignore?.value ?? false
    }
    
}
