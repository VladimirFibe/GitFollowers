import Foundation

struct Follower: Codable {
    let login: String
    let avatarUrl: String
    
    let id: Int
    let nodeId: String
    let gravatarId: String
    let url, htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
}
