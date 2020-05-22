## Установка

### Linux

Клонирование репозитория:

```bash
$ git clone https://github.om/gradergage/elcom-telemetry
$ cd elcom-telemetry
```

Копирование базы данных PostgreSQL (postgres@postgres):

```bash
$ sudo -u postgres -i
...
$ psql telemtry < db/telemetry_localhost-dump.sql
```

Настройки сервера, указать необходимый IP:

`src/main/resources/application.properties`

Сборка:

```bash
$ chmod +x gradlew
$ ./gradlew bootJar
```

Запуск:

```bash
$ java -jar /build/libs/filename.jar
```

## Миграция db

https://flywaydb.org/documentation/ При внесении изменений в структуру БД,
создать скрипт в папке src/main/resources/db/migration между версией и описанием
должно быть обязательно два нижних подчёркивания.

### gradle tasks:

- flywayBaseline - для подключений существующей БД к flyway
- flywayMigrate - для миграции изменений из скриптов папки migration в базу
  данных

## Описание REST API

### Внешние (используемые устройством)

#### `POST /api/add/measures`

**Тело запроса:** json пакет с измерениями Описание пакета в doc/117-packet.docx

Пример:
`{"h":"0200430058040043005104004300432260000001", "d":["000110235EA2F5090000000000001000"]}`

**Ответ:** Версия прошивки и статус

```bash
{
    "version": 1,
    "status": 200
}
```

#### `GET /api/add/filesize`

**Параметры:**

- uid - hardware id устройства

**Ответ:** число u32 - размер файла прошивки для данного устройства в байтах
35421

#### `POST /api/add/getFile`

**Тело запроса:** json пакет с указанием from to позиций байт из файла прошивки

Пример:
`{"h":"0200430058040043005104004300432260000001", "d":["000110235EA2F5090000000000001000"]}`

**Ответ:** json файл с данными прошивки в кодировке utf-8

```bash
{
    "crc": 0,
    "data": "00...08",
    "status": 200
}
```

#### `GET /api/time`

**Ответ:** Время сервера в формате

```json
{
  "timestamp": 1588162827990,
  "status": 200
}
```
