# Wieloetapowe budowanie obrazu Docker

Zadanie prezentuje proces wieloetapowego budowania (multi-stage build) obrazu Docker, który tworzy lekką aplikację webową. Zadanie spełnia następujące wymagania:

## Wymagania dotyczące pliku Dockerfile

### Etap 1:
- Używa obrazu bazowego scratch (dowolny - może być użyty w trakcie lab, obraz alpine.)
- Buduje prostą aplikację webową wyświetlającą:
  - Adres IP serwera
  - Nazwę hosta (hostname)
  - Wersję aplikacji (przekazywaną podczas budowania)
- wersja aplikacji ma być określona w poleceniu docker build …. poprzez nadanie 
wartości zmiennej VERSION definiowanej przez instrukcje ARG. 


### Etap 2:
- Używa obrazu bazowego Nginx (dowolna wersja)
- Kopiuje aplikację z Etapu 1 do serwera HTTP
- Konfiguruje jako domyślną stronę startową
- Zawiera sprawdzanie poprawności działania (HEALTHCHECK)

## Sprawozdanie
- `Lab5 EM.pdf` - sprawozdanie z realizacji zadania

## Instrukcja użycia

### Budowanie obrazu
```bash
docker build --build-arg VERSION=1.0.0 -t lab5 .
```

### Uruchomienie kontenera
```bash
docker run -p 80:80 --name lab5
```

### Weryfikacja działania

Aplikacja dostępna jest pod adresem:
```
http://localhost:80
```

## Weryfikacja funkcjonalności

Aplikacja wyświetla:
- Adres IP serwera
- Nazwę hosta
- Wersję aplikacji (przekazaną podczas budowania)

## Dokumentacja

https://docs.docker.com/build/building/multi-stage/

https://www.alpinelinux.org/downloads/

https://docs.docker.com/build/building/base-images/

https://hub.docker.com/_/scratch

https://docs.docker.com/engine/reference/builder/#healthcheck 

https://nginx.org/en/docs/ngx_core_module.html

https://nginx.org/en/docs/stream/ngx_stream_proxy_module.html#proxy_pass


