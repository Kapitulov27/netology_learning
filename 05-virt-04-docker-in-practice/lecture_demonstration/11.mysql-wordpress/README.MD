# WordPress + MariaDB + Nginx (compose)

## Что делает стенд
- Поднимает MariaDB 10.6.4 и WordPress (php8.2-apache) в общей сети `wordpress`.
- Nginx из локального `nginx.dockerfile` проксирует WordPress наружу на `:80`.
- Том `db_data` для базы и `wp_data` для файлов WordPress.
- Единые настройки через YAML anchors: `restart: always`, лимиты 1 CPU / 512M (резерв 256M), `env_file: .env`.
- Healthcheck WordPress по `http://127.0.0.1/wp-admin/install.php/` (интервал 10s, timeout 5s, 2 retries).
- MariaDB создаёт БД/пользователя `wordpress`, использует пароли из `.env`, `MYSQL_ROOT_HOST="%"`.
- В compose явно включён `--default-authentication-plugin=mysql_native_password` для совместимости с WordPress (для учебных целей; в реальных задачах не использовать).

## Что нужно подготовить
- Файл `.env` рядом с `compose.yaml` со значениями:
  - `MYSQL_ROOT_PASSWORD=...`
  - `MYSQL_PASSWORD=...` (пароль пользователя `wordpress`)

## Быстрый старт
- Запуск: `docker compose up -d`
- Проверка WordPress: `curl http://127.0.0.1` и проход установки.
- Состояние: `docker compose ps`
- Логи WordPress: `docker compose logs -f wordpress`
- Остановка и очистка: `docker compose down -v`

## Ручной запуск без compose (из _ docker_run.sh)
- Создать сеть: `docker network create --driver=bridge wordpress`
- MariaDB: `docker run -d --network=wordpress --hostname=db -v db_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=... -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=... mariadb:10.6.4-focal --default-authentication-plugin=mysql_native_password`
- WordPress: `docker run -d --network=wordpress --hostname=wordpress -v wp_data:/var/www/html -p 80:80 -e WORDPRESS_DB_HOST=db -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=... -e WORDPRESS_DB_NAME=wordpress wordpress:latest`

