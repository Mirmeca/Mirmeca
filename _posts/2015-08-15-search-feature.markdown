---
layout:     page
title:      "Building a Search Feature"
date:       2015-08-08 16:37:18
subTitle:   "This tutorial will walk you through how to build a search feature for your app with Mirmeca."
categories: tutorial
---

The aim of this tutorial is to show you how you can build a search feature for your app on top of your WordPress backend using Mirmeca.
Mirmeca, helps you cut your dev time dramatically.

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

####a) TableViewController

In your `Storyboard` and add a `TableViewController`.


![add table view controller]({{ site.url }}/Mirmeca/assets/images/add-table-view-controller.png)


Then grab the `Storyboard entry point` (the arrow currently sitting next to your `View Controller`), and drag it to your freshly created `TableViewController`.


![entry point]({{ site.url }}/Mirmeca/assets/images/entry-point.png)


Click your `TableViewController`, and in the inspector, set its class to be `TableViewController`.


![class inspector]({{ site.url }}/Mirmeca/assets/images/class-inspector.png)

####b) Search bar & results cells

Click the cell of our `TableViewController`, and set its style to "Subtitle".


![subtitle]({{ site.url }}/Mirmeca/assets/images/subtitle.png)

We'll set our cell's identifier as `postCell`.

![cell identifier]({{ site.url }}/Mirmeca/assets/images/identifier.png)

Now look for "Search Bar" in the object library.

![subtitle]({{ site.url }}/Mirmeca/assets/images/search-bar-obj-lib.png)

Drag it and drop it on your view above your cell.

![subtitle]({{ site.url }}/Mirmeca/assets/images/search-bar-on-view.png)

Once you're done, select it and create an outlet on your `TableViewController` class called `postsSearchBar`.

Make sure your outlet is connected to the search bar on the view.

<pre class="prettyprint">
class TableViewController: UITableViewController {
    @IBOutlet weak var postsSearchBar: UISearchBar!
</pre>

### 3. Plugging Mirmeca into the app
It's now time for the fun stuff and start getting data into our app.

We have four simple steps ahead of us:<br>
  **a)** Declaring our environnements in the AppDelegate<br>
  **b)** Integrating our search bar<br>
  **c)** Fetching our searched posts<br>
  **d)** Displaying the posts<br>

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

####b) Integrating our search bar
Go to your `TableViewController` class. Start by importing Mirmeca and create an array of `posts`. You will also need to implement the `UISearchBarDelegate` protocol.

<pre class="prettyprint">
import UIKit
import Mirmeca

class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var postsSearchBar: UISearchBar!
    var posts = [Post]()
    
...
</pre>

Now, we need to set the search bar's delegate as `self`.<br>
In our `viewDidLoad` method:

<pre class="prettyprint">
override func viewDidLoad() {
    super.viewDidLoad()
    self.postsSearchBar.delegate = self
}
</pre>


####c) Fetching our searched posts

All good, now it's time to trigger the search when the user hits the "Search" button. To do so we need to do 3 things:

- Get the string entered by the user and make it "query friendly".
- Fetch our list of posts.
- Dismiss the keyboard.

All of that will happen in the `searchBarSearchButtonClicked` method. It will call two custom methods that we'll implement right now.

`formatStringForSearch` to make the user's string "http friendly":

<pre class="prettyprint">
func formatStringForSearch(string: String) -> String {
    return string.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
}
</pre>

All this method does is find the white spaces and replace them by `%20`.

`fetchPostsList` to send the request and act upon its results:
<pre class="prettyprint">
PostsGateway(endpoint: "posts?filter[s]=\(searchQuery)", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
    if (error != nil) {
        println(error)
    } else {
        self.posts = value as! [Post]
        self.tableView.reloadData()
    }
  })
</pre>

So what are we doing here? We're using the `PostsGateway` method provided by Mirmeca. We're giving it an endpoint for the search that contains the query string entered by the user and formatted by us.

Then, we assign the value of our `[Post]` array to whatever list of posts Mirmeca has returned to us and we reload the table view's content to display these new posts.

So now, we can actually call the two methods we've created above. We'll do this from the `searchBarSearchButtonClicked`.
<pre class="prettyprint">
func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    var searchQuery = self.formatStringForSearch(searchBar.text!)
    self.fetchPostsList(searchQuery)
    searchBar.endEditing(true)
}
</pre>

We start by grabbing the text entered by the user in the search bar.

We format this string using the `formatStringForSearch` we created earlier.

We're then using this formatted string to call `fetchPostsList`.<br>
Finally, we hide the search bar by calling `searchBar.endEditing(true)`.

It's that simple!

####d) Displaying the posts
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
So there you have it, a 10 minutes Mirmeca app that lets you search your posts!

We've implemented our search feature in our app in a matter of minutes, without having to write the underlying code that would normally have been required.

Need help with anything? Please get in touch solal.fitoussi [at] gmail [dot] com
