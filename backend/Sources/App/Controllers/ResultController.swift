import Vapor
import Fluent

struct ResultController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let result = routes.grouped("result")
        result.get(use: index)
    }
    
    func index(req: Request) async throws -> [StudyResult] {
        let user = try req.user()
        let studies = try await Study.query(on: req.db)
            .filter(\.$user.$id == (try user.requireID()))
            .with(\.$questions) { $0.with(\.$answer) }
            .with(\.$book) { $0.with(\.$questions) }
            .sort(\.$createdAt, .descending)
            .all()
        guard !studies.isEmpty else {
            throw Abort(.badRequest, reason: "学習済みのものがありません")
        }
        return studies.map { study in
            StudyResult(
                score: study.score,
                mode: study.mode == .lap ? "一周" : "無限",
                when: study.when
            )
        }
    }
}
