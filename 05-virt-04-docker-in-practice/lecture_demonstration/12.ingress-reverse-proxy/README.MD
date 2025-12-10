# Ingress + reverse proxy (NGINX → HAProxy)

## Архитектура стенда
- Двухслойная схема: внешний NGINX (host network) принимает трафик на `8090` и проксирует на HAProxy, далее трафик уходит на backend `172.20.0.5:5000` в bridge-сети `backend`. NGINX сохраняет реальный IP клиента через заголовки `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`, чтобы backend видел исходный адрес пользователя.
- Конфиги монтируются из : `nginx/ingress/nginx.conf`, `nginx/ingress/default.conf`, `haproxy/reverse/haproxy.cfg`.

## Сервисы
- `ingress-proxy` (NGINX):
  - `network_mode: host` — слушает `0.0.0.0:8090`.
  - Проксирует на `127.0.0.1:8080`.
  - Логи формата `proxied`, проксирует стандартные заголовки `Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`.
- `reverse-proxy` (HAProxy):
  - Слушает `*:8080` в сети `backend`.
  - Балансировка `roundrobin` на `172.20.0.5:5000`, с healthcheck `check`.

## Поток трафика
Клиент → NGINX (`8090`, host) → HAProxy (`127.0.0.1:8080`) → backend `172.20.0.5:5000` в сети `backend`.

## Быстрый старт
- Запуск: `docker compose -f proxy.yaml up -d`
- Проверка: `curl http://127.0.0.1:8090/`
- Состояние: `docker compose -f proxy.yaml ps`
- Остановка: `docker compose -f proxy.yaml down`

