# Created by Rz Rasel on 2022-05-10

Pod::Spec.new do |s|
  s.name             = "ShurjopaySdk"
  s.version          = "1.1.0"
  s.summary          = "shurjopaySdk is a payment getway sdk"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don"t worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
shurjoPaySdk is a payment getway sdk, very easy and useful for developer
                       DESC

  s.homepage         = "https://github.com/shurjoPay-Plugins/ios-swift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "shurjoMukhi Ltd" => "shurjomukhidev@gmail.com" }
  s.source           = { :git => "https://github.com/rzrasel/office-sm-ios-swift-shurjopay-sdk-v2.git", :tag => s.version.to_s }
  # s.social_media_url = "https://twitter.com/<TWITTER_USERNAME>"

  #s.ios.deployment_target = "9.0"
  s.ios.deployment_target = "13.0"
  s.swift_version = "5.0"

  s.source_files = "ShurjopaySdk/Classes/**/*"
  
  # s.resource_bundles = {
  #   "ShurjopaySdk" => ["ShurjopaySdk/Assets/*.png"]
  # }

  # s.public_header_files = "Pod/Classes/**/*.h"
  # s.frameworks = "UIKit", "MapKit"
  # s.dependency "AFNetworking", "~> 2.3"
end
