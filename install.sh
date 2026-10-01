#!/bin/bash

echo "🌐 Установка Matvey Chromium..."
echo ""

# Создаём папку профиля
PROFILE_DIR="$HOME/.config/matvey-chromium"
mkdir -p "$PROFILE_DIR"

echo "📁 Создаю профиль в $PROFILE_DIR"

# Создаём папку для расширений
EXTENSIONS_DIR="$PROFILE_DIR/Extensions"
mkdir -p "$EXTENSIONS_DIR"

echo "📦 Настраиваю расширения..."

# Список расширений (ID из Chrome Web Store)
declare -A EXTENSIONS=(
    ["uBlock Origin"]="cjpalhdlnbpafiamejdnhcphjbkeiagm"
    ["Dark Reader"]="eimadpbcbfnmbkopoojfekhnkhdbieeh"
    ["Enhancer for YouTube"]="enhancerforyoutube"
    ["JSON Viewer"]="gbmdgpbipfallnflgajpnbphnhibploa"
)

# Создаём конфиг для политик (для Linux)
POLICIES_DIR="/etc/opt/chromium/policies/managed"
if [ -d "/etc/opt/chromium" ]; then
    echo "🔧 Создаю политики браузера..."
    sudo mkdir -p "$POLICIES_DIR"
    sudo tee "$POLICIES_DIR/matvey-chromium.json" > /dev/null <<EOF
{
    "ExtensionInstallForcelist": [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx",
        "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://clients2.google.com/service/update2/crx"
    ],
    "BrowserThemeColor": "#1a1a1a"
}
EOF
fi

# Создаём мастер-настройки
PREFS_FILE="$PROFILE_DIR/Preferences"
cat > "$PREFS_FILE" <<EOF
{
    "browser": {
        "theme": {
            "use_system": false
        }
    },
    "dark_mode": true,
    "extensions": {
        "theme": {
            "id": "dark"
        }
    }
}
EOF

echo "✅ Настройки применены!"
echo ""
echo "🚀 Запускай браузер:"
echo "   ungoogled-chromium --user-data-dir=$PROFILE_DIR"
echo ""
echo "💡 Совет: создай алиас в ~/.bashrc:"
echo "   alias matvey-chromium='ungoogled-chromium --user-data-dir=$PROFILE_DIR'"
echo ""
echo "🎉 Готово! Приятного сёрфинга!"