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

## Описание REST API
### Внешние (используемые устройством)


#### `POST /api/add/measures`

#### `POST /api/add/getFile`

#### `GET /api/add/time`
возвращает время сервера в формате 
```json 
{
    "timestamp": 1588162827990,
    "status": 200
}
```

#### `POST /api/add/filesize`


### Внутренние

* `POST /api/add/systems`
  * 
* `POST /api/add/devices`
  * 
