Pod::Spec.new do |s|
  s.name         = "HAPlayerView"
  s.version      = "0.1.2"
  s.summary      = "HAPlayerView manage video background."
  s.description  = <<-DESC 
  HAPlayerView is a simple class to manage typical splash or login view, with a background video managed for interfce builder.
                   DESC

  s.homepage     = "https://github.com/litoarias/HAPlayerView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Hipolito Arias" => "lito.arias.cervero@gmail.com" }
  s.social_media_url   = "https://twitter.com/soy_lito"
  s.source       = { :git => "https://github.com/litoarias/HAPlayerView.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.source_files = 'HAPlayerView/HABackgroundPlayerView.swift'
end
