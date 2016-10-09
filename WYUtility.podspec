
Pod::Spec.new do |s|
  s.name             = 'WYUtility'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WYUtility.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/WYUtility'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wenyou' => 'thisfin@gmail.com' }
  s.source           = { :git => 'https://github.com/WYUtility/WYUtility.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WYUtility/**/*'
  
  # s.resource_bundles = {
  #   'WYUtility' => ['WYUtility/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
