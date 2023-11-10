import UIKit
import Cohere

let co = CohereClient(API_KEY: "XQ0UUAWgS9ZDFt6aaDlGyUJcX4RJEgyqWXPG7drq")

co.generate(prompt: "hello") { response in
    if let _response = response?.generations?.first?.text {
        print(_response)
    }
    
}
