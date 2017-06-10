Pod::Spec.new do |s|
  s.name             = 'Gemini'
  s.version          = '1.0.0'
  s.summary          = 'Gemini is rich scroll animation framework for iOS, written in Swift.'
  s.description       = <<-DESC
Gemini is rich scroll animation framework for iOS, written in Swift. 

You can easily use GeminiCollectionView, which is a subclass of UICollectionView.

You are available multiple animation which has various and customizable properties, and moreover can create your own custom scroll animation.

Gemini also provide a fluent interface based on method chaining. you can use this intuitvely and simply.
                        DESC

  s.homepage         = 'https://github.com/shoheiyokoyama/Gemini'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shoheiyokoyama' => 'shohei.yok0602@gmail.com' }
  s.source           = { :git => 'https://github.com/shoheiyokoyama/Gemini.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Gemini/**/*'
end
