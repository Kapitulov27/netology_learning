Namespaces изолируют ресурсы между процессами. Контейнер - это обычный процесс с ограниченным набором ресурсов; за изоляцию отвечают Linux Namespaces: своя сеть, процессы, ФС, лимиты.

Ключевые типы namespaces:
- PID: изоляция идентификаторов процессов (одинаковые PID в разных пространствах допустимы).
- Network: отдельные интерфейсы, маршруты, DHCP.
- Mount: изоляция точек монтирования.
- User: изоляция UID/GID, запуск с пониженными привилегиями.
- UTS: отдельное имя хоста/домена.
- Time: изоляция системных часов и таймеров.

Полезные команды
- Просмотр активных namespaces: `lsns`
- Очистка всех контейнеров: `docker rm -f $(docker ps -a -q)`
- Старт ограниченного контейнера: `docker run -d --name ns_nginx --cpus=".1" --memory="32m" nginx`
- Получить PID главного процесса nginx: `pid=$(ps aux | grep "[n]ginx -g" | awk '{print $2}') && echo $pid`
- Зайти в UTS namespace процесса: `sudo nsenter --target $pid --uts` →→ `hostname` →→ `hostname 555`
- Проверить лимиты cgroup внутри контейнера: `docker exec -it ns_nginx bash -c "cat /sys/fs/cgroup/cpu.max && cat /sys/fs/cgroup/memory.max"`
- Перевести лимит памяти в МБ: `echo $((33554432/1024/1024))` →→ `32`