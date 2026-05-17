import Foundation

final class GeminiService {
    static let shared = GeminiService()

    private let apiKey = Secrets.geminiAPIKey
    private let modelID = "gemini-1.5-flash"

    private init() {}

    func generate(prompt: String) async throws -> String {
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/\(modelID):generateContent?key=\(apiKey)"
        let url = URL(string: urlString)!

        let body: [String: Any] = [
            "contents": [["parts": [["text": prompt]]]],
            "generationConfig": ["maxOutputTokens": 300, "temperature": 0.5]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            let errorString = String(data: data, encoding: .utf8) ?? "Unknown Gemini error"
            throw NSError(domain: "GeminiError", code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: errorString])
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        if let candidates = json?["candidates"] as? [[String: Any]],
           let first = candidates.first,
           let content = first["content"] as? [String: Any],
           let parts = content["parts"] as? [[String: Any]],
           let text = parts.first?["text"] as? String {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return "No AI response generated."
    }
}
