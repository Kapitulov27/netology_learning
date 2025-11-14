FROM ubuntu
RUN apt update && apt install -y iputils-ping psmisc

# Комбинация ENTRYPOINT + CMD
ENTRYPOINT ["/bin/ping"]
CMD ["ya.ru"]

# Сборка и запуск:
# docker build -f 4.Dockerfile -t test_entry_cmd_4 .
# docker run --rm --name test_entry_cmd_4 test_entry_cmd_4


# Это идеальный паттерн:
# ENTRYPOINT = фиксированное приложение
# CMD = параметры по умолчанию (легко переопределить)
