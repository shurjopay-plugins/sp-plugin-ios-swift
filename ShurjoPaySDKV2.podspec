#
# Author: Rz Rasel
#

Pod::Spec.new do |s|
  s.name             = "ShurjoPaySDKV2"
  s.version          = "1.1.0"
  s.summary          = "ShurjoPaySDKV2 is a payment getway sdk"

  s.description      = <<-DESC
ShurjoPaySDKV2 is a payment getway sdk, very easy and useful for developer
                       DESC

  s.homepage         = "https://github.com/shurjoPay-Plugins/sp-plugin-ios-swift"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "shurjoMukhi Ltd" => "shurjomukhidev@gmail.com" }
  s.source           = { :git => "https://github.com/shurjoPay-Plugins/sp-plugin-ios-swift.git", :tag => s.version.to_s }

  s.ios.deployment_target = "10.0"

  s.source_files = "ShurjoPaySDKV2/Classes/**/*"
end
