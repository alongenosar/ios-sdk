
## Step 1: Initialize Snappers SDK
In www/js/index.js, add the following code to your **onDeviceReady** function. Use the token and code recieved from Snappers to initialize the SDK. **Check for errors in the callback to ensure successful initialization**
```javascript
onDeviceReady: function() {
    .
    .
    .
    SnappersSDK.identify("TOKEN","SECRET",error => {
        if(error) 
            alert(error)
    })
}
```

## Step 2: Present events-map view
Once initialized succsefully, you can present the events-map view as following:
```javascript
SnappersSDK.presentView("map",(error)=> {
    if(error) 
        alert(error)
})
```
## Step 3: Test event invitation notification:
For testing purposes only, you can mockup a broadcast invitation notification.
Ask Snappers team for an event id required by this action. 
In this example we set the notification delay parameter to 5.0 seconds. 
```javascript
 SnappersSDK.requestTestInvitation("EVENT ID",5.0, (error)=> {
    if(error)
        alert(error)
})
```
# API
```javascript
// @discussion Initialize SnappersSDK. sould be called only once before any other SDK call
// @param token account token as received from Snappers support team
// @param secret account secret as received from Snappers support team
// @param optional callback(error) finished callback
function identify(token, secret, callback)
```  
  
```javascript
// @discussion Presents Snappers view
// @param view, available options "map", "list"
// @param optional callback(error) finished callback
function presentView(view, callback)
```

```javascript
// @discussion Login via social platform
// @param method available options: .facebook and .twitter
// @param optional callback(error) finished callback
function login(method, callback)
```

```javascript
// @discussion Login via custom parameters provided by developer
// @param name display name
// @param optional id custom id 
// @param optional profilePicture path to profile picture url
// @param optional callback(error) finished callback
function loginRegisteredUser( name, id , profilePicture, callback) {
```
```javascript
// @discussion Logout
// @param optional callback(error) finished callback
function logout(callback) 
```

```javascript
// @discussion Request A mockup invitation NOTIFICATION *this is for testing purposes only
// @param eventId - Request an event id from Snappers team
// @param optional delay - The time interval in seconds before sending the notification
// @param optional callback(error) finished callback
function requestBroadcastInvitation(eventId, delay,callback) 
```
