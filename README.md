#ListMe

**Author:** Nick Palutsis

##Files  
The primary files for the application are broken up into the following folders:  

###View  
These files contain code which loads and formats cells for users, listings, and message conversations. These classes are used by the other files to organize their tableViews and collectionViews.  

###Helpers
This folder contains the file `Extensions.swift` which contains extension functions and other global variables that can be accessed by any of the other files.  

###Model  
These files contain classes which contain variables that match the keys of the Firebase nodes that are fetched.  

###Controller  
These files are the controllers which manage the views for the application. `CustomTabBarController.swift` creates the tab seen at the bottom of the application. It is customized to be green on select, and its items switch between five different views in the application.  
`LoginController.swift` and `LoginControllerHelpers.swift` manage the login and registration features.  
`HomeController.swift` displays a tableView where each cell provides information about a listing. Clicking on a cell triggers `ListingPageController.swift` which loads a new page with more information about the listing, and an option to buy the listing, triggering `ChatLogController.swift`.  
`MessagesController.swift` displays a tableView where each cell represents a conversation and shows a profile image, preview of the most recent message, and a timestamp for that message. Clicking on a cell loads `ChatLogController.swift` for that conversation. Tapping the compose button brings up `NewMessageController.swift`, and after selecting a user from this new tableView it will take the user to a new chat log.  
`NewListingController.swift` provides fields to post a new listing, as well as the ability to upload an image from the camera roll.  
`NotificationsController.swift` will eventually handle the notifications for the application.  
`UserProfileController.swift` will handle the user profile for the logged in user.  

##Development Environment  
The application was developed entirely using Xcode 8 and Swift 3. I decided to not use storyboards and, instead, opt to implement all of the features entirely programmatically. Firebase 3 was used as the backend for the application, and the authentication token for this service is stored in the application to provide access.

##How to run  
The application was tested using the simulator within Xcode. Since the application is made to be run on any iOS device that supports iOS 10, it has been tested on the iPhone 7, iPhone 7 Plus, and iPhone SE simulators. However, the application is optimized for the **iPhone 7** screen size. Running the simulation is as simple as selecting the proper simulation device from the upper left corner and then pressing the play button to the left. The simulator should open up automatically. If it is the first time running the application, then the application will open to the login and registration screen. Otherwise, it should remember the user and bring them immediately to the home page.