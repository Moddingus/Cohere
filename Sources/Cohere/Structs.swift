//
//  File.swift
//  
//
//  Created by Max Siebengartner on 10/11/2023.
//

import Foundation

public struct Classification: Codable {
    let id: String?
    let classifications: [ClassificationElement]?
    let meta: Meta?
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
}

    // MARK: - Labels
public struct Labels: Codable {
    public let cancellingCoverage, changeAccountSettings, filingAClaimAndViewingStatus, findingPolicyDetails: CancellingCoverage?
    
    public enum CodingKeys: String, CodingKey {
        case cancellingCoverage = "Cancelling coverage"
        case changeAccountSettings = "Change account settings"
        case filingAClaimAndViewingStatus = "Filing a claim and viewing status"
        case findingPolicyDetails = "Finding policy details"
    }
}

    // MARK: - CancellingCoverage
public struct CancellingCoverage: Codable {
    public let confidence: Double?
}

public enum CodingKeys: String, CodingKey {
    case cancellingCoverage = "Cancelling coverage"
    case changeAccountSettings = "Change account settings"
    case filingAClaimAndViewingStatus = "Filing a claim and viewing status"
    case findingPolicyDetails = "Finding policy details"
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

    // MARK: - Meta
public struct Meta: Codable {
    public let apiVersion: APIVersion?
    
    public enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
    }
}

    // MARK: - APIVersion
public struct APIVersion: Codable {
    public let version: String?
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
    let id, summary: String?
    let meta: Meta?
}
public struct Rerank: Codable {
    let id: String?
    let results: [Rankings]?
    let meta: Meta?
}
    // MARK: - Result
public struct Rankings: Codable {
    let index: Int?
    let relevanceScore: Double?
    
    enum CodingKeys: String, CodingKey {
        case index
        case relevanceScore = "relevance_score"
    }
}
