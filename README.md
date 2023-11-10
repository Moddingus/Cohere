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
Import the Cohere API Swift Package in your Swift project and start get the API resonse from 

### Classification
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
#### Note:
* Generations must be an integer up to and including 5
* Stream (bool) determines whether the response will be returned at once or word by word

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
#### Note:
* Generations must be an integer up to and including 5
* Stream (bool) determines whether the response will be returned at once or word by word



For more information and detailed usage examples, please refer to the [Cohere API Docs](https://docs.cohere.com/reference/about).

## Support and Feedback
If you encounter any issues or have any questions or feedback regarding the Cohere API Swift Package, please don't hesitate to reach out to our support team or open an issue on the package's GitHub repository. Feel free to fork and make PRs to this package, you guys are probably way better at this than I am.
