# VPExam - mobile assignment (iOS)
## Fetching data and navigation through the sections

Followings were used in this project:
* Xcode 11.3
* Swift 5
* iOS 10+
* VIPER architecture

## Technical declaration:
* For the offline availability purpose, I used a specific cache policy, so after the first online run, user can use cached data.
* One of the side effects of the caching, depending on the importance of the responses, is that they won't be expired easily. For the solution I implemented a pull to refresh mechanism in the main table view, so after refreshing, all the cache data will be earased.
* In the unit testing part, I implemented a simple test, due there were no too many logics or methods.
* There are seven json files for network request mocking in the unit test. except the 'vpsections.json', other json files were customized (unused properties were removed).
