# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'
inhibit_all_warnings!

plugin 'cocoapods-keys', {
  :project => "Weather",
  :keys => [
    'OpenWeatherAPIKey'
  ]}

target 'Weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Weather
  pod 'PureLayout'
  pod 'SwiftyJSON'
  pod 'MaterialComponents/Snackbar'

  target 'WeatherTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeatherUITests' do
    # Pods for testing
  end

end
