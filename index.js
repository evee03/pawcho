// zaladowuje biblioteki express i os
const express = require('express');
const os = require('os');

// definiuje trase http get na glowna strone
// oraz wyswietla informacje o serwerze
const app = express();

app.get('/', (req, res) => {
  const serverIP = req.connection.localAddress;
  const serverHostname = os.hostname();
  const appVersion = process.env.VERSION;

  res.send(`
    <h1>Lab 5 Ewelina Musińska:</h1>
    <p>Server IP: ${serverIP}</p>
    <p>Hostname: ${serverHostname}</p>
    <p>Version: ${appVersion}</p>
  `);
});

// uruchamia serwer na porcie 8080
// oraz wyswietla komunikat o uruchomieniu serwera
app.listen(8080, () => {
  console.log('Listening on port 8080');
});
