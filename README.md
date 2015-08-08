[![Build Status](https://travis-ci.org/Mirmeca/Mirmeca.svg)](https://travis-ci.org/Mirmeca/Mirmeca)

# Mirmeca
Mirmeca is a framework written in Swift that makes it easy for you to build apps on top of the WordPress API.

- [Features](#features)
- [Getting started](#getting-started)
- [Available types](http://mirmeca.github.io/Mirmeca/contribute/models/)
- [Available gateways](http://mirmeca.github.io/Mirmeca/contribute/gateways/)
- [Use cases](#use-cases)
- [Installation](#installation)
- [Contributing](#contributing)

<a name="features"></a>
#Features
- Out of the box models for WordPress **types** (`Post`, `FeaturedImage`,  `Term`, `Comment`, `Author`, etc...).
- Built in gateways to retrieve collections of types or single items from your WordPress backend (`PostsGateway`, `CommentGateway`, etc...).
- Start displaying content in under 5 minutes and less than 5 lines of code.

<a name="getting-started"></a>
#Getting started
To get started you will need a WordPress installion running the [**WP API**](https://wordpress.org/plugins/json-rest-api/) plugin.

Interaction with your WordPress backend is made through **Gateways** (`PostsGateway`, `TermGateway`...).

Gateways let you send requests for content to WordPress in just a few lines of code.

They output **types** (`Post`, `Comment`, `Author`...) or arrays or types.

###Declare your environnements in your AppDelegate

```swift
let envs = ["dev": "http://localhost:3000/wp-json", "staging": "http://staging.example.com"]
MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
```

###Send a request to get the latest posts in your ViewController
```swift
// Pass the "posts" endpoint & use the default env
PostsGateway(endpoint: "posts", env: nil).request({})
```
###Print the posts by passing a closure to the `request` method
```swift
PostsGateway(endpoint: "posts", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
  // Make sure that something was returned
  if (error != nil) {
    println("Something went wrong")
  } else {
    // Cast the return value as an array of posts
    let posts = value as! [Post]
    for post in posts {
      println(post.title!)
    }
  }
})
```

<a name="use-cases"></a>
#Use cases
Here are three of the numerous things **Mirmeca** helps you accomplish.

###Types & Gateways
- Check the list available **types** [here](http://mirmeca.github.io/Mirmeca/contribute/models/).
- Check the list available **Gateways** [here](http://mirmeca.github.io/Mirmeca/contribute/gateways/).

###Search for posts
- Endpoint: `posts?filter[s]=`
- Gateway: `PostsGateway`
- Code:

```swift
let query = "chocolate%20cake"
PostsGateway(endpoint: "posts?filter[s]=\(query)", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
  // Make sure that something was returned
  if (error != nil) {
    println("Something went wrong")
  } else {
    // Cast the return value as an array of posts
    let posts = value as! [Post]
    for post in posts {
      println(post.title!)
    }
  }
})
```

###List your site's categories
- Endpoint: `taxonomies/category/terms`
- Gateway: `TermsGateway`
- Code:

```swift
TermsGateway(endpoint: "taxonomies/category/terms", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
    // Make sure that something was returned
    if (error != nil) {
        println("Something went wrong")
    } else {
        // Cast the return value as an array of terms
        let categories = value as! [Term]
        for category in categories {
            println(category.name!)
        }
    }
})
```

###Retrieve comments for a post
- Endpoint: `posts/40627/comments`
- Gateway: `CommentsGateway`
- Code:

```swift
CommentsGateway(endpoint: "posts/40627/comments", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
    // Make sure that something was returned
    if (error != nil) {
        println("Something went wrong")
    } else {
        // Cast the return value as an array of comments
        let comments = value as! [Comment]
        for comment in comments {
            println(comment.author!.name!)
        }
    }
})
```

<a name="installation"></a>
#Installation

<a name="contributing"></a>
#Contributing