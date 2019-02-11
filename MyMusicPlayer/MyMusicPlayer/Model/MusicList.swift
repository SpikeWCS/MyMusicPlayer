// To parse the JSON, add this file to your project and do:
//
//   let musicList = try MusicList(json)

import Foundation
import Alamofire

struct MusicListHelper {
    static func getMusicList(success: @escaping (MusicList)->(), failure: @escaping (Error)->()) {
        var MusicListUrl = "http://localhost:3000/user/playlist?uid=\(LoginInfoByPhone.userId)"
        Helper.dataManager(url: MusicListUrl, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let musicList = try? MusicList(data: data) {
                success(musicList)
            }
        }, failure: { _ in

        })
    }
}

struct MusicList: Codable {
    let more: Bool
    let playlist: [Playlist]
    let code: Int
}

struct Playlist: Codable {
    let subscribers: [JSONAny]
    let subscribed: Bool
    let creator: Creator
    let artists, tracks: JSONNull?
    let subscribedCount, cloudTrackCount, createTime: Int
    let highQuality: Bool
    let userID, privacy, updateTime: Int
    let coverImgID: Double
    let specialType, trackCount: Int
    let commentThreadID: String
    let totalDuration, trackUpdateTime: Int
    let newImported, anonimous: Bool
    let coverImgURL: String
    let playCount, adType, trackNumberUpdateTime: Int
    let ordered: Bool
    let tags: [String]
    let description: String?
    let status: Int
    let name: String
    let id: Int
    let coverImgIDStr: String?

    enum CodingKeys: String, CodingKey {
        case subscribers, subscribed, creator, artists, tracks, subscribedCount, cloudTrackCount, createTime, highQuality
        case userID = "userId"
        case privacy, updateTime
        case coverImgID = "coverImgId"
        case specialType, trackCount
        case commentThreadID = "commentThreadId"
        case totalDuration, trackUpdateTime, newImported, anonimous
        case coverImgURL = "coverImgUrl"
        case playCount, adType, trackNumberUpdateTime, ordered, tags, description, status, name, id
        case coverImgIDStr = "coverImgId_str"
    }
}

struct Creator: Codable {
    let defaultAvatar: Bool
    let province, authStatus: Int
    let followed: Bool
    let avatarURL: String
    let accountStatus, gender, city, birthday: Int
    let userID, userType: Int
    let nickname, signature, description, detailDescription: String
    let avatarImgID, backgroundImgID: Double
    let backgroundURL: String
    let authority: Int
    let mutual: Bool
    let expertTags: [String]?
    let experts: JSONNull?
    let djStatus, vipType: Int
    let remarkName: JSONNull?
    let backgroundImgIDStr, avatarImgIDStr: String
    let creatorAvatarImgIDStr: String?

    enum CodingKeys: String, CodingKey {
        case defaultAvatar, province, authStatus, followed
        case avatarURL = "avatarUrl"
        case accountStatus, gender, city, birthday
        case userID = "userId"
        case userType, nickname, signature, description, detailDescription
        case avatarImgID = "avatarImgId"
        case backgroundImgID = "backgroundImgId"
        case backgroundURL = "backgroundUrl"
        case authority, mutual, expertTags, experts, djStatus, vipType, remarkName
        case backgroundImgIDStr = "backgroundImgIdStr"
        case avatarImgIDStr = "avatarImgIdStr"
        case creatorAvatarImgIDStr = "avatarImgId_str"
    }
}

// MARK: Convenience initializers and mutators

extension MusicList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MusicList.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        more: Bool? = nil,
        playlist: [Playlist]? = nil,
        code: Int? = nil
        ) -> MusicList {
        return MusicList(
            more: more ?? self.more,
            playlist: playlist ?? self.playlist,
            code: code ?? self.code
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Playlist {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Playlist.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        subscribers: [JSONAny]? = nil,
        subscribed: Bool? = nil,
        creator: Creator? = nil,
        artists: JSONNull?? = nil,
        tracks: JSONNull?? = nil,
        subscribedCount: Int? = nil,
        cloudTrackCount: Int? = nil,
        createTime: Int? = nil,
        highQuality: Bool? = nil,
        userID: Int? = nil,
        privacy: Int? = nil,
        updateTime: Int? = nil,
        coverImgID: Double? = nil,
        specialType: Int? = nil,
        trackCount: Int? = nil,
        commentThreadID: String? = nil,
        totalDuration: Int? = nil,
        trackUpdateTime: Int? = nil,
        newImported: Bool? = nil,
        anonimous: Bool? = nil,
        coverImgURL: String? = nil,
        playCount: Int? = nil,
        adType: Int? = nil,
        trackNumberUpdateTime: Int? = nil,
        ordered: Bool? = nil,
        tags: [String]? = nil,
        description: String?? = nil,
        status: Int? = nil,
        name: String? = nil,
        id: Int? = nil,
        coverImgIDStr: String?? = nil
        ) -> Playlist {
        return Playlist(
            subscribers: subscribers ?? self.subscribers,
            subscribed: subscribed ?? self.subscribed,
            creator: creator ?? self.creator,
            artists: artists ?? self.artists,
            tracks: tracks ?? self.tracks,
            subscribedCount: subscribedCount ?? self.subscribedCount,
            cloudTrackCount: cloudTrackCount ?? self.cloudTrackCount,
            createTime: createTime ?? self.createTime,
            highQuality: highQuality ?? self.highQuality,
            userID: userID ?? self.userID,
            privacy: privacy ?? self.privacy,
            updateTime: updateTime ?? self.updateTime,
            coverImgID: coverImgID ?? self.coverImgID,
            specialType: specialType ?? self.specialType,
            trackCount: trackCount ?? self.trackCount,
            commentThreadID: commentThreadID ?? self.commentThreadID,
            totalDuration: totalDuration ?? self.totalDuration,
            trackUpdateTime: trackUpdateTime ?? self.trackUpdateTime,
            newImported: newImported ?? self.newImported,
            anonimous: anonimous ?? self.anonimous,
            coverImgURL: coverImgURL ?? self.coverImgURL,
            playCount: playCount ?? self.playCount,
            adType: adType ?? self.adType,
            trackNumberUpdateTime: trackNumberUpdateTime ?? self.trackNumberUpdateTime,
            ordered: ordered ?? self.ordered,
            tags: tags ?? self.tags,
            description: description ?? self.description,
            status: status ?? self.status,
            name: name ?? self.name,
            id: id ?? self.id,
            coverImgIDStr: coverImgIDStr ?? self.coverImgIDStr
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Creator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Creator.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        defaultAvatar: Bool? = nil,
        province: Int? = nil,
        authStatus: Int? = nil,
        followed: Bool? = nil,
        avatarURL: String? = nil,
        accountStatus: Int? = nil,
        gender: Int? = nil,
        city: Int? = nil,
        birthday: Int? = nil,
        userID: Int? = nil,
        userType: Int? = nil,
        nickname: String? = nil,
        signature: String? = nil,
        description: String? = nil,
        detailDescription: String? = nil,
        avatarImgID: Double? = nil,
        backgroundImgID: Double? = nil,
        backgroundURL: String? = nil,
        authority: Int? = nil,
        mutual: Bool? = nil,
        expertTags: [String]?? = nil,
        experts: JSONNull?? = nil,
        djStatus: Int? = nil,
        vipType: Int? = nil,
        remarkName: JSONNull?? = nil,
        backgroundImgIDStr: String? = nil,
        avatarImgIDStr: String? = nil,
        creatorAvatarImgIDStr: String?? = nil
        ) -> Creator {
        return Creator(
            defaultAvatar: defaultAvatar ?? self.defaultAvatar,
            province: province ?? self.province,
            authStatus: authStatus ?? self.authStatus,
            followed: followed ?? self.followed,
            avatarURL: avatarURL ?? self.avatarURL,
            accountStatus: accountStatus ?? self.accountStatus,
            gender: gender ?? self.gender,
            city: city ?? self.city,
            birthday: birthday ?? self.birthday,
            userID: userID ?? self.userID,
            userType: userType ?? self.userType,
            nickname: nickname ?? self.nickname,
            signature: signature ?? self.signature,
            description: description ?? self.description,
            detailDescription: detailDescription ?? self.detailDescription,
            avatarImgID: avatarImgID ?? self.avatarImgID,
            backgroundImgID: backgroundImgID ?? self.backgroundImgID,
            backgroundURL: backgroundURL ?? self.backgroundURL,
            authority: authority ?? self.authority,
            mutual: mutual ?? self.mutual,
            expertTags: expertTags ?? self.expertTags,
            experts: experts ?? self.experts,
            djStatus: djStatus ?? self.djStatus,
            vipType: vipType ?? self.vipType,
            remarkName: remarkName ?? self.remarkName,
            backgroundImgIDStr: backgroundImgIDStr ?? self.backgroundImgIDStr,
            avatarImgIDStr: avatarImgIDStr ?? self.avatarImgIDStr,
            creatorAvatarImgIDStr: creatorAvatarImgIDStr ?? self.creatorAvatarImgIDStr
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

 // MARK: Encode/decode helpers


class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
