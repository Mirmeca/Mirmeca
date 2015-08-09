---
layout: page
title:  "Getting Started"
date:   2015-08-08 16:37:18
subTitle: "This guide will walk you through how Mirmeca works."
---

#Introduction
To get started you will need a WordPress installion running the [**WP API**](https://wordpress.org/plugins/json-rest-api/) plugin.

Interaction with your WordPress backend is made through **Gateways** (`PostsGateway`, `TermGateway`...).

Gateways let you send requests for content to WordPress in just a few lines of code.

They output **types** (`Post`, `Comment`, `Author`...) or arrays or types.

<br>

####Declare your environnements in your AppDelegate

<pre class="prettyprint">let envs = ["dev": "http://localhost:3000/wp-json", "staging": "http://staging.example.com"]
MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
</pre>

<br>

####Send a request to get the latest posts in your ViewController
<pre class="prettyprint">
// Pass the "posts" endpoint & use the default env
PostsGateway(endpoint: "posts", env: nil).request({})
</pre>

<br>

####Print the posts by passing a closure to the `request` method
<pre class="prettyprint">
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
</pre>

<br>

#Use cases
Here are three of the numerous things **Mirmeca** helps you accomplish.


####Types & Gateways
- Check the list available **types** [here](/documentation/models/).
- Check the list available **Gateways** [here](/documentation/gateways/).

<br>

####Search for posts
- Endpoint: `posts?filter[s]=`
- Gateway: `PostsGateway`
- Code:

<pre class="prettyprint">
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
</pre>

<br>

####List your site's categories
- Endpoint: `taxonomies/category/terms`
- Gateway: `TermsGateway`
- Code:

<pre class="prettyprint">
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
</pre>

<br>

####Retrieve comments for a post
- Endpoint: `posts/40627/comments`
- Gateway: `CommentsGateway`
- Code:

<pre class="prettyprint">
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
</pre>