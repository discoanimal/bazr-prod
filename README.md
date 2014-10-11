[![RelatedCode](http://relatedcode.com/github/header8.png)](http://relatedcode.com)

## OVERVIEW

AwesomeChat is a full native iPhone app to create realtime, text based chatrooms with Facebook/Twitter login.

![AwesomeChat](http://relatedcode.com/github/awesomechat1.png)
.
![AwesomeChat](http://relatedcode.com/github/awesomechat2.png)
.
![AwesomeChat](http://relatedcode.com/github/awesomechat3.png)

AwesomeChat is using Firebase as backend which is free for side projects or businesses that are just getting started. (Free plan: 5 GB Data Transfer, 50 Max Connections, 100 MB Data Storage).

Really easy to setup, just copy/paste the code and use your own chatrooms.

## WHAT'S NEW IN 1.2

- JSQMessagesViewController is updated
- Message date is stored at backend (finally)
- ProgressHUD is updated
- AFNetworking is updated
- Architecture 64 bit warnings are eliminated
- Firebase Framework is updated too (I guess)
- Facebook settings updated (finally)

## FEATURES

- Realtime, live chat between multiple devices
- Facebook/Twitter login
- Mind-blowing fast chat actions
- No backend programming needed
- Automatic online/offline detection and handle
- Copy and paste messages
- Dynamically resizes input text while typing
- Native and easy to customize user interface
- Send button is enabled/disabled automatically
- Arbitrary message sizes
- Data detectors (recognizes phone numbers, links and dates)
- Timestamps possibilities
- Automatic avatar images from Facebook/Twitter
- Hide keyboard with swipe down
- Smooth animations
- Send/Receive sound effects
- Handles multiple Twitter accounts on Login

## REQUIREMENTS

- Xcode 5
- iOS 7
- ARC

## INSTALLATION

**1.,** All AwesomeChat files located in *Chat* directory. Vendor files located in *Vendor* directory and external Frameworks in *Framework* directory. Some resource files can be found in *Resources* directory. Simply add *Chat*, *Resources*, *Vendor* and *Framework* directories to your project.

**2.,** You need the following iOS (built in) libraries: UIKit.framework, CoreGraphics.framework, Foundation.framework, SystemConfiguration.framework, Security.framework, CFNetwork.framework, Accounts.framework, Social.framework, libicucore.dylib, libc++.dylib.

To add libraries follow these steps: Click on the Targets → Your app name → and then the 'Build Phases' tab and then expand 'Link Binary With Libraries'. Click the plus button in the bottom left of the 'Link Binary With Libraries' section and choose library items from the list.

**3.,** You also need the latest Firebase.framework and FirebaseSimpleLogin.framework (already included). But if you need, you can download from here:

https://cdn.firebase.com/ObjC/Firebase.framework-LATEST.zip<br>
https://cdn.firebase.com/ios/FirebaseSimpleLogin.framework-LATEST.zip<br>

To add Firebase.framework and FirebaseSimpleLogin.framework, just unzip the above files and drag the .framework folders into your Xcode project under 'Frameworks'.

**4.,** Firebase makes use of Objective-C classes and categories, so you'll need to add '-ObjC' under 'Other Linker Flags' in 'Build Settings'. 

**5.,** The *Prefix.pch* should contain:

```
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
```

**6.,** You also need several external libraries which are included. But if you need, you can download them from here:

https://github.com/AFNetworking/AFNetworking<br>
https://github.com/jessesquires/JSQMessagesViewController<br>
https://github.com/jessesquires/JSQSystemSoundPlayer<br>
https://github.com/relatedcode/ProgressHUD<br>

To use these libraries, just add AFNetworking, JSQMessagesViewController, JSQSystemSoundPlayer and ProgressHUD directories to your project.

**7.,** You need to use your own Firebase account. To get your Firebase account click here:

https://www.firebase.com/signup

**8.,** Replace existing Firebase account in *common.h*:

```
#define FIREBASE @"https://relatedchat.firebaseio.com"
```

**9.,** You need to register you app at Facebook and Twitter.

https://developers.facebook.com/apps<br>
https://dev.twitter.com/apps<br>

**10.,** At Facebook you need to enter your apps bundle identifier (Twitter does not require that).

![Facebook](http://relatedcode.com/codecanyon/facebook.png)

**11.,** You need to enter your Facebook App Id, Facebook App Secret and your Twitter Consumer Key, Twitter Consumer Secret at Firebase, Simple Login tab.

![Twitter](http://relatedcode.com/codecanyon/firebase_twitter.png)

**12.,** Replace your Facebook App Id and your Twitter Consumer Key in *common.h*

```
#define FACEBOOK_KEY @"1412541952322331"
#define TWITTER_KEY @"idEO49RKfbP7sjPmoSaZkg"
```

## CONTACT

Do you have any questions or idea? My email is: info@relatedcode.com or you can find some more info at [relatedcode.com](http://relatedcode.com)

## LICENSE

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
