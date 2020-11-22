Pod::Spec.new do |s|
  s.name         = "DrivenUI"
  s.version      = "0.1.1"
  s.summary      = "DrivenUI is an iOS SDK which makes introducing and building Server Driven UI feature into iOS Applications much more convenient."
  s.homepage     = "https://www.kebrahem.dev/"
  s.license      = { :type => 'Commercial', :file => 'LICENSE.md' }
  s.author       = { "DrivenUI" => "karimabdelazizmansour@gmail.com" }
  s.platform     = :ios, '13.0'
  s.source       = { :git => "https://github.com/KarimEbrahemAbdelaziz/DrivenUI.git", :tag => s.version.to_s }
  s.library      = 'z'
  s.frameworks   = 'SwiftUI', 'Security', 'UIKit'
  s.xcconfig     =  { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/DrivenUI/"' }
  s.requires_arc = true
  s.vendored_frameworks = 'DrivenUI.xcframework'
  s.preserve_paths =  'DrivenUI.xcframework/*'
end
