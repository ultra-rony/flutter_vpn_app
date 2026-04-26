.PHONY: clean get build all

clean:
	@echo "🧹 Очистка проекта..."
	flutter clean

get:
	@echo "📦 Установка зависимостей..."
	flutter pub get

build:
	@echo "⚙️ Генерация кода..."
	flutter pub run build_runner build --delete-conflicting-outputs

all: clean get build
	@echo "✅ Готово!"