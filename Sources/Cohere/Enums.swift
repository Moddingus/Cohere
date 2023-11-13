//
//  File.swift
//  
//
//  Created by Max Siebengartner on 9/11/2023.
//

import Foundation

    public enum CohereModel : String {
        case command = "command"
        case commandNightly = "command-nightly"
        case commandLight = "command-light"
        case commandLightNightly = "command-light-nightly"
    }
    public enum Length : String {
        case short = "short"
        case medium = "medium"
        case long = "long"
    }
    public enum Format : String {
        case paragraph = "paragraph"
        case bullets = "bullets"
        case auto = "auto"
    }
    public enum Extractiveness : String {
        case low = "low"
        case medium = "medium"
        case high = "high"
        case auto = "auto"
    }
    public enum RerankModel : String {
        case multilingual = "rerank-multilingual-v2.0"
        case english = "rerank-english-v2.0"
    }
    public enum EmbedModel : String {
        case englishV3 = "embed-english-v3.0"
        case multilingualV3 = "embed-multilingual-v3.0"
        case englishLightV3 = "embed-english-light-v3.0"
        case multilingualLightV3 = "embed-multilingual-light-v3.0"
        case englishV2 = "embed-english-v2.0"
        case englishLightV2 = "embed-english-light-v2.0"
        case multilingualV2 = "embed-multilingual-v2.0"
    }
public enum InputType : String {
    case searchDocument = "search_document"
    case searchQuery = "search_query"
    case classificatinon = "classification"
    case clustering = "clustering"
}
