Pod::Spec.new do |s|
  s.name             = 'chatbot_sdk_channel_flutter_1'
  s.module_name      = 'chatbot_sdk_channel_flutter_1'


  s.version = '1.0.20'

  s.summary          = 'ChatBots SDK CHannel'
  s.description      = 'ChatBots SDK CHannel is very good application'
  s.homepage         = 'https://github.com/naseem123/chatbot_sdk_channel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suhail T S' => 'suhail.ts-e@thinkresearch.com' }
  s.platforms        = { :ios => '13.0' }
  s.source           = { :git => 'https://github.com/naseem123/chatbot_sdk_channel.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.vendored_frameworks = 'Frameworks/Release/App.xcframework','Frameworks/Release/Flutter.xcframework','Frameworks/Release/FlutterPluginRegistrant.xcframework','Frameworks/Release/path_provider_foundation.xcframework','Frameworks/Release/shared_preferences_foundation.xcframework','Frameworks/Release/sqflite.xcframework','Frameworks/Release/url_launcher_ios.xcframework','Frameworks/Release/webview_flutter_wkwebview.xcframework'

end
