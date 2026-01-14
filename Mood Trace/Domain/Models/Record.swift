import Foundation

struct Record: Identifiable, Codable {
    let id: UUID
    let date: Date
    let amount: Int?        
    let category: Category
    let reason: String
    let mood: Mood
}
