Pod::Spec.new do |s|
  s.name         = "SZBase"
  s.version      = "0.0.2"
  s.summary      = "SZBase 是基础工具类库"

  s.description  = <<-DESC
    SZBase是IOS开发工具类库，平时基类的
                   DESC

  s.homepage     = "https://github.com/ace2github/SZBase"
  s.license      = 'MIT'

  s.author             = { "ChaohuiChen" => "173141667@qq.com" }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/ace2github/SZBase.git", :tag => s.version }

  s.source_files = 'SZBase/SZBase/Sources/**/*'

 # s.default_subspec='All'

 # s.subspec 'SZBase' do |ss|
 #     ss.source_files = 'SZBase/SZBase/Sources/**/*'
 # end

 # s.subspec 'All' do |ss|
 #     ss.source_files = 'SZBase/SZBase/Sources/*'
 #     ss.dependency 'SZBase/SZBase'
 # end

 # s.dependency ''
end