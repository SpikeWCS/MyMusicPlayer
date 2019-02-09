//
//  DetailMusic.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/8.
//  Copyright © 2019 王春杉. All rights reserved.
//


import Foundation
import Alamofire
struct DetailMusicId {
    static var id = 2651879387
}


struct DetailMusicHelper {
    static func getMusicList(success: @escaping (DetailMusic)->(), failure: @escaping (Error)->()) {
        var MusicListUrl = "http://localhost:3000/playlist/detail?id=\(DetailMusicId.id)"
        Helper.dataManager(url: MusicListUrl, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let musicList = try? DetailMusic(data: data) {
                success(musicList)
                print("ifif")
            }else {
                print("else")
            }
        }, failure: { _ in
            
        })
    }
}


struct DetailMusic: Codable {
    let playlist: DetailPlaylist
    let code: Int
    let privileges: [Privilege]
}

struct DetailPlaylist: Codable {
    let subscribers: [DetailCreator]
    let subscribed: Bool
    let creator: DetailCreator
    let tracks: [Track]
    let trackIDS: [TrackID]
    let subscribedCount, cloudTrackCount: Int
    let newImported: Bool
    let privacy, createTime: Int
    let highQuality: Bool
    let userID, updateTime: Int
    let coverImgID: Double
    let specialType, trackCount: Int
    let commentThreadID: String
    let trackUpdateTime, playCount: Int
    let coverImgURL: String
    let adType, trackNumberUpdateTime: Int
    let ordered: Bool
    let tags: [String]
    let description: String
    let status: Int
    let name: String
    let id, shareCount: Int
    let coverImgIDStr: String
    let commentCount: Int
    
    enum CodingKeys: String, CodingKey {
        case subscribers, subscribed, creator, tracks
        case trackIDS = "trackIds"
        case subscribedCount, cloudTrackCount, newImported, privacy, createTime, highQuality
        case userID = "userId"
        case updateTime
        case coverImgID = "coverImgId"
        case specialType, trackCount
        case commentThreadID = "commentThreadId"
        case trackUpdateTime, playCount
        case coverImgURL = "coverImgUrl"
        case adType, trackNumberUpdateTime, ordered, tags, description, status, name, id, shareCount
        case coverImgIDStr = "coverImgId_str"
        case commentCount
    }
}

struct DetailCreator: Codable {
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
    let expertTags, experts: JSONNull?
    let djStatus, vipType: Int
    let remarkName: JSONNull?
    let avatarImgIDStr, backgroundImgIDStr, creatorAvatarImgIDStr: String
    
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
        case avatarImgIDStr = "avatarImgIdStr"
        case backgroundImgIDStr = "backgroundImgIdStr"
        case creatorAvatarImgIDStr = "avatarImgId_str"
    }
}

struct TrackID: Codable {
    let id, v: Int
}

struct Track: Codable {
    let name: String
    let id, pst, t: Int
    let ar: [Ar]
    let alia: [String]
    let pop, st: Int
    let rt: String?
    let fee, v: Int
    let crbt: String?
    let cf: String
    let al: Al
    let dt: Int
    let h, m, l: H?
    let a: JSONNull?
    let cd: String
    let no: Int
    let rtURL: JSONNull?
    let ftype: Int
    let rtUrls: [JSONAny]
    let djID, copyright, sID, mv: Int
    let mst, cp: Int
    let rurl: JSONNull?
    let rtype, publishTime: Int
    let tns: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, id, pst, t, ar, alia, pop, st, rt, fee, v, crbt, cf, al, dt, h, m, l, a, cd, no
        case rtURL = "rtUrl"
        case ftype, rtUrls
        case djID = "djId"
        case copyright
        case sID = "s_id"
        case mv, mst, cp, rurl, rtype, publishTime, tns
    }
}

struct Al: Codable {
    let id: Int
    let name: String?
    let picURL: String?
    let tns: [String]
    let picStr: String?
    let pic: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case picURL = "picUrl"
        case tns
        case picStr = "pic_str"
        case pic
    }
}

struct Ar: Codable {
    let id: Int
    let name: String
    let tns, alias: [JSONAny]
}

struct H: Codable {
    let br, fid, size: Int
    let vd: Double
}

struct Privilege: Codable {
    let id, fee, payed, st: Int
    let pl, dl, sp, cp: Int
    let subp: Int
    let cs: Bool
    let maxbr, fl: Int
    let toast: Bool
    let flag: Int
    let preSell: Bool
}

// MARK: Convenience initializers and mutators

extension DetailMusic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DetailMusic.self, from: data)
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
        playlist: DetailPlaylist? = nil,
        code: Int? = nil,
        privileges: [Privilege]? = nil
        ) -> DetailMusic {
        return DetailMusic(
            playlist: playlist ?? self.playlist,
            code: code ?? self.code,
            privileges: privileges ?? self.privileges
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension DetailPlaylist {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DetailPlaylist.self, from: data)
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
        subscribers: [DetailCreator]? = nil,
        subscribed: Bool? = nil,
        creator: DetailCreator? = nil,
        tracks: [Track]? = nil,
        trackIDS: [TrackID]? = nil,
        subscribedCount: Int? = nil,
        cloudTrackCount: Int? = nil,
        newImported: Bool? = nil,
        privacy: Int? = nil,
        createTime: Int? = nil,
        highQuality: Bool? = nil,
        userID: Int? = nil,
        updateTime: Int? = nil,
        coverImgID: Double? = nil,
        specialType: Int? = nil,
        trackCount: Int? = nil,
        commentThreadID: String? = nil,
        trackUpdateTime: Int? = nil,
        playCount: Int? = nil,
        coverImgURL: String? = nil,
        adType: Int? = nil,
        trackNumberUpdateTime: Int? = nil,
        ordered: Bool? = nil,
        tags: [String]? = nil,
        description: String? = nil,
        status: Int? = nil,
        name: String? = nil,
        id: Int? = nil,
        shareCount: Int? = nil,
        coverImgIDStr: String? = nil,
        commentCount: Int? = nil
        ) -> DetailPlaylist {
        return DetailPlaylist(
            subscribers: subscribers ?? self.subscribers,
            subscribed: subscribed ?? self.subscribed,
            creator: creator ?? self.creator,
            tracks: tracks ?? self.tracks,
            trackIDS: trackIDS ?? self.trackIDS,
            subscribedCount: subscribedCount ?? self.subscribedCount,
            cloudTrackCount: cloudTrackCount ?? self.cloudTrackCount,
            newImported: newImported ?? self.newImported,
            privacy: privacy ?? self.privacy,
            createTime: createTime ?? self.createTime,
            highQuality: highQuality ?? self.highQuality,
            userID: userID ?? self.userID,
            updateTime: updateTime ?? self.updateTime,
            coverImgID: coverImgID ?? self.coverImgID,
            specialType: specialType ?? self.specialType,
            trackCount: trackCount ?? self.trackCount,
            commentThreadID: commentThreadID ?? self.commentThreadID,
            trackUpdateTime: trackUpdateTime ?? self.trackUpdateTime,
            playCount: playCount ?? self.playCount,
            coverImgURL: coverImgURL ?? self.coverImgURL,
            adType: adType ?? self.adType,
            trackNumberUpdateTime: trackNumberUpdateTime ?? self.trackNumberUpdateTime,
            ordered: ordered ?? self.ordered,
            tags: tags ?? self.tags,
            description: description ?? self.description,
            status: status ?? self.status,
            name: name ?? self.name,
            id: id ?? self.id,
            shareCount: shareCount ?? self.shareCount,
            coverImgIDStr: coverImgIDStr ?? self.coverImgIDStr,
            commentCount: commentCount ?? self.commentCount
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension DetailCreator {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DetailCreator.self, from: data)
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
        expertTags: JSONNull?? = nil,
        experts: JSONNull?? = nil,
        djStatus: Int? = nil,
        vipType: Int? = nil,
        remarkName: JSONNull?? = nil,
        avatarImgIDStr: String? = nil,
        backgroundImgIDStr: String? = nil,
        creatorAvatarImgIDStr: String? = nil
        ) -> DetailCreator {
        return DetailCreator(
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
            avatarImgIDStr: avatarImgIDStr ?? self.avatarImgIDStr,
            backgroundImgIDStr: backgroundImgIDStr ?? self.backgroundImgIDStr,
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

extension TrackID {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TrackID.self, from: data)
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
        v: Int? = nil
        ) -> TrackID {
        return TrackID(
            id: id ?? self.id,
            v: v ?? self.v
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Track {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Track.self, from: data)
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
        name: String? = nil,
        id: Int? = nil,
        pst: Int? = nil,
        t: Int? = nil,
        ar: [Ar]? = nil,
        alia: [String]? = nil,
        pop: Int? = nil,
        st: Int? = nil,
        rt: String?? = nil,
        fee: Int? = nil,
        v: Int? = nil,
        crbt: String?? = nil,
        cf: String? = nil,
        al: Al? = nil,
        dt: Int? = nil,
        h: H?? = nil,
        m: H?? = nil,
        l: H?? = nil,
        a: JSONNull?? = nil,
        cd: String? = nil,
        no: Int? = nil,
        rtURL: JSONNull?? = nil,
        ftype: Int? = nil,
        rtUrls: [JSONAny]? = nil,
        djID: Int? = nil,
        copyright: Int? = nil,
        sID: Int? = nil,
        mv: Int? = nil,
        mst: Int? = nil,
        cp: Int? = nil,
        rurl: JSONNull?? = nil,
        rtype: Int? = nil,
        publishTime: Int? = nil,
        tns: [String]?? = nil
        ) -> Track {
        return Track(
            name: name ?? self.name,
            id: id ?? self.id,
            pst: pst ?? self.pst,
            t: t ?? self.t,
            ar: ar ?? self.ar,
            alia: alia ?? self.alia,
            pop: pop ?? self.pop,
            st: st ?? self.st,
            rt: rt ?? self.rt,
            fee: fee ?? self.fee,
            v: v ?? self.v,
            crbt: crbt ?? self.crbt,
            cf: cf ?? self.cf,
            al: al ?? self.al,
            dt: dt ?? self.dt,
            h: h ?? self.h,
            m: m ?? self.m,
            l: l ?? self.l,
            a: a ?? self.a,
            cd: cd ?? self.cd,
            no: no ?? self.no,
            rtURL: rtURL ?? self.rtURL,
            ftype: ftype ?? self.ftype,
            rtUrls: rtUrls ?? self.rtUrls,
            djID: djID ?? self.djID,
            copyright: copyright ?? self.copyright,
            sID: sID ?? self.sID,
            mv: mv ?? self.mv,
            mst: mst ?? self.mst,
            cp: cp ?? self.cp,
            rurl: rurl ?? self.rurl,
            rtype: rtype ?? self.rtype,
            publishTime: publishTime ?? self.publishTime,
            tns: tns ?? self.tns
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Al {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Al.self, from: data)
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
        name: String?? = nil,
        picURL: String?? = nil,
        tns: [String]? = nil,
        picStr: String?? = nil,
        pic: Double? = nil
        ) -> Al {
        return Al(
            id: id ?? self.id,
            name: name ?? self.name,
            picURL: picURL ?? self.picURL,
            tns: tns ?? self.tns,
            picStr: picStr ?? self.picStr,
            pic: pic ?? self.pic
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Ar {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ar.self, from: data)
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
        name: String? = nil,
        tns: [JSONAny]? = nil,
        alias: [JSONAny]? = nil
        ) -> Ar {
        return Ar(
            id: id ?? self.id,
            name: name ?? self.name,
            tns: tns ?? self.tns,
            alias: alias ?? self.alias
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension H {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(H.self, from: data)
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
        br: Int? = nil,
        fid: Int? = nil,
        size: Int? = nil,
        vd: Double? = nil
        ) -> H {
        return H(
            br: br ?? self.br,
            fid: fid ?? self.fid,
            size: size ?? self.size,
            vd: vd ?? self.vd
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Privilege {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Privilege.self, from: data)
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
        fee: Int? = nil,
        payed: Int? = nil,
        st: Int? = nil,
        pl: Int? = nil,
        dl: Int? = nil,
        sp: Int? = nil,
        cp: Int? = nil,
        subp: Int? = nil,
        cs: Bool? = nil,
        maxbr: Int? = nil,
        fl: Int? = nil,
        toast: Bool? = nil,
        flag: Int? = nil,
        preSell: Bool? = nil
        ) -> Privilege {
        return Privilege(
            id: id ?? self.id,
            fee: fee ?? self.fee,
            payed: payed ?? self.payed,
            st: st ?? self.st,
            pl: pl ?? self.pl,
            dl: dl ?? self.dl,
            sp: sp ?? self.sp,
            cp: cp ?? self.cp,
            subp: subp ?? self.subp,
            cs: cs ?? self.cs,
            maxbr: maxbr ?? self.maxbr,
            fl: fl ?? self.fl,
            toast: toast ?? self.toast,
            flag: flag ?? self.flag,
            preSell: preSell ?? self.preSell
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
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
