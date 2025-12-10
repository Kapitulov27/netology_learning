Демонстрация неправильного порядка слоёв в Dockerfile: изменение кода заново инвалидирует установку зависимостей и удлиняет сборку.

Сборка и запуск
- Собрать образ (при необходимости сбросить кэш добавь `--no-cache`): `docker build -t python_bad_order .`
- Запустить контейнер: `docker run -d -p 5000:5000 --name python_bad_order python_bad_order && docker ps`
- Проверить ответ: `curl http://127.0.0.1:5000`
- Остановить и удалить контейнер: `docker rm -f python_bad_order`