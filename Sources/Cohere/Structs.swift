//
//  File.swift
//  
//
//  Created by Max Siebengartner on 10/11/2023.
//

import Foundation


public struct ChatRes: Codable {
    public let responseID, text, generationID: String?
    public let tokenCount: TokenCount?
    public let meta: Meta?

    public enum CodingKeys: String, CodingKey {
        case responseID
        case text
        case generationID
        case tokenCount
        case meta
    }
}
// MARK: - TokenCount
public struct TokenCount: Codable {
    public let promptTokens, responseTokens, totalTokens, billedTokens: Int?

    public enum CodingKeys: String, CodingKey {
        case promptTokens
        case responseTokens
        case totalTokens
        case billedTokens
    }
}
public struct ChatHistory {
    public let role : role
    public let message : String
    public let username : String
    
    public enum role : String {
        case ChatBot = "CHATBOT"
        case User = "USER"
    }
    public func dict() -> [String : Any] {
        return [
            "role": self.role.rawValue,
            "message": message,
            "user_name": username
          ]
    }
    public init(role: role, message: String, username: String) {
        self.role = role
        self.message = message
        self.username = username
    }
}
public struct Example {
    public let text : String
    public let label : Any
    
    public init(text: String, label: Any) {
        self.text = text
        self.label = label
    }
    public func dict() -> [String : Any] {
        return ["text" : self.text, "label" : self.label]
    }
}
public struct Connector {
    public let text : String
    public let label : Any
    
    public init(text: String, label: Any) {
        self.text = text
        self.label = label
    }
    public func dict() -> [String : Any] {
        return ["text" : self.text, "label" : self.label]
    }
}
public struct Classification: Codable {
    public let id: String?
    public let classifications: [ClassificationElement]?
    public let meta: Meta?

    public init(id: String?, classifications: [ClassificationElement]?, meta: Meta?) {
        self.id = id
        self.classifications = classifications
        self.meta = meta
    }
}

// MARK: - ClassificationElement
public struct ClassificationElement: Codable {
    public let classificationType: String?
    public let confidence: Double?
    public let confidences: [Double]?
    public let id, input: String?
    public let labels: Labels?
    public let prediction: String?
    public let predictions: [String]?

    public enum CodingKeys: String, CodingKey {
        case classificationType = "classification_type"
        case confidence, confidences, id, input, labels, prediction, predictions
    }

    public init(classificationType: String?, confidence: Double?, confidences: [Double]?, id: String?, input: String?, labels: Labels?, prediction: String?, predictions: [String]?) {
        self.classificationType = classificationType
        self.confidence = confidence
        self.confidences = confidences
        self.id = id
        self.input = input
        self.labels = labels
        self.prediction = prediction
        self.predictions = predictions
    }
}

// MARK: - Labels
public struct Labels: Codable {
    public let notSpam, spam: Spam?

    enum CodingKeys: String, CodingKey {
        case notSpam = "Not spam"
        case spam = "Spam"
    }

    public init(notSpam: Spam?, spam: Spam?) {
        self.notSpam = notSpam
        self.spam = spam
    }
}

// MARK: - Spam
public struct Spam: Codable {
    public let confidence: Double?

    init(confidence: Double?) {
        self.confidence = confidence
    }
}

// MARK: - Meta
public struct Meta: Codable {
    public let apiVersion: APIVersion?

    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
    }

    init(apiVersion: APIVersion?) {
        self.apiVersion = apiVersion
    }
}

// MARK: - APIVersion
public struct APIVersion: Codable {
    public let version: String?

    init(version: String?) {
        self.version = version
    }
}

public struct Generation: Codable {
    public let id: String?
    public let generations: [GenerationElement]?
    public let prompt: String?
    public let meta: Meta?
}

    // MARK: - GenerationElement
public struct GenerationElement: Codable {
    public let id, text, finishReason: String?
    
    public enum CodingKeys: String, CodingKey {
        case id, text
        case finishReason = "finish_reason"
    }
}
public struct Embedding: Codable {
    public let id: String?
    public let texts: [String]?
    public let embeddings: [[Double]]?
    public let meta: Meta?
}
public struct Tokenize: Codable {
    public let tokens: [Int]?
    public let tokenStrings: [String]?
    public let meta: Meta?
    
    public enum CodingKeys: String, CodingKey {
        case tokens
        case tokenStrings = "token_strings"
        case meta
    }
}
public struct Detokenize: Codable {
    public let text: String?
    public let meta: Meta?
}
public struct DetectLanguage: Codable {
    public let id: String?
    public let results: [LanguageData]?
    public let meta: Meta?
}
public struct LanguageData: Codable {
    public let languageName, languageCode: String?
    
    public enum CodingKeys: String, CodingKey {
        case languageName = "language_name"
        case languageCode = "language_code"
    }
}
public struct Summarize: Codable {
    public let id, summary: String?
    public let meta: Meta?
}
public struct Rerank: Codable {
    public let id: String?
    public let results: [Rankings]?
    public let meta: Meta?
}
    // MARK: - Result
public struct Rankings: Codable {
    public let index: Int?
    public let relevanceScore: Double?
    
    enum CodingKeys: String, CodingKey {
        case index
        case relevanceScore = "relevance_score"
    }
}
