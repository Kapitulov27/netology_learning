Демонстрация безопасной передачи секретов в сборку через BuildKit (env-secret) и ssh-agent без утечек в слоях.

Подготовка ssh-agent
- Запустить агент: `eval $(ssh-agent)`
- Добавить ключ: `ssh-add`

Сборка с секретами
- Экспортировать секрет в окружение (временный): `export MYSECRET=qwerty12345`
- Сборка без кеша, секрет как env, ssh проброс для git: `docker build --secret id=env_sec,env=MYSECRET -t test_secret . --ssh default --no-cache`

Проверки
- История слоёв (секрет не должен светиться): `docker history test_secret --no-trunc`
- Запустить контейнер и проверить отсутствие секрета в слое/ENV: `docker run -it --rm test_secret bash`