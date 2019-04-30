var exec = require('cordova/exec');
exports.getVersion = function (callback) {
    exec( 
     result => { if(callback) callback(result)},
     error => { if(callback) callback(error['error'])},
    'SnappersSDK','getVersion',[]
    )
}
exports.identify = function (token,secret, callback) {
    exec( 
     result => { if(callback) callback(null)},
     error => { if(callback) 
        callback(error['error'])},
    'SnappersSDK','identify',[token,secret]
    )
}
exports.presentView = function (type, callback) {
    exec( 
        result => { if(callback) callback(null)},
        error => {  if(callback) callback(error['error'])},
        'SnappersSDK','presentView',[type]
        )
}
exports.logout = function (callback) {
    exec( 
        result => { if(callback) callback(null)},
        error => {  if(callback) callback(error['error'])},
        'SnappersSDK','logoutUser',[]
        )
}
exports.socialLogin = function (type,callback) {
    exec( 
        result => { if(callback) callback(null)},
        error => {  if(callback) callback(error['error'])},
        'SnappersSDK','socialLogin',[type]
        )
}
exports.requestTestInvitation = (eventId,delay,callback) => {
   exec(
       result => { if(callback) callback(null)},
       error => {  if(callback) callback(error['error'])},
       'SnappersSDK','requestTestInvitation',[eventId,delay]
       )
}
exports.registeredUserLogin = (name,id,profileImageURL,callback) => {
   exec(
       result => { if(callback) callback(null)},
       error => { if(callback) callback(error['error'])},
       'SnappersSDK','registeredUserLogin',[name,id,profileImageURL]
       )
}

