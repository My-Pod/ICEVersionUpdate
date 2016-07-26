Pod::Spec.new do |s|
s.name             = 'ICEVersionUpdate'
s.version          = '1.0.0'
s.summary          = '对版本更新的通知封装'
s.description      = <<-DESC
TODO: 对版本跟新的通知封装, 以实现在软件内部提醒用户跟新软件.
DESC

s.homepage         = 'https://github.com/My-Pod/ICEVersionUpdate'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'gumengxiao' => 'rare_ice@163.com' }
s.source           = { :git => 'https://github.com/My-Pod/ICEVersionUpdate.git', :tag => s.version.to_s }

s.ios.deployment_target = '7.0'
s.source_files = 'Classes/*.{h,m}'

end
