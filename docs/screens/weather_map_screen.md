# Weather Map Screen Specification

## Purpose

The Weather Map screen is an interactive location picker with weather preview.
It lets users inspect weather anywhere in the world by moving the map and
selecting coordinates.

Weatherly v1.0 does not include weather radar, animated clouds, weather layers,
RainViewer, or Mapbox Weather.

## Route

```text
/weather-map
```

## Technology

Use:

- `flutter_map`.
- OpenStreetMap tiles.
- Open-Meteo forecast API.
- Geolocation through `geolocator`.
- City naming through reverse geocoding when available.

## Entry Points

- Map button or menu item from Home.
- Optional shortcut from Cities.

## Header

Elements:

- Back button.
- Screen title: `Weather Map`.

## Map

The map shows:

- OpenStreetMap base map.
- Current user location.
- Selected point marker.
- Saved city markers.

Behavior:

- User can pan and zoom the map.
- User can tap any point to select coordinates.
- Selecting a point loads weather from Open-Meteo.
- Saved cities are shown as markers.
- Marker styling must match the Weatherly design system.

## Current Location Button

Behavior:

- Requests location permission if needed.
- Centers the map on the user location.
- Loads weather for the user location.
- Shows a clear error if permission is denied or location is unavailable.

## Weather Bottom Sheet

The bottom sheet appears after a location is selected or current location is
loaded.

Required content:

- City or location name.
- Current temperature.
- Weather condition label.
- Feels-like temperature.
- Max and min temperature.

Example:

```text
Batumi
24 degrees
Partly Cloudy
Feels like 22 degrees
27 degrees / 18 degrees
```

## Precipitation Block

Content:

- Rain start message.
- Precipitation probability.
- Precipitation amount.
- Precipitation intensity.

Example:

```text
Rain starting in 40 min
Precipitation: 1.8 mm
```

Behavior:

- If no rain is expected, show a useful dry-weather message.
- The block should reuse precipitation summary logic from Home and
  Precipitation.

## Hourly Timeline

Horizontal scroll content:

- Now.
- 10:00.
- 11:00.
- 12:00.
- 13:00.

Each hour shows:

- Temperature.
- Weather icon.
- Precipitation probability.

Behavior:

- Timeline uses the selected map point forecast.
- Items must keep stable width and scroll horizontally.

## Actions

### Save City

Adds the selected point to saved cities.

Rules:

- If reverse geocoding returns a city name, use it.
- If no city name is available, use a coordinate-based name.
- Prevent duplicate saved locations.

### View Details

Sets the selected point as the active city/location and opens Home.

Rules:

- Home should show the forecast for that selected location.
- The selected location should be cached.

## States

### Loading Map

Show map placeholder until tiles and initial state are ready.

### Loading Forecast

Keep the map visible and show loading state in the bottom sheet.

### Content

Show selected marker, weather bottom sheet, precipitation block, hourly
timeline, and actions.

### Location Permission Error

Show a clear message and keep manual map selection available.

### Forecast Error

Show retry inside the bottom sheet.

### Offline Cached

Show cached forecast for the selected point when available.

## Acceptance Criteria

- User can move the map.
- User can select any point on the map.
- App loads Open-Meteo weather for selected coordinates.
- User can save the selected point as a city.
- User can open Home details for the selected point.
- No radar, weather layer, or cloud animation is required for v1.0.
