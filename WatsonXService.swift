import Foundation

final class WatsonXService {
    static let shared = WatsonXService()

    private let apiKey = "4H8esCF3iJcTlhh6NYgmesYllmCa0ukhTKq94wi-P2Te"

    private let projectID = "96072fe6-0602-4b76-b56e-5934110795df"

    private let regionURL = "https://us-south.ml.cloud.ibm.com"

    private let modelID = "ibm/granite-13b-instruct-v2"

    private init() {}

    func generate(prompt: String) async throws -> String {

        let token = try await getAccessToken()

        let url = URL(
            string:
            "\(regionURL)/ml/v1/text/generation?version=2023-05-29"
        )!

        let body: [String: Any] = [
            "input": prompt,
            "model_id": modelID,
            "project_id": projectID,
            "parameters": [
                "decoding_method": "greedy",
                "max_new_tokens": 200,
                "temperature": 0.5
            ]
        ]

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.httpBody = try JSONSerialization.data(
            withJSONObject: body
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {

            print("STATUS:", httpResponse.statusCode)

            if httpResponse.statusCode != 200 {

                let errorString = String(
                    data: data,
                    encoding: .utf8
                ) ?? "Unknown IBM error"

                return errorString
            }
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        if let results = json?["results"] as? [[String: Any]],
           let first = results.first,
           let text = first["generated_text"] as? String {

            return text
        }

        return "No AI response generated."
    }

    private func getAccessToken() async throws -> String {

        let url = URL(
            string: "https://iam.cloud.ibm.com/identity/token"
        )!

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )

        let body =
        "grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=\(apiKey)"

        request.httpBody = body.data(using: .utf8)

        let (data, _) = try await URLSession.shared.data(for: request)

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        guard let token = json?["access_token"] as? String else {
            throw NSError(
                domain: "IBMTokenError",
                code: 401,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Failed to retrieve IBM token."
                ]
            )
        }

        return token
    }
}
