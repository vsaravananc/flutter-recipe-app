help:
	@echo "Available commands:"
	@echo ""
	@echo "  run   - Run the Flutter application"
	@echo "  init  - Get Flutter dependencies"
	@echo "  clean - Clean the Flutter project"

run:
	flutter run
init:
	flutter pub get
clean:
	flutter clean
