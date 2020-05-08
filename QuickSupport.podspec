Pod::Spec.new do |s|
    s.name             = 'QuickSupport'
    s.version          = '0.0.1'
    s.summary          = 'Support framework'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
    s.description      = <<-DESC
    iOS base library for Quick development.
                         DESC
  
    s.homepage         = 'https://github.com/loda-6009/'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'brownsoo' => 'hansune@me.com' }
    s.source           = { :git => 'https://github.com/loda-6009/QuickIos6009.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '12.0'
    s.swift_versions = ['5.0']
    s.source_files = 'Classes/**/*'
  
  end