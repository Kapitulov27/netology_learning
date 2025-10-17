FROM ubuntu
RUN apt update && apt install -y iputils-ping psmisc

# Только CMD (exec форма)
CMD ["/bin/ping", "ya.ru"]

# Сборка и запуск:
# docker build -f 2.Dockerfile -t test_entry_cmd_2 .
# docker run --rm --name test_entry_cmd_2 test_entry_cmd_2


# Разница с ENTRYPOINT:
# CMD легко перезаписывается любым аргументом docker run
# ENTRYPOINT требует флаг --entrypoint для замены
