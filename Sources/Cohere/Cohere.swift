import Foundation

public struct Example {
    let text : String
    let label : Any
    
    init(text: String, label: Any) {
        self.text = text
        self.label = label
    }
    func dict() -> [String : Any] {
        return ["text" : self.text, "label" : self.label]
    }
}

public class CohereClient {
    private let API_KEY : String
    private let headers : [String : String]
    
    ///Do not include "Bearer " as part of the key
    public required init(API_KEY: String) {
        self.API_KEY = API_KEY
        headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(API_KEY)"
        ]
    }
    public func classify(model : Enumerations.CohereModel = .command, inputs: [String], examples : [Example], call : @escaping (Classification?)->Void) {
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
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/classify")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        URLRequest(request: request, jsonDecoder: Classification.self) { response in
            call(response)
        }
    }
    public func generate(prompt : String, model : Enumerations.CohereModel = .command, num_generations : Int = 1, stream : Bool = false, call : @escaping (Generation?)->Void) {
        let parameters = [
            "truncate": "END",
            "return_likelihoods": "NONE",
            "prompt": prompt,
            "num_generations": num_generations,
            "stream": stream,
            "model": model.rawValue
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/generate")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        URLRequest(request: request, jsonDecoder: Generation.self) { response in
            call(response)
        }
    }
    public func embed(texts : [String], model : Enumerations.EmbedModel = .englishV2, inputType : Enumerations.InputType = .classificatinon, call : @escaping (Embedding)->Void) {
        
        let parameters = [
            "texts": texts,
            "truncate": "END",
            "model": model.rawValue,
            "input_type": inputType.rawValue
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/embed")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        URLRequest(request: request, jsonDecoder: Embedding.self) { response in
            call(response)
        }
    }
    public func summarize(text: String, length : Enumerations.Length = .medium, format : Enumerations.Format = .auto, temperature: Double = 0.3, extractiveness : Enumerations.Extractiveness = .auto, model : Enumerations.CohereModel = .command, call: @escaping (Summarize)->Void) {
        let parameters = [
            "length": length.rawValue,
            "format": format.rawValue,
            "extractiveness": extractiveness.rawValue,
            "temperature": temperature,
            "text": text
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/summarize")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        URLRequest(request: request, jsonDecoder: Summarize.self) { response in
            call(response)
        }
    }
    ///yo dont change the last 3 params unless you for sure know what ur doing :)
    public func rerank(query : String, documents : [String], model : Enumerations.RerankModel = .english, topN : Int, maxChunks : Int = 10, returnDocuments : Bool = true, call : @escaping (Rerank?)->Void) {
        let parameters = [
            "return_documents": false,
            "max_chunks_per_doc": maxChunks,
            "model": model.rawValue,
            "query": query,
            "documents": documents,
            "top_n": topN,
        ] as [String : Any]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.cohere.ai/v1/rerank")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        URLRequest(request: request, jsonDecoder: Rerank.self) { response in
            call(response)
        }
    }
    private func URLRequest<T : Codable>(request : NSMutableURLRequest, jsonDecoder : T.Type, callback : @escaping (T)->Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response!)")
                    return
                }
                if let data = data {
                    if let result = self.ParseResult(data: data, jsonDecoder: T.self) {
                        callback(result)
                    }
                }
            }
        })
        dataTask.resume()
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
}
