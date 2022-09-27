import Foundation

protocol BookRemovable {
    func remove(id: UUID) async throws
}

