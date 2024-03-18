#
# Be sure to run `pod lib lint DPTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DPTabBar'
  s.version          = '1.0.0'
  s.summary          = 'Custom Tab Bar for iOS App'
  s.description      = <<-DESC
TODO: Custom TabBar,Flowting TabBar, Upper Corner TabBar, Bottom Corner TabBar
                       DESC

  s.homepage         = 'https://github.com/DipakPanchasara/DPTabBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { "Dipak Panchasara" => "panchasara.dipak@gmail.com" }
  s.source   = { :git => 'https://github.com/DipakPanchasara/DPTabBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'DPTabBar/Classes/**/*'
end
