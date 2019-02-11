//
//  Login.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/4.
//  Copyright © 2019 王春杉. All rights reserved.
//

import Foundation
import Alamofire

struct LoginInfoByPhone {
    static var phoneNum: String = ""
    static var password: String = ""
    static var userId: Int = 0
}
struct Helper {
    static func dataManager(url: String, success: (([String: Any])->())? = nil, failure: ((Error)->())? = nil) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value  {
                    if let dict = data as? [String: Any] {
                        success?(dict)
                    }
                }
            case .failure(let error):
                failure?(error)
                if let data = response.result.value  {
                    if let dict = data as? [String: Any],
                        let errmsg = dict["message"] as? String {
                        print(errmsg)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}

struct LoginHelper {
    static func loginByPhone(success: @escaping (Login)->(), failure: @escaping (Error)->()) {
        var loginByPhoneUrl = "http://localhost:3000/login/cellphone?phone=\(LoginInfoByPhone.phoneNum)&password=\(LoginInfoByPhone.password)"
        Helper.dataManager(url: loginByPhoneUrl, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let login = try? Login(data: data) {
                success(login)
            }
        }, failure: { _ in
            
        })
    }
}
struct Login: Codable {
    let loginType, code: Int
    let account: Account
    let profile: Profile
    let bindings: [Binding]
}

struct Account: Codable {
    let id: Int
    let userName: String
    let type, status, whitelistAuthority, createTime: Int
    let salt: String
    let tokenVersion, ban, baoyueVersion, donateVersion: Int
    let vipType, viptypeVersion: Int
    let anonimousUser: Bool
}

struct Binding: Codable {
    let expired: Bool
    let refreshTime, expiresIn: Int
    let tokenJSONStr, url: String
    let userID, id, type: Int
    
    enum CodingKeys: String, CodingKey {
        case expired, refreshTime, expiresIn
        case tokenJSONStr = "tokenJsonStr"
        case url
        case userID = "userId"
        case id, type
    }
}

struct Profile: Codable {
    let detailDescription: String
    let followed: Bool
    let avatarImgIDStr, backgroundImgIDStr, description: String
    let backgroundURL: String
    let vipType, gender, accountStatus: Int
    let avatarImgID: Double
    let birthday: Int
    let nickname: String
    let city, province: Int
    let defaultAvatar: Bool
    let avatarURL: String
    let experts: Experts
    let djStatus: Int
    let backgroundImgID: Double
    let userType: Int
    let mutual: Bool
    let remarkName, expertTags: JSONNull?
    let authStatus, userID: Int
    let signature: String
    let authority: Int
    let profileAvatarImgIDStr: String
    let followeds, follows, eventCount, playlistCount: Int
    let playlistBeSubscribedCount: Int
    
    enum CodingKeys: String, CodingKey {
        case detailDescription, followed
        case avatarImgIDStr = "avatarImgIdStr"
        case backgroundImgIDStr = "backgroundImgIdStr"
        case description
        case backgroundURL = "backgroundUrl"
        case vipType, gender, accountStatus
        case avatarImgID = "avatarImgId"
        case birthday, nickname, city, province, defaultAvatar
        case avatarURL = "avatarUrl"
        case experts, djStatus
        case backgroundImgID = "backgroundImgId"
        case userType, mutual, remarkName, expertTags, authStatus
        case userID = "userId"
        case signature, authority
        case profileAvatarImgIDStr = "avatarImgId_str"
        case followeds, follows, eventCount, playlistCount, playlistBeSubscribedCount
    }
}

struct Experts: Codable {
}

// MARK: Convenience initializers and mutators

extension Login {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Login.self, from: data)
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
        loginType: Int? = nil,
        code: Int? = nil,
        account: Account? = nil,
        profile: Profile? = nil,
        bindings: [Binding]? = nil
        ) -> Login {
        return Login(
            loginType: loginType ?? self.loginType,
            code: code ?? self.code,
            account: account ?? self.account,
            profile: profile ?? self.profile,
            bindings: bindings ?? self.bindings
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Account {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Account.self, from: data)
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
        id: Int? = nil,
        userName: String? = nil,
        type: Int? = nil,
        status: Int? = nil,
        whitelistAuthority: Int? = nil,
        createTime: Int? = nil,
        salt: String? = nil,
        tokenVersion: Int? = nil,
        ban: Int? = nil,
        baoyueVersion: Int? = nil,
        donateVersion: Int? = nil,
        vipType: Int? = nil,
        viptypeVersion: Int? = nil,
        anonimousUser: Bool? = nil
        ) -> Account {
        return Account(
            id: id ?? self.id,
            userName: userName ?? self.userName,
            type: type ?? self.type,
            status: status ?? self.status,
            whitelistAuthority: whitelistAuthority ?? self.whitelistAuthority,
            createTime: createTime ?? self.createTime,
            salt: salt ?? self.salt,
            tokenVersion: tokenVersion ?? self.tokenVersion,
            ban: ban ?? self.ban,
            baoyueVersion: baoyueVersion ?? self.baoyueVersion,
            donateVersion: donateVersion ?? self.donateVersion,
            vipType: vipType ?? self.vipType,
            viptypeVersion: viptypeVersion ?? self.viptypeVersion,
            anonimousUser: anonimousUser ?? self.anonimousUser
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Binding {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Binding.self, from: data)
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
        expired: Bool? = nil,
        refreshTime: Int? = nil,
        expiresIn: Int? = nil,
        tokenJSONStr: String? = nil,
        url: String? = nil,
        userID: Int? = nil,
        id: Int? = nil,
        type: Int? = nil
        ) -> Binding {
        return Binding(
            expired: expired ?? self.expired,
            refreshTime: refreshTime ?? self.refreshTime,
            expiresIn: expiresIn ?? self.expiresIn,
            tokenJSONStr: tokenJSONStr ?? self.tokenJSONStr,
            url: url ?? self.url,
            userID: userID ?? self.userID,
            id: id ?? self.id,
            type: type ?? self.type
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Profile {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Profile.self, from: data)
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
        detailDescription: String? = nil,
        followed: Bool? = nil,
        avatarImgIDStr: String? = nil,
        backgroundImgIDStr: String? = nil,
        description: String? = nil,
        backgroundURL: String? = nil,
        vipType: Int? = nil,
        gender: Int? = nil,
        accountStatus: Int? = nil,
        avatarImgID: Double? = nil,
        birthday: Int? = nil,
        nickname: String? = nil,
        city: Int? = nil,
        province: Int? = nil,
        defaultAvatar: Bool? = nil,
        avatarURL: String? = nil,
        experts: Experts? = nil,
        djStatus: Int? = nil,
        backgroundImgID: Double? = nil,
        userType: Int? = nil,
        mutual: Bool? = nil,
        remarkName: JSONNull?? = nil,
        expertTags: JSONNull?? = nil,
        authStatus: Int? = nil,
        userID: Int? = nil,
        signature: String? = nil,
        authority: Int? = nil,
        profileAvatarImgIDStr: String? = nil,
        followeds: Int? = nil,
        follows: Int? = nil,
        eventCount: Int? = nil,
        playlistCount: Int? = nil,
        playlistBeSubscribedCount: Int? = nil
        ) -> Profile {
        return Profile(
            detailDescription: detailDescription ?? self.detailDescription,
            followed: followed ?? self.followed,
            avatarImgIDStr: avatarImgIDStr ?? self.avatarImgIDStr,
            backgroundImgIDStr: backgroundImgIDStr ?? self.backgroundImgIDStr,
            description: description ?? self.description,
            backgroundURL: backgroundURL ?? self.backgroundURL,
            vipType: vipType ?? self.vipType,
            gender: gender ?? self.gender,
            accountStatus: accountStatus ?? self.accountStatus,
            avatarImgID: avatarImgID ?? self.avatarImgID,
            birthday: birthday ?? self.birthday,
            nickname: nickname ?? self.nickname,
            city: city ?? self.city,
            province: province ?? self.province,
            defaultAvatar: defaultAvatar ?? self.defaultAvatar,
            avatarURL: avatarURL ?? self.avatarURL,
            experts: experts ?? self.experts,
            djStatus: djStatus ?? self.djStatus,
            backgroundImgID: backgroundImgID ?? self.backgroundImgID,
            userType: userType ?? self.userType,
            mutual: mutual ?? self.mutual,
            remarkName: remarkName ?? self.remarkName,
            expertTags: expertTags ?? self.expertTags,
            authStatus: authStatus ?? self.authStatus,
            userID: userID ?? self.userID,
            signature: signature ?? self.signature,
            authority: authority ?? self.authority,
            profileAvatarImgIDStr: profileAvatarImgIDStr ?? self.profileAvatarImgIDStr,
            followeds: followeds ?? self.followeds,
            follows: follows ?? self.follows,
            eventCount: eventCount ?? self.eventCount,
            playlistCount: playlistCount ?? self.playlistCount,
            playlistBeSubscribedCount: playlistBeSubscribedCount ?? self.playlistBeSubscribedCount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Experts {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Experts.self, from: data)
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
        ) -> Experts {
        return Experts(
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

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

