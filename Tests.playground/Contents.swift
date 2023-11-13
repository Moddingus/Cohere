import Cohere

let co = CohereClient(API_KEY: "XQ0UUAWgS9ZDFt6aaDlGyUJcX4RJEgyqWXPG7drq")

Task.init {
    if let response = await co.chat(message: "hello") {
        print(response)
    }
}
