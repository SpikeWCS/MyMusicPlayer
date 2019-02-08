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
    static var id = 0
}
struct DetailMusicHelper {
    static func getDetailMusic(success: @escaping (DetailMusic)->(), failure: @escaping (Error)->()) {
        var detailMusicUrl = "http://localhost:3000/playlist/detail?id=\(DetailMusicId.id)"
        Helper.dataManager(url: detailMusicUrl, success: { dic in
            if let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0)), let detaileMusic = try? DetailMusic(data: data) {
                success(detaileMusic)
            }
        }, failure: { _ in
            
        })
    }
}

struct DetailMusic: Codable {
    let playlist: Playlist
    let code: Int
    let privileges: [Privilege]
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
        playlist: Playlist? = nil,
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
