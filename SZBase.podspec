Pod::Spec.new do |s|
  s.name         = "SZBase"
  s.version      = "0.0.6"
  s.summary      = "SZBase 是基础工具类库"

  s.description  = <<-DESC
    SZBase是IOS开发工具类库，平时基类的
                   DESC

  s.homepage     = "https://github.com/ace2github/SZBase"
  s.license      = 'MIT'

  s.author             = { "ChaohuiChen" => "173141667@qq.com" }

  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/ace2github/SZBase.git", :tag => s.version }

 # s.source_files = 'SZBase/SZBase/Sources/**/*'

  s.default_subspec='SZBaseFoundation'

  s.subspec 'SZEasyRouter' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZEasyRouter/Core/**/*'
  end

  s.subspec 'SZWeekPool' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZWeekPool/Core/**/*'
  end

  s.subspec 'SZMultiDelegate' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZMultiDelegate/Core/**/*'
      ss.dependency 'SZBase/SZWeekPool'
  end

  s.subspec 'SZRWLock' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZRWLock/Core/**/*'
  end

  s.subspec 'SZAppLife' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZAppLife/Core/**/*'
  end

  s.subspec 'SZModule' do |ss|
      ss.source_files = 'SZBase/SZBase/Sources/SZModule/Core/**/*'
  end

  s.subspec 'SZBaseFoundation' do |ss|
     ss.dependency 'SZBase/SZWeekPool'
     ss.dependency 'SZBase/SZMultiDelegate'
     ss.dependency 'SZBase/SZEasyRouter'
     ss.dependency 'SZBase/SZRWLock'
     ss.dependency 'SZBase/SZModule'
     ss.dependency 'SZBase/SZAppLife'
  end

end