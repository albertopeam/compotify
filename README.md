# compotify
Demo player for Spotify open API using Swift+Combine

WORK IN PROGRESS

## Installation

To use the Spotift API is mandatory to create an app in the Spotify Dashboard and link it to our iOS app, to do it follow the next steps.

1. You need to access Spotify [dashboard](https://developer.spotify.com/dashboard/)
2. Once access is granted, create a new app entry, more info on [Spotify](https://developer.spotify.com/documentation/general/guides/app-settings/).
   1. Click create an app
   2. Fill form/s(maybe more than one form to fill all the required fields)
      1. `App Name`
      2. `App Description`
      3. `Redirect URIs` (you can choose whatever url you want, ie: `https://whatever-you-want.com/callback`)
      4. `Bundle IDs` (your xCode project bundle id)

    Spotify has three ways to authorize usage, we´ll use `Implicit Grant Flow`; if you want to understand the authorization process(Implicit Grant Flow) you can check more information on [Spotify](https://developer.spotify.com/documentation/general/guides/authorization-guide/#implicit-grant-flow)
1. Once created the app we need two strings to make the iOS app work:
   1. `Client id`
   2. `Redirect Uri`
2. Create a file called `"SpotifyCredentials.plist"` like the next snippet and fill with the the values `Client id` and `Redirect Uri` that you have obtained from Spotify dashboard
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>redirectUri</key>
  <string>YOUR-REDIRECT-URI</string>
  <key>clientId</key>
  <string>YOUR-CLIENT-ID</string>
</dict>
</plist>
```
5. You are ready to run the iOS app from xCode