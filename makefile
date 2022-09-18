flutter_generate:
	flutter packages pub run build_runner build --verbose --delete-conflicting-outputs

flutter_build_runner:
	flutter packages get && \
    flutter packages pub run build_runner build --delete-conflicting-outputs