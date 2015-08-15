---
layout: page
title:  "Getting Started"
date:   2015-08-08 16:37:18
subTitle: "This guide will walk you through how Mirmeca works."
categories: tutorial
---

The aim of this Getting Started Guide is to show you how you can build an app on top of your WordPress backend in just a few minutes with Mirmeca.

This tutorial assumes you're already familiar with Cocoapods as we'll use it to install Mirmeca. You will also need to have an installation of WordPress running the [WP API plugin](https://wordpress.org/plugins/json-rest-api/).

Let's get started!


### 1. Creating a new project and installing Mirmeca

Open XCode and create a new "Single View Application". I will call mine "Breaking News".


![create app]({{ site.url }}/Mirmeca/assets/images/create-app.png)


Now `cd` into your app's directory and `pod init` to create your `Podfile` (if you haven't installed Cocoapods, you'll find a guide [here](http://guides.cocoapods.org/using/getting-started.html) - you can also install the framework manually).

Now we need to add Mirmeca to our `Podfile`:

<pre class="prettyprint">
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'Breaking News' do
  pod 'Mirmeca', '~> 0.04'
end

target 'Breaking News' do
end
</pre>

Just run `pod update` and you're all set for the first phase.


### 2. Setting up view controllers

Open up the newly created Workspace (`.xcworkspace`) that Cocoapods created for you.

Create a new class, a subclass of `UITableViewController`, and simply call it `TableViewController`.


![create class]({{ site.url }}/Mirmeca/assets/images/create-class.png)


Next, go into your `Storyboard` and add a `TableViewController`.


![add table view controller]({{ site.url }}/Mirmeca/assets/images/add-table-view-controller.png)


Then grab the `Storyboard entry point` (the arrow currently sitting next to your `View Controller`), and drag it to your freshly created `TableViewController`.


![entry point]({{ site.url }}/Mirmeca/assets/images/entry-point.png)


Click your `TableViewController`, and in the inspector, set its class to be `TableViewController`.


![class inspector]({{ site.url }}/Mirmeca/assets/images/class-inspector.png)


Click the cell of our `TableViewController`, and set its style to "Subtitle".


![subtitle]({{ site.url }}/Mirmeca/assets/images/subtitle.png)


To finish with the Storyboard, we'll set our cell's identifier as `postCell`.


![cell identifier]({{ site.url }}/Mirmeca/assets/images/identifier.png)


### 3. Plugging Mirmeca into the app
It's now time for the fun stuff and start getting data into our app.

We have three simple steps ahead of us:<br>
  **a)** Declaring our environnements in the AppDelegate<br>
  **b)** Loading the latest posts<br>
  **c)** Displaying the posts<br>

####a) Declaring our environnements in the AppDelegate
For Mirmeca to work, it needs to be provided with your environnements at startup.

Easy, enough, the framework gives you a simple method to do just that. The trick is that it needs to be called from your `AppDelegate`.

Start by importing Mirmeca:

<pre class="prettyprint">
import UIKit
import Mirmeca
</pre>

Then in your `application didFinishLaunchingWithOptions` method, create a dictionary with your envs (I only have one here) and call the `MirmecaEnv.sharedInstance.defineEnvs(envList: Dictionary<String, String>, defaultEnv: String)` method.

<pre class="prettyprint">
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let envs = ["dev": "http://localhost:3000/wp-json"]
    // Our default env will simply be `dev`
    MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")

    return true
}
</pre>

So now every time Mirmeca will send a request to an API endpoint, it will use the URL of your default env, unless you specify a new one.
Let's try that!

####b) Loading the latest posts
Go to your `TableViewController` class. Start by importing Mirmeca and create an array of `posts`.

<pre class="prettyprint">
import UIKit
import Mirmeca

class TableViewController: UITableViewController {
    
    var posts = [Post]()
    
...
</pre>

Now, we need to work in our `viewDidLoad` method. We'll send a request to our WordPress backend asking for the latest posts using Mirmeca's `PostsGateway` class and the `posts` endpoint.

<pre class="prettyprint">
override func viewDidLoad() {
    super.viewDidLoad()
   
    PostsGateway(endpoint: "posts", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
      if (error != nil) {
        //let's do something like print an alert
      } else {
        self.posts = value as! [Post]
      }
    })
}
</pre>

So what are we doing exactly here?<br>
We start by instantiating a `PostsGateway` object with no env (will use default) and an endpoint to get the latest posts.<br>
We then pass a closure to the request method to do something once the list of posts has been returned.<br>
We check if we have an error before doing anything with `value`.
Finally, we cast `value` to an array of posts and assign it to our `posts` variable.

Ok that's great! We're all set to fetch posts from the API! We could easily print the titles of our posts or the number of posts we have in our array to make sure we're getting something.

####c) Displaying the posts
This bit is fairly easy, it takes 3 short steps.

First, we need to set the number of sections in our table view, and we only need one here:

<pre class="prettyprint">
override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
}
</pre>

Second, we need to set the number of rows in our section. It will correspond to the number of items we have in the posts array:

<pre class="prettyprint">
override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.posts.count
}
</pre>

And last but not least, we need to configure our cell to display our content.

Let's configure our cells' `textLabel` and `detailTextLabel` with our post title and author's first name respectively.

<pre class="prettyprint">
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! UITableViewCell
    
    // Get the post corresponding to the row
    let post = self.posts[indexPath.row]
    
    cell.textLabel?.text = post.title!
    cell.detailTextLabel?.text = post.author!.firstName
    return cell
}
</pre>

As you can see in the code above, populating our row is as simple as accessing properties on the `Post` object Mirmeca is giving us.


### Conclusion
So there you have it, your first Mirmeca app!

We've loaded our latest posts in our app in a matter of minutes, without having to write the underlying code that would normally have been required for us to implement this feature.

But Mirmeca allows you to do much much more. Things like building a search functionality for your app, navigate by category, display posts by a certain tag etc...

Need help with anything? Please get in touch solal.fitoussi [at] gmail [dot] com

