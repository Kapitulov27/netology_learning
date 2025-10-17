FROM python:3.9-slim

# Копируем ОДНО И ТО ЖЕ приложение
COPY app.py /app.py

# Exec форма - приложение получает сигналы напрямую
ENTRYPOINT ["python", "-u", "/app.py"]

# Сборка и запуск:
# docker build -f 6.exec.Dockerfile -t test_exec .
# docker run --rm --name test_exec test_exec

# В другом терминале:
# docker exec test_exec ps aux

# time docker stop test_exec

