[![Build Status](https://travis-ci.org/Mirmeca/Mirmeca.svg)](https://travis-ci.org/Mirmeca/Mirmeca)

# Mirmeca
Mirmeca is a framework written in Swift that makes it easy for you to build apps on top of the WordPress API.

#Features
- Out of the box models for WordPress types (`Post`, `Term`, `Comment`, `FeaturedImage`, etc...).
- Built in gateways to retrieve collections of content or single items from you WordPress backend (`PostsGateway`, `CommentGateway`, etc...).
- Start displaying content in under 5 minutes and less than 5 lines of code.

#Getting started
To get started you will need a WordPress installion running the [**WP API**](https://wordpress.org/plugins/json-rest-api/) plugin.

#####Declare your environnements in your `AppDelegate`

```swift
let envs = ["dev": "http://localhost:3000/wp-json", "staging": "http://staging.example.com"]
MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
```

#####Send a request to get the latest posts in your `ViewController`
```swift
// Pass the "posts" endpoint & use the default env
PostsGateway(endpoint: "posts", env: nil).request({})
```
#####Print the posts by passing a closure to the `request` method
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

#Use cases
Here are three of the numerous things **Mirmeca** helps you accomplish.

#####Search for posts
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

#####List your site's categories
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

#####Retrieve comments for a post
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