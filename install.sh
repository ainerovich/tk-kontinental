#!/bin/bash
# Быстрая установка лендинга Континенталь

echo "🚀 Установка сайта tk-kontinental.com"

# Останавливаем старые процессы
pkill -f 'python.*http.server.*80' 2>/dev/null || true
pkill -f 'SimpleHTTPServer' 2>/dev/null || true

# Проверяем Python
if ! which python3 >/dev/null; then
    echo "❌ Python3 не найден! Установите: apt install python3"
    exit 1
fi

# Запускаем сервер
cd "$(dirname "$0")"
echo "📁 Рабочая директория: $(pwd)"
echo "📄 Файлы:"
ls -lh

echo ""
echo "🔥 Запускаю сервер на порту 80..."
nohup python3 -m http.server 80 > /tmp/tk-server.log 2>&1 &
PID=$!

sleep 2

# Проверяем
if ps -p $PID > /dev/null; then
    echo "✅ Сервер запущен! PID: $PID"
    echo "🌐 Сайт доступен:"
    echo "   http://$(hostname -I | awk '{print $1}')"
    echo "   http://151.247.209.203"
    echo ""
    echo "📋 Логи: tail -f /tmp/tk-server.log"
    echo "🛑 Остановить: kill $PID"
else
    echo "❌ Ошибка запуска! Проверьте логи: cat /tmp/tk-server.log"
    exit 1
fi
