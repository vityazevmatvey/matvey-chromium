#!/bin/bash

echo "🌐 Установка Matvey Chromium..."
echo ""

# Создаём папку профиля
PROFILE_DIR="$HOME/.config/matvey-chromium"
mkdir -p "$PROFILE_DIR/Default"

echo "📁 Создаю профиль в $PROFILE_DIR"

# Копируем главную страницу
echo "🏠 Устанавливаю главную страницу..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/index.html" "$PROFILE_DIR/homepage.html"

# Создаём Preferences с настройками
PREFS_FILE="$PROFILE_DIR/Default/Preferences"
cat > "$PREFS_FILE" <<'PREFS'
{
    "homepage": "file:///HOME/.config/matvey-chromium/homepage.html",
    "homepage_is_newtabpage": false,
    "browser": {
        "show_home_button": true
    },
    "default_search_provider": {
        "name": "Yandex",
        "search_url": "https://ya.ru/search/?text={searchTerms}",
        "suggest_url": "https://suggest.yandex.ru/suggest-ff.cgi?part={searchTerms}"
    },
    "default_search_provider_data": {
        "template_url_data": {
            "keyword": "ya.ru",
            "short_name": "Yandex"
        }
    },
    "session": {
        "restore_on_startup": 4,
        "startup_urls": ["file:///HOME/.config/matvey-chromium/homepage.html"]
    },
    "dark_mode": true,
    "extensions": {
        "theme": {
            "use_system": false
        }
    }
}
PREFS

# Заменяем HOME на реальный путь
sed -i "s|/HOME|$HOME|g" "$PREFS_FILE"

echo "🔍 Настраиваю Яндекс как поисковую систему..."

# Создаём Local State
LOCAL_STATE="$PROFILE_DIR/Local State"
cat > "$LOCAL_STATE" <<'STATE'
{
    "browser": {
        "enabled_labs_experiments": ["dark-mode"]
    }
}
STATE

# Создаём алиас для удобства
ALIAS_CMD="alias matvey-chromium='ungoogled-chromium --user-data-dir=$PROFILE_DIR'"
BASHRC="$HOME/.bashrc"

if ! grep -q "matvey-chromium" "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "# MatveyBrowser" >> "$BASHRC"
    echo "$ALIAS_CMD" >> "$BASHRC"
    echo "💾 Добавил алиас в ~/.bashrc"
fi

echo ""
echo "✅ Установка завершена!"
echo ""
echo "🚀 Запуск:"
echo "   matvey-chromium"
echo ""
echo "   или"
echo ""
echo "   ungoogled-chromium --user-data-dir=$PROFILE_DIR"
echo ""
echo "📝 Перезагрузи терминал или выполни:"
echo "   source ~/.bashrc"
echo ""
echo "🎉 Приятного сёрфинга!"