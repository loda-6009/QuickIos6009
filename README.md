# QuickIos6009

1. 워크스페이스 프로젝트를 만든 다음에 QuickIosSupport 프로젝트를 포함시킨다. 
2. Podfile 에 의존성 추가 ( RxSwift, ReSwift 를 같이 추가해줌 )

```
def rx_pods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
end

def rx_test_pods
  pod 'RxBlocking', '~> 5'
  pod 'RxTest', '~> 5'
end

def re_pods
  pod 'ReSwift'
  pod 'ReSwiftConsumer'
end

target 'QuickSupport' do
	project '../QuickIos6009/QuickSupport.xcodeproj'
	rx_pods
	re_pods

	target 'QuickSupportTests' do
		inherit! :search_paths
		rx_test_pods
	end
end	
```
