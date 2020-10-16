#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_txugcupload.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_txugcupload'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AFNetworking'
  s.vendored_framework = [
    "Classes/upload/COSSDK/QCloudCore.framework",
    "Classes/upload/COSSDK/QCloudCOSXML.framework"
  ]
  s.vendored_libraries = [
    "Classes/upload/COSSDK/libmtasdk.a",
  ]
  s.ios.framework = ['CoreTelephony', 'SystemConfiguration']
  s.ios.library = 'c++'

  s.platform = :ios, '9.0'

  # # Flutter.framework does not contain a i386 slice.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.static_framework = true
end
