//
//  VideoDetail.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on September 07, 2022
//
import Foundation
import SwiftyJSON

struct VideoDetail {

	let iframe: String?
	let m3u8: String?
	let snapshot: String?
	let sort: Int?
	let status: String?
	let url: String?
	let flv: String?

	init(_ json: JSON) {
		iframe = json["iframe"].stringValue
		m3u8 = json["m3u8"].stringValue
		snapshot = json["snapshot"].stringValue
		sort = json["sort"].intValue
		status = json["status"].stringValue
		url = json["url"].stringValue
		flv = json["flv"].stringValue
	}

}