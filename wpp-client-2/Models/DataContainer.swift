import Foundation


enum DTO: Codable {
    case message
    case verifyMessages
}

struct DataContainer: Codable {
    let contentType: DTO
    let content: Data

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
