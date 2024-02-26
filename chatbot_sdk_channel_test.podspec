Pod::Spec.new do |s|
  s.name             = 'chatbot_sdk_channel_test'
  s.module_name      = 'chatbot_sdk_channel_test'
s.version = '1.0.6+9'
  s.summary          = 'Your Pod Summary'
  s.description      = 'Your Pod Description'
  s.homepage         = 'https://github.com/naseem123/chatbot_sdk_channel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.platforms        = { :ios => '13.0' }
s.source = '1.0.6+9' :git => 'https://github.com/naseem123/chatbot_sdk_channel.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.vendored_frameworks = 'Frameworks/Debug/App.xcframework','Frameworks/Debug/Flutter.xcframework','Frameworks/Debug/FlutterPluginRegistrant.xcframework','Frameworks/Debug/path_provider_foundation.xcframework','Frameworks/Debug/shared_preferences_foundation.xcframework','Frameworks/Debug/sqflite.xcframework','Frameworks/Debug/url_launcher_ios.xcframework','Frameworks/Debug/webview_flutter_wkwebview.xcframework' 

end
