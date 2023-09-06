#!/bin/bash

while true; do
  flyingsnake /home/terraria/server/worlds/${WORLD_NAME}.wld /var/lib/nginx/html/Output.png
  datenow=$(date)
  cat > /var/lib/nginx/html/index.html << EOF
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Terraria Server Map</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/skeleton.css">
    <link rel="icon" type="image/png" href="images/favicon.png">
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="column" style="margin-top: 10%">
          <h1>Terraria Server Map</h1>
          <img src="Output.png" alt="terraria-map" width="100%">
        </div>
      </div>
      <div class="row">
        <div class="column">
          <p>Map last generated at: ${datenow}</p>
          </div>
      </div>
    </div>

  </body>
  </html>
EOF
  chown nginx /var/lib/nginx/html/index.html
  sleep 300 # TODO: Make configurable
done
