Демонстрация multistage: сборочные зависимости остаются в stage builder, финальный образ меньше и без мусора.

Сборка и запуск
- Собрать без кеша: `docker build -t test_python_multistage . --no-cache`
- Запустить: `docker run -d -p 5000:5000 --name test_python_multistage test_python_multistage`
- Проверить контейнер: `docker ps`
- Проверить ответ: `curl http://127.0.0.1:5000`
- При необходимости зайти: `docker exec -it test_python_multistage ash`
- Очистить: `docker rm -f test_python_multistage`
- Сравнить размеры образов: `docker images | grep test_python`