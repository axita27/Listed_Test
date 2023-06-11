
//
//  LinkDataModel.swift
//  Listed
//
//  Created by Axita Dholariya on 10/06/23.
//

import Foundation
import OrderedCollections

// MARK: - Welcome
struct LinkData: Codable {
    let status: Bool
    let statusCode: Int
    let message, supportWhatsappNumber: String
    let extraIncome: Double
    let totalLinks, totalClicks, todayClicks: Int
    let topSource, topLocation, startTime: String
    let linksCreatedToday, appliedCampaign: Int
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case status, statusCode, message
        case supportWhatsappNumber = "support_whatsapp_number"
        case extraIncome = "extra_income"
        case totalLinks = "total_links"
        case totalClicks = "total_clicks"
        case todayClicks = "today_clicks"
        case topSource = "top_source"
        case topLocation = "top_location"
        case startTime
        case linksCreatedToday = "links_created_today"
        case appliedCampaign = "applied_campaign"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let recentLinks, topLinks: [Link]
    let overallURLChart: [String: Int]

    enum CodingKeys: String, CodingKey {
        case recentLinks = "recent_links"
        case topLinks = "top_links"
        case overallURLChart = "overall_url_chart"
    }
}

// MARK: - Link
struct Link: Codable {
    let urlID: Int
    let webLink: String
    let smartLink, title: String
    let totalClicks: Int
    let originalImage: String
    let thumbnail: JSONNull?
    let timesAgo, createdAt: String
    let domainID: DomainID
    let urlPrefix: String?
    let urlSuffix, app: String

    enum CodingKeys: String, CodingKey {
        case urlID = "url_id"
        case webLink = "web_link"
        case smartLink = "smart_link"
        case title
        case totalClicks = "total_clicks"
        case originalImage = "original_image"
        case thumbnail
        case timesAgo = "times_ago"
        case createdAt = "created_at"
        case domainID = "domain_id"
        case urlPrefix = "url_prefix"
        case urlSuffix = "url_suffix"
        case app
    }
}

enum DomainID: String, Codable {
    case inopenappCOM = "inopenapp.com/"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

