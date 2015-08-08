Pod::Spec.new do |s|
  s.name         = 'Mirmeca'
  s.version      = '0.02'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/Mirmeca/Mirmeca'
  s.authors      = { 'Solal Fitoussi' => 'solal.fitoussi@gmail.com' }
  s.summary      = 'An easy to use framework to build native iOS apps on top of the WordPress API.'
  s.source       = { :git => 'https://github.com/Mirmeca/Mirmeca.git', :tag => s.version }
  s.source_files = 'Mirmeca/*.swift'
  s.platform     = :ios, '8.0'
  s.dependency 'Alamofire', '~> 1.2'
  s.dependency 'ObjectMapper', '~> 0.12'
end