Pod::Spec.new do |s|
  s.name             = 'Bamboo'
  s.version          = '1.2.0'
  s.summary          = 'Auto Layout (and manual layout) in one line.'
  s.homepage         = 'https://github.com/wordlessj/Bamboo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Javier Zhang'
  s.source           = { :git => 'https://github.com/wordlessj/Bamboo.git', :tag => s.version.to_s }
  s.swift_version    = '4.2'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Source/**/*.swift'
end
