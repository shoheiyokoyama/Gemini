install-gems:
	bundle install --path vendor/bundle

lint-lib:
	bundle exec pod lib lint --allow-warnings

release-pod:
	bundle exec pod trunk push --allow-warnings