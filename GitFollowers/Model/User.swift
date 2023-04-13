import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatarURL: String
    let name: String
    let location: String?
    let bio: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let createdAt: String
}
