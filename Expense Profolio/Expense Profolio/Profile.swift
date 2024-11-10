//
//  Profile.swift
//  Expense Profolio
//
//  Created by Wenqi Zheng on 11/9/24.
//

import JWTDecode

struct Profile{
    let id: String
    let name: String
    let email: String
    let verifiedEmail: String
    let picture: String
    let updatedAt: String
}

extension Profile{
    static var empty: Self{
        return Profile(
            id: "",
            name: "",
            email: "",
            verifiedEmail: "",
            picture: "",
            updatedAt: ""
            
        )
    }
    
    static func from(_ idToken: String) -> Self{
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let verifiedEmail = jwt.claim(name: "email_verified").boolean,
            let picture = jwt.claim(name: "picture").string,
            let updatedAt = jwt.claim(name: "updated_at").string
        else{
            return .empty
        }
        return Profile(
            id: id,
            name: name,
            email: email,
            verifiedEmail: String(describing: verifiedEmail),
            picture: picture,
            updatedAt: updatedAt
        )
        
    }
}
