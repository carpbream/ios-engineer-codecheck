//
//  GitRepo.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GithubRepo: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]
}

struct Item: Codable {
    // Required
    let archive_url: String
    let assignees_url: String
    let blobs_url: String
    let branches_url: String
    let collaborators_url: String
    let comments_url: String
    let commits_url: String
    let compare_url: String
    let contents_url: String
    let contributors_url: String
    let deployments_url: String
    let description: String?
    let downloads_url: String
    let events_url: String
    let fork: Bool
    let forks_url: String
    let full_name: String
    let git_commits_url: String
    let git_refs_url: String
    let git_tags_url: String
    let hooks_url: String
    let html_url: String
    let id: Int
    let node_id: String
    let issue_comment_url: String
    let issue_events_url: String
    let issues_url: String
    let keys_url: String
    let labels_url: String
    let languages_url: String
    let merges_url: String
    let milestones_url: String
    let name: String
    let notifications_url: String
    let owner: Owner?
    let `private`: Bool
    let pulls_url: String
    let releases_url: String
    let stargazers_url: String
    let statuses_url: String
    let subscribers_url: String
    let subscription_url: String
    let tags_url: String
    let teams_url: String
    let trees_url: String
    let url: String
    let clone_url: String
    let default_branch: String
    let forks: Int
    let forks_count: Int
    let git_url: String
    let has_downloads: Bool
    let has_issues: Bool
    let has_projects: Bool
    let has_wiki: Bool
    let has_pages: Bool
    let homepage: String?
    let language: String?
    let archived: Bool
    let disabled: Bool
    let mirror_url: String?
    let open_issues: Int
    let open_issues_count: Int
    let license: License?
    let pushed_at: Date
    let size: Int
    let ssh_url: String
    let stargazers_count: Int
    let svn_url: String
    let watchers: Int
    let watchers_count: Int
    let created_at: Date
    let updated_at: Date
    let score: Double

    // Option
    let master_branch: String?
    let topics: [String]?
    let visibility: String?
    let permissions: Permissions?
    let text_matchs: [TextMatch]?
    let temp_clone_token: String?
    let allow_merge_commit: Bool?
    let allow_squash_merge: Bool?
    let allow_rebase_merge: Bool?
    let allow_auto_merge: Bool?
    let delete_branch_on_merge: Bool?
    let allow_forking: Bool?
    let is_template: Bool?
    let web_commit_signoff_required: Bool?
}

struct Owner: Codable {
    // Required
    let avatar_url: String
    let events_url: String
    let received_events_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let gravatar_id: String?
    let html_url: String
    let id: Int
    let node_id: String
    let login: String
    let organizations_url: String
    let repos_url: String
    let site_admin: Bool
    let starred_url: String
    let subscriptions_url: String
    let type: String
    let url: String

    // Option
    let name: String?
    let email: String?
    let starred_at: Date?
}

struct License: Codable {
    // Required
    let key: String
    let name: String
    let url: String?
    let spdx_id: String?
    let node_id: String

    // Option
    let html_url: String?
}

struct Permissions: Codable {
    // Required
    let admin: Bool
    let pull: Bool
    let push: Bool

    // Option
    let maintain: Bool?
    let triage: Bool?
}

struct TextMatch: Codable {
    // Option
    let object_url: String?
    let object_type: String?
    let property: String?
    let fragment: String?
    let matches: [Match]?

    struct Match: Codable {
        let text: String?
        let indices: [Int]?
    }
}
