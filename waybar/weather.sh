#!/bin/sh

URL=https://www.accuweather.com/en/ca/terrebonne/j7m/weather-forecast/1365413

wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
