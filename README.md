
### Weather

A simple weather application using OpenWeather

#### Project Requirements

The goal of this assignment is to build a small app that is as close to production-ready code quality as you can within 2-4 hours. In areas where you had to take shortcuts due to time limits, please leave comments explaining what you would have liked to do.

The app will connect to a weather service to retrieve data and display the results.

Please use the OpenWeatherMap API.

* Create a free account at https://home.openweathermap.org/users/sign_up
* Note: It can take some time for your key to become active. Please do this first!
* General API instructions  https://openweathermap.org/appid
* Use the "OneCall" API: https://openweathermap.org/api/one-call-api
* You can exclude the "minutely", "hourly", and "alerts" portions of the results if you like.
* Note: There are rate & quantity limits on the API. It would be a good idea to cache the results during development to avoid hitting the limits.

App Details

* Landing page should be a UINavigationController.
* Nav Bar should have a right bar button item to ask permission to use user's location.
* On "Allow": Refresh weather list to show current user location's weather.
* On "Don't Allow": Do nothing.
* Don’t worry too much about visual design, just get something working with simple TableView or CollectionView. There should be a row/cell for each day.
* The daily cells should have at least (feel free to show more data)
    - an image view that shows an icon image from the API response
    - labels that show the date and day of week
    - labels that show the high and low temperature
* On didSelectCell (or Item) delegate, navigate to a detail page to show
    - "weather.description" field inside "daily" section

Process

* Use any pods or libraries you like (Alamofire, for instance, for making api calls).
* EXCEPT please do not use any OpenWeather pods or libraries.
* Use a clear architecture pattern that you feel most comfortable with (MVC is valid).
* Be prepared to explain how you architected your code and why.
* Please commit frequently as you work on the assignment.
* Please don't spend too long, and have fun!

#### Project Setup

In order to setup the project, simply download this repository. While all pods are included, ensure the pods plugin "cocoapods-keys" is installed. This plugin is used for key obfuscation, so the API key does not exist in the project code.

When this plugin is installed, simply run `pod install` to update the key. There will be a command prompt to enter a valid API key, which will be used in the code.

#### Project Completion

About 95% of the project, however, it is not set for production. Time went into analysis and architecture design prior to even constructing code, which took a majority of the time.

Completed Items:
- Location Request
- Fetch from API
- Collecction View for Daily Weather
- Root controller is UINavigationController
- Tapping a card shows API result description

Incomplete items:
- API Caching and storages
- Design on details screen
- State management (mostly there, but a little buggy for zero state and loading)
- Project documentation (internal)
