import Foundation

struct User: Codable {
    let id: Int
    let login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let createdAt: String
}

extension User {
    static let sample = User(
        id: 2296,
        login: "cheeaun",
        avatarUrl: "https://avatars.githubusercontent.com/u/2296?v=4",
        publicRepos: 234,
        publicGists: 138,
        followers: 1569,
        following: 969,
        htmlUrl: "https://github.com/cheeaun",
        createdAt: "2008-03-05T17:58:29Z"
    )
}
