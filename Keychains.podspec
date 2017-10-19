Pod::Spec.new do |s|
  s.name             = "Keychains"
  s.summary          = "A keychain wrapper that is so easy to use that your cat could use it."
  s.version          = "1.0.0"
  s.homepage         = "https://github.com/hyperoslo/Keychains"
  s.license          = 'MIT'
  s.author           = { "Hyper Interaktiv AS" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/Keychains.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.requires_arc = true
  s.ios.source_files = 'Source/{iOS,Shared}/**/*'
  s.osx.source_files = 'Source/{Mac,Shared}/**/*'

  s.frameworks = 'Foundation'
  s.frameworks = 'Security'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
