Разбор образа: сборка с BuildKit secret, анализ слоёв через Dive, ручное вскрытие tarball из `docker image save`.

Подготовка
- Запусти агент: `eval $(ssh-agent)`; добавь ключ: `ssh-add`
- Экспортируй секрет: `export MYSECRET=qwerty12345`
- Собери образ без кеша с env-secret: `docker build --secret id=env_sec,env=MYSECRET -t test_extract . --no-cache`

Анализ через Dive
- Локально установленный Dive: `dive test_extract`
- Через контейнер (долго стартует): `docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive test_extract`

Ручное вскрытие образа
- Сохранить образ в tar: `docker image save -o /tmp/image.tar.gz test_extract`
- Распаковать: `tar xf /tmp/image.tar.gz`
- Перейти в слои: `cd blobs/sha256`
- Пример digest слоя: `sha256:f8194172658e9ce6e7923639c5ebd4f77a8a7a2b44b1e1462a110f793c17c280`
- Распаковать слой: `tar xf f8194172658e9ce6e7923639c5ebd4f77a8a7a2b44b1e1462a110f793c17c280`