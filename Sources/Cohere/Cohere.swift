import Foundation

///https://github.com/Moddingus/Cohere <-- information
public class CohereClient {
    private let API_KEY : String
    private let headers : [String : String]
    
    private var chatHistory : [ChatHistory] = []
    
    public func clearChatHistory() {
        chatHistory.removeAll()
    }
    
    ///Do not include "Bearer " as part of the key
    public required init(API_KEY: String) {
        self.API_KEY = API_KEY
        headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(API_KEY)"
        ]
    }
    public func classify(model : CohereModel = .command, inputs: [String], examples : [Example]) async -> Classification? {
        var _examples : [[String : Any]] = []
        for i in examples {
            _examples.append(
                i.dict()
            )
        }
        let parameters = [
            "truncate": "END",
            "inputs": inputs,
            "examples": _examples
        ] as [String : Any]
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/classify")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Classification.self)
        } catch {
            print(error)
            return nil
        }
    }
    public func generate(prompt : String, model : CohereModel = .command, generations : Int = 1, stream : Bool = false) async -> Generation? {
        let parameters = [
            "truncate": "END",
            "return_likelihoods": "NONE",
            "prompt": prompt,
            "num_generations": generations,
            "stream": stream,
            "model": model.rawValue
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/generate")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Generation.self)
        } catch {
            print(error)
            return nil
        }
    }
    public func embed(texts : [String], model : EmbedModel = .englishV2, inputType : InputType = .classificatinon) async -> Embedding? {
        
        let parameters = [
            "texts": texts,
            "truncate": "END",
            "model": model.rawValue,
            "input_type": inputType.rawValue
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/embed")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Embedding.self)
        } catch {
            print(error)
            return nil
        }
    }
    public func summarize(text: String, length : Length = .medium, format : Format = .auto, temperature: Double = 0.3, extractiveness : Extractiveness = .auto, model : CohereModel = .command) async -> Summarize? {
        let parameters = [
            "length": length.rawValue,
            "format": format.rawValue,
            "extractiveness": extractiveness.rawValue,
            "temperature": temperature,
            "text": text
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/summarize")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Summarize.self)
        } catch {
            print(error)
            return nil
        }
    }
    public func chat(message: String, model : CohereModel = .command, overridePreable : String = "", stream : Bool = false) async -> Chat? {
        let parameters = [
            "message": "Hello",
            "model": model.rawValue,
            "stream": stream,
            "preamble_override": "",
            "chat_history": chatHistory.map {$0.dict()},
            "conversation_id": "",
            "prompt_truncation": "OFF",
            "connectors": [
                [
                  "options": ["site": ""],
                  "id": ""
                ] as [String : Any]
              ],
              "search_queries_only": false,
              "documents": [
                [
                  "id": "",
                  "bruh": ""
                ]
              ],
              "citation_quality": "fast",
              "temperature": 0
        ] as [String : Any]
        chatHistory.append(
            ChatHistory(role: .User, message: message, username: "")
        )
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return nil}
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/chat")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Chat.self)
        }
        catch {
            print(error)
            return nil
        }
    }
    public func rerank(query : String, documents : [String], model : RerankModel = .english, topN : Int, maxChunks : Int = 10, returnDocuments : Bool = true) async -> Rerank? {
        let parameters = [
            "return_documents": false,
            "max_chunks_per_doc": maxChunks,
            "model": model.rawValue,
            "query": query,
            "documents": documents,
            "top_n": topN,
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return nil}
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/rerank")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        do {
            return try await MakeURLRequest(request: request, jsonDecoder: Rerank.self)
        }
        catch {
            print(error)
            return nil
        }
    }
}
private func MakeURLRequest<T : Codable>(request : NSMutableURLRequest, jsonDecoder : T.Type) async throws -> T? {
    let session = URLSession.shared
    if #available(macOS 12.0, *), #available(iOS 15.0, *) {
        let (data, response) = try await session.data(for: request as URLRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return nil
        }
        return try JSONDecoder().decode(jsonDecoder.self, from: data)
    } else {
        return nil
    }
}
private func ParseResult<T : Codable>(data: Data, jsonDecoder: T.Type) -> T? {
    do {
        let newData = try JSONDecoder().decode(T.self, from: data)
        return newData
    } catch {
        print(error)
    }
    return nil
}
