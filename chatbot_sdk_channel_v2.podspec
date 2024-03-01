Pod::Spec.new do |s|
  s.name             = 'chatbot_sdk_channel_v2'
  s.module_name      = 'chatbot_sdk_channel_v2'


  #don't add tabs on this next line or change add spacing 
  s.version          = '2.3.4'

  s.summary          = 'Your Pod Summary'
  s.description      = 'Your Pod Description'
  s.homepage         = 'https://github.com/ShivMohan1889/chat_bot__channel2'
  s.license          = "MIT"
  s.author           = { 'Your Name' => 'shivmhnsingh@gmail.com' }
  s.platforms        = { :ios => '13.0' }
  s.source           = { :git => 'https://github.com/ShivMohan1889/chat_bot__channel2.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.vendored_frameworks = 'Frameworks/Debug/App.xcframework','Frameworks/Debug/Flutter.xcframework','Frameworks/Debug/FlutterPluginRegistrant.xcframework','Frameworks/Debug/path_provider_foundation.xcframework','Frameworks/Debug/shared_preferences_foundation.xcframework','Frameworks/Debug/sqflite.xcframework','Frameworks/Debug/url_launcher_ios.xcframework','Frameworks/Debug/webview_flutter_wkwebview.xcframework' 

end
