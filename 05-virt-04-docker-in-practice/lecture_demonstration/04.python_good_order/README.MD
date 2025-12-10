Демонстрация правильного порядка слоёв в Dockerfile: зависимые слои (установка пакетов) кешируются, изменения кода не трогают слои с зависимостями — сборка быстрее.

Сборка и запуск
- Собрать образ: `docker build -t test_python_good_order .`
- Запустить с переменной окружения: `docker run -d -p 5000:5000 --name test_python_good_order -e TEST_STRING="Netology" test_python_good_order`
- Проверить контейнер: `docker ps`
- Проверить ответ: `curl http://127.0.0.1:5000`
- При необходимости войти внутрь: `docker exec -it test_python_good_order bash`
- Остановить и удалить контейнер: `docker rm -f test_python_good_order`