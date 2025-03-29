# budowanie obrazu docker
# tworzenie pustego obrazu scratch jako podstawy
FROM scratch AS builder

# dodanie minimalnego systemu alpine linux
ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /

# instalacja zależności i aplikacji Node.js oraz npm
RUN apk update && \
    apk add --no-cache nodejs npm

# definiowanie zmiennej ARG dla wersji aplikacji
ARG VERSION

# ustawienie zmiennej środowiskowej VERSION
ENV VERSION=${VERSION}

# skopiowanie pliku package.json (tak, aby npm install był wykonywany tylko wtedy, gdy zmieni się package.json)
COPY ./package.json /usr/app/package.json

# ustawienie katalogu roboczego
WORKDIR /usr/app

# instalowanie zależności opisane w package.json
# (jeśli zmieni się package.json, to npm install będzie wykonywany ponownie)
RUN npm install

# dkopiowanie aplikacji index.js
COPY ./index.js /usr/app/index.js

# ustawienie portu
EXPOSE 8080

# wykorzystanie obrazu nginx
FROM nginx:alpine

# musze zainstalowac node.js w finalnym obrazie poniewaz potrzebny jest  do uruchomienia javascriptu
RUN apk add --no-cache nodejs npm

# ponownie przekazanie ARG do finalnego obrazu ponieważ
# zmienna ARG jest dostępna tylko w czasie budowy obrazu
ARG VERSION
ENV VERSION=${VERSION}

# kopiuje aplikację node.js zbudowana w pierwszym etapie
# (z katalogu roboczego /usr/app w obrazie builder)
COPY --from=builder /usr/app /usr/app

# kopiuje plik konfiguracyjny nginx.conf do katalogu konfiguracyjnego nginx
# musze ustawć nginx jako reverse proxy dla aplikacji node.js
# (port 8080 w kontenerze nginx jest mapowany na port 80 w kontenerze node.js)
COPY nginx.conf /etc/nginx/nginx.conf

# uruchamiam obie uslugi (Node.js w tle a Nginx na pierwszym planie)
CMD (cd /usr/app && node index.js &) && nginx -g "daemon off;"

# ustawiam port 80 dla nginx
EXPOSE 80

# sprawdzenie poprawności działania aplikacji
# (sprawdza, czy aplikacja Node.js działa na porcie 8080)
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1