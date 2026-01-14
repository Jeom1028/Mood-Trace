import Foundation

final class HomeViewModel {

    var records: [Record] = []

    func loadMock() {
        records = [
            Record(
                id: UUID(),
                date: Date(),
                amount: 4500,
                category: .coffee,
                reason: "피곤해서 그냥 습관처럼",
                mood: .neutral
            ),
            Record(
                id: UUID(),
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                amount: 12900,
                category: .meal,
                reason: "스트레스 받아서 배달",
                mood: .stressed
            )
        ]
    }
}
