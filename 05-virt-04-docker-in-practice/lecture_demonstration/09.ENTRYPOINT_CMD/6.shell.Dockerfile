FROM python:3.9-slim

# Копируем ОДНО И ТО ЖЕ приложение (как в 6.exec.Dockerfile)
COPY app.py /app.py

# Shell форма - shell блокирует сигналы!
ENTRYPOINT python -u /app.py

# Сборка и запуск:
# docker build -f 6.shell.Dockerfile -t test_shell .
# docker run --rm --name test_shell test_shell

# В другом терминале:
# docker exec test_shell ps aux

# time docker stop test_shell