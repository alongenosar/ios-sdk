cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "SnappersSDK.SnappersSDK",
      "file": "plugins/SnappersSDK/www/SnappersSDK.js",
      "pluginId": "SnappersSDK",
      "clobbers": [
        "SnappersSDK"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.3",
    "cordova-plugin-add-swift-support": "1.7.2",
    "cordova-plugin-cocoapod-support": "1.6.0",
    "SnappersSDK": "0.3.2"
  };
});