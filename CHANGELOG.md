### 1.2.5

Provides support for Xcode 9.4.

* Server: add French localization for 3-button location alert #280
* Server: add Apple Music en and ru alerts #277

### 1.2.4

Provides support for Xcode 9.3 and prepares for OSS release.

* Xcode: Gemüse Bouche dylib libraries and testable UI in TestApp #265
* Scripts to submit XCUITest target for TestApp to Test Cloud #266
* Appium JUnit: can submit an example to App Center/Test Cloud #267
* Xcode 9.3 beta 2 support #268
* Xcode 9.3 beta 3 support #269
* Server: remove EnterTextIn and ClearTextIn; unused gestures #270
* added Russian SpringBoard alerts localizations (DeviceAgent) #271
* Xcode 9.3 beta 4 support #272
* Add test for XCUIElementType's #273
* Fix visibility for elements on macOS sierra running Xcode < 9.3 #274
* OSS: changes for MSFT open source review #275

### 1.2.3

* Xcode: target + script for running XCUITests against arbitrary .app #260
* Server: drag-n-drop can start with a touch-and-hold #259
* TestApp: update URLs to calabash-ci.xyz domain #258

### 1.2.2

* Use XCUIApplication#terminate to terminate applications #256
* Server: XCUIElement with type Any may or may not respond to WebDriver
  methods #255
* Add iOS 11 'would like to add to your photos' SpringBoard alert #254
* SB: add camera alert for iOS 11 de #252
* Server: update CBXDevice with iPhone 8 and 10 models #251

### 1.2.1

* Server: handle 3 button SpringBoard location alert #249

### 1.2.0

Support for Xcode 9/iOS 11 testing against physical devices and
simulators.

* Xcode 9: redirect simulator logs to ~/Library/CoreSimulator/<UDID>/system.log #247
* Server: XCUIApplication cannot be first responder #246

### 1.1.3

Premilinary support for Xcode 9/iOS 11 testing against physical devices.

Most gestures are failing on iOS Simulators.

* Server: decrease default touch time to 0.1 #244
* Update device rotation gesture and orientation reporting for iOS 11 #243
* Server: revert pull request #237 - remove pre-launch is-installed
  check; does not work on iOS 11 #242
* Xcode 9: text queries not forwarding to WebDriver attributes #241
* Server: handle infinite and CGFloat max/min floating point values #240
* Server: OR predicates not evaling correctly on web views - updated
  tests; issue is not resolved #239
* SB: add Hebrew and Italian SpringBoard alerts #238
* Use XCUIApplication to check if application is installed before launch #237
* Update CBXDevice for iPad Pro 10.5 and arm64 devices #236
* Update build scripts to publish TestApp to test-cloud-test-apps #235

### 1.1.2

* Server: add pt-BR alert definition for APNS #233
* Perform app query before resolving the application when checking
  visibility #232
* Server: GET /version returns DeviceAgent build info #227
* Server: add selected key to element JSON #223
* Server: add focus information to element JSON #222
* POST /session can terminate AUT if it is running #220
* SpringBoard: add French 'no SIM card installed' localization #216

### 1.1.1

DeviceAgent 1.1.0 was never released because of iOSDeviceManager
failures related to Xcode 8.3.

* DeviceAgent.xctest bundle includes xctestrun files #214
* Dismiss 'Open in' alerts automatically #212
* Fix PT-br APNS SpringBoard alert localizations #211
* Add Korean localizations for SpringBoard alerts #209
* Adds handling for VPN configuration springboard alert. #208
* Update for Xcode 8.3 #206
* Allow users to interact with SpringBoard alerts and control whether or
  not alerts are automatically dismissed #205
* Server: disable screenshots on server start #204

### 1.0.6

1.0.5 was never released.

* Add mach clock and a simple waiter #202
* SpringBoard#queryForAlert: skip\_waitForQuiescence check #201
* Increase touch duration to 0.2 to match XCUITest #198
* Use CocoaLumberjack for logging #197
* Update CocoaLumberjack to 3.0.0 #196
* TestApp: update to calabash.framework 0.20.4 #194
* Improve hitpoint and visibility calculation #193
* Fix text entry for i386/armv7 devices #192
* Dismiss SpringBoard alerts by touching alert buttons with coordinates #191
* SpringBoard: ask UIApplication for SpringBoard alert before making an
  expensive XCUITest query #190
* POST /session raises when app is not installed and when app fails to
  launch #189

### 1.0.4

DeviceAgent can dismiss SpringBoard alerts in any orientation.

* Replace NSRunLoop runUntilDate: with CFRunLoopRunInMode to avoid
  unreliable NSDate behaviors #187
* SpringBoard: use XCUIElement#tap to dismiss alerts #186
* DeviceAgent: generate and distribute a dSYM #185

### 1.0.3

DeviceAgent now dismisses the following US English SpringBoard alerts:

* Sign In to iTunes
* Access Apple Music And Your Media
* Health Access
* Enable Dictation

@oscartanner added support for Brazil PT for most of the SpringBoard
alerts.

* Add iTunes and Apple Music SpringBoard alerts #183
* Add UITextView to TestApp #181
* Use Testmanagerd `XCT_sendString` to enter text except on i386/armv7
  devices #178
* Fixes if statement in querying delete key for clear text #177
* Add GET environment and arguments #176
* Update SpringBoard alert definitions for iOS 10 #175
* clear\_text should tap keyboard delete key #170

### 1.0.2

* Cucumber: add @tree and @wildcard query Scenarios #169
* rm completion from threadutils runSync #168
* Drag avoid inertia #167
* Fix drag repetitions and correct duration from first point #164
* Touch: increase touch duration by 0.01 #161
* update default session ID #159

### 1.0.1

* Server: branch on element and snapshot when computing visibility #163
* Remove exception handling when computing visibility attributes in
  JSONUtils #162
* Server: resolve application before entering text #160

### 1.0.0

First release
