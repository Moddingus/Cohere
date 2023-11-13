# Cohere API Swift Package
The Cohere API Swift Package is a comprehensive Swift library that provides seamless integration with the Cohere API. It allows developers to easily utilize the full range of features and capabilities offered by the Cohere API in their Swift projects. See the [Cohere about page](https://docs.cohere.com/reference/about) for more information about the Cohere AI.

## Requirements
* Swift 5.0 or later
* Cohere API key (sign up on the Cohere website)

## Key Features
Complete API Coverage: This Swift package implements all features and functionalities of the Cohere API, ensuring that you have access to the entire range of capabilities offered by Cohere's powerful natural language processing platform.

## Getting Started
To get started with the Cohere API Swift Package, simply follow the steps below:

### Installation
Install the package using Swift Package Manager (SPM) by adding it as a dependency in your project's Package.swift file.

## Usage 
Import the Cohere API Swift Package in your project and get API resonses via the following methods.

### Classification
This method generates makes a prediction about which label fits the specified text inputs best.
```swift
import Cohere

let co = CohereClient(API_KEY: "<API_KEY>")

Task.init {
    if let classification = await co.classify(
        model:
            .command,
        inputs: [
            "Confirm your email address",
            "hey i need u to send some $"
        ],
        examples:
        [
            Example(text: "Dermatologists don't like her!", label: "Spam"),
            Example(text: "Hello, open to this?", label: "Spam"),
            Example(text: "I need help please wire me $1000 right now", label: "Spam"),
            Example(text: "Nice to know you ;)", label: "Spam"),
            Example(text: "Please help me?", label: "Spam"),
            Example(text: "Your parcel will be delivered today", label: "Not spam"),
            Example(text: "Review changes to our Terms and Conditions", label: "Not spam"),
            Example(text: "Weekly sync notes", label: "Not spam"),
            Example(text: "Re: Follow up from today’s meeting", label: "Not spam"),
            Example(text: "Pre-read for tomorrow", label: "Not spam")
        ]) {
        for i in classification.classifications! {
            print(i.prediction!)
        }
    }
}
```
#### Output:
```swift
"Not spam"
"Spam"
```
#### Note:
* For each classification type you want from Cohere you must provide one example of the classification applied to text as shown above

### Generation
This method generates realistic text conditioned on a given input.
```swift
import Cohere

let co = CohereClient(API_KEY: "<API_KEY>")

co.generate(prompt: "Please explain to me how LLMs work", model: .command, generations: 1, stream: false) { response in
    if let _response = response?.generations?.first?.text {
        print(_response)
    }
}
```
#### Output:
```swift
"LLMs, or Large Language Models, are a type of neural network..."
```
Ouputs may vary

#### Note:
* The maximum number of generations is 5. 5 will take a really long time.
* Generations are one-off requests and do not remeber previous prompts. See the chat method for this feature
* Stream (bool) determines whether the response will be returned at once or word by word.

### Embedding
This method generates semantic information about the texts which can be used to classify text. 
```swift
import Cohere

let co = CohereClient(API_KEY: "<API_KEY>")

co.embed(texts: ["hello", "goodbye"], model: .englishV2, inputType: .classificatinon) { response in
    if let _response = response.embeddings {
        print(_response)
    }
}
```
#### Output:
```swift
[[1.6142578, 0.24841309, 0.5385742, -1.6630859, -0.27783203, 0.35888672,...]] 
```
Outputs may vary

#### Note:
* Gives you a matrix with a lot of numbers.
* Using light models improves speed and larger models improve response quality. `inputType` has no effect if you are using a model less than V3.
* For optimal performance reduce the length of each text to be under 512 tokens
* The Maximum number of texts per call is 96

### Chat
The chat endpoint allows users to have conversations with a Large Language Model (LLM) from Cohere. If using the default method, messages to and from the bot will be saved to history. History can be cleared using `.clearChatHistory` method. You may also provide the id of an existing conversation to resume a chat. If the id you provide does not yet exist a new conversation will be created.
```swift
import Cohere

let co = CohereClient(API_KEY: "<API_KEY>")

co.embed(texts: ["hello", "goodbye"], model: .englishV2, inputType: .classificatinon) { response in
    if let _response = response.embeddings {
        print(_response)
    }
}
```
#### Output:
```swift
[[1.6142578, 0.24841309, 0.5385742, -1.6630859, -0.27783203, 0.35888672,...]] 
```
Outputs may vary

#### Note:
* Will remember previous prompts
* 



For more information and detailed usage examples, please refer to the [Cohere API Docs](https://docs.cohere.com/reference/about).

## Support and Feedback
If you encounter any issues or have any questions or feedback regarding the Cohere API Swift Package, please don't hesitate to reach out to our support team or open an issue on the package's GitHub repository. Feel free to fork and make PRs to this package, you guys are probably way better at this than I am.
