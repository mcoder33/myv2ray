# myv2ray

Практичный и минималистичный репозиторий для развёртывания **V2Ray** в Docker:  
серверная часть + клиентская часть, с использованием Docker Compose, Nginx и наглядной структуры конфигураций.
Работает с транспортами TCP и WebSocket.

---

## Структура репозитория

```text
.
├── config/                     # Конфигурации V2Ray (server / client)
├── docker-compose.server.yml   # Docker Compose для сервера
├── docker-compose.client.yml   # Docker Compose для клиента
├── nginx.conf                  # Конфигурация Nginx (reverse proxy)
├── init.sh                     # Скрипт первичной инициализации
├── .env.example                # Пример переменных окружения
└── README.md
```

---

## Требования

- Docker Engine
- Docker Compose v2 (`docker compose`)
- Linux / macOS
- (для сервера) домен и TLS-сертификаты — если используется TLS через Nginx

---

## Подготовка

Клонирование репозитория:

```bash
git clone https://github.com/mcoder33/myv2ray.git
cd myv2ray
```

Создание файла окружения:

```bash
cp .env.example .env
```

Отредактируйте `.env` под свои значения  
(порты, UUID, домены и прочие параметры).

> `.env` **не должен** коммититься в репозиторий.

---

## Инициализация - нужно запустить чтобы создался конфиг для клиена/сервера

```bash
bash init.sh
```

---

## Запуск сервера

```bash
docker compose -f docker-compose.server.yml up -d
```

Проверка:

```bash
docker ps
docker compose -f docker-compose.server.yml logs -f
```

---

## Запуск клиента

```bash
docker compose -f docker-compose.client.yml up -d
```

Логи клиента:

```bash
docker compose -f docker-compose.client.yml logs -f
```

---

## Конфигурация

### V2Ray

Все основные параметры находятся в директории `config/`:
- протоколы
- UUID / ключи
- inbound / outbound
- маршрутизация
- WebSocket / TCP / TLS

Конфиги сервера и клиента должны **строго соответствовать друг другу**.

---

### Nginx

Файл `nginx.conf` используется как reverse proxy:
- проксирование WebSocket
- TLS-терминация
- проброс трафика к V2Ray

---

## Обновление

```bash
git pull
docker compose -f docker-compose.server.yml up -d --force-recreate
docker compose -f docker-compose.client.yml up -d --force-recreate
```

---

## Диагностика

Если соединение не работает, проверьте:
1. Порты и firewall
2. UUID и пути
3. Конфигурацию Nginx
4. DNS
5. Логи контейнеров

---

## Лицензия

Лицензия не задана.
