Демонстрация `docker history`: видны слои и переданные build-args (секреты утекут, если передавать их через `--build-arg`).

Сборка и анализ
- Собрать образ без кеша, передав аргумент: `docker build --build-arg ARG_PASSWORD_CLI=qwerty -t test_python_history . --no-cache`
- Посмотреть историю слоёв и убедиться, что ARG виден: `docker history test_python_history`
- Очистить: `docker rm -f test_python_history`