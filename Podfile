# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

flutter_application_path = './Flutter/flutter_master'
puts `cd #{flutter_application_path} && flutter clean && flutter pub get`
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'FlutterHost' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for FlutterHost
  install_all_flutter_pods(flutter_application_path)
end
