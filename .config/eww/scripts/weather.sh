#!/bin/sh

# IMPORTANT NOTE.
# For me in specific, trying to use my city code from OpenWeatherMap has never worked so I mainly rely on using my latitude and longitude instead, if using your city id doesn't work I recommend you try the same.
# Your City code, latitude and longitude can all be found in https://openweathermap.org/. Your key is unique to your account so go there and get one.

KEY="74742ef366fc137a9f897b400473ebc8"
CITY="683506"
LAT="x"
LON="x"

weather=$(curl -sf "api.openweathermap.org/data/2.5/weather?id=683506&appid=74742ef366fc137a9f897b400473ebc8&units=metric")
# weather=$(curl -sf "api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&appid=$KEY&units=imperial")
weather_desc=$(echo $weather | jq -r ".weather[0].main")
weather_temp=$(echo $weather | jq ".main.temp" | cut -d "." -f 1)
feels_like=$(echo $weather | jq ".main.feels_like" | cut -d "." -f 1)
humidity=$(echo $weather | jq ".main.humidity")
time=$(date '+%H')

check_if_empty() {
	if [ -z "$1" ]; then
		echo "n/a"
	else
		echo "$1"
	fi
}

check_if_empty_deg() {
	if [ -z "$1" ]; then
		echo "n/a"
	else
		echo "$1°C"
	fi
}

check_if_empty_text() {
	if [ -z "$1" ]; then
		echo "Disconnected"
	elif [ "$1" = "Clouds" ]; then
		echo "曇りです"
	elif [ "$1" = "Clear" ]; then
		echo "晴れです"
	elif [ "$1" = "Rain" ]; then
		echo "雨です"
	else
		echo $1
	fi
}

check_if_empty_icon() {
	if [ -z "$1" ]; then
		echo ""
	elif [ "$1" = "Clouds" ]; then
		if [ $time -gt 20 -o $time -lt 08 ]; then
			echo ""
		else
			echo ""
		fi
	elif [ "$1" = "Clear" ]; then
		if [ $time -gt 20 -o $time -lt 08 ]; then
			echo ""
		else
			echo ""
		fi
	elif [ "$1" = "Rain" ]; then
		if [ $time -gt 20 -o $time -lt 08 ]; then
			echo ""
		else
			echo ""
		fi
	fi
}

case $1 in
	current_temp)
		check_if_empty_deg $weather_temp ;;
	feels_like)
		check_if_empty_deg $feels_like ;;
	weather_desc)
		check_if_empty_text $weather_desc ;;
	weather_desc_icon)
		check_if_empty_icon $weather_desc ;;
	humidity)
		check_if_empty $humidity ;;
esac
