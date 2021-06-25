
import Foundation
import FirebaseFirestore
import class Firebase.User
typealias FirebaseUser = Firebase.User


struct User: Codable {
    var fullName: String = ""
    var email: String = ""
    var budget: Budget = Budget()
}

struct Budget: Codable {
    var balance: Int = 0 
    var income: Int = 0
    var expense: Int = 0
}

struct SignInCredentials: Encodable, Decodable {
    var email: String
    var name: String
    var password: String
}
