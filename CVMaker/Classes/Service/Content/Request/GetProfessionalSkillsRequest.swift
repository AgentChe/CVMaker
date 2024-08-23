//
//  GetProfessionalSkillsRequest.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 23.08.2024.
//

import Alamofire

struct GetProfessionalSkillsRequest: APIRequestBody {
    let search: String
    
    var url: String {
        "https://api.promptapi.com/skills?q=\(search)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        [
            "apikey": GlobalDefinitions.apilayerApiKey
        ]
    }
}
