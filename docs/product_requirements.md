# Weatherly Product Requirements

## Product Goal

Weatherly is a premium mobile weather app that helps users quickly understand
the current weather, upcoming rain, hourly forecast, weekly forecast, air
quality, map-selected location weather, and practical daily recommendations.

The app should feel polished, calm, and useful. It should avoid the default
Material look and use a dark glassmorphism style as the primary experience.

## Target Users

- Users who check the weather before leaving home.
- Users who care about rain timing and intensity.
- Users who want a clean Apple Weather-like experience on Flutter.
- Portfolio reviewers evaluating product thinking, UI quality, architecture,
  and API integration.

## Core Product Principles

- Show the most important weather answer immediately.
- Treat precipitation as a first-class feature.
- Use clear human language instead of raw numbers where possible.
- Keep the interface visually premium but not decorative.
- Make every screen useful, scannable, and consistent.

## MVP Scope

The MVP includes:

- Current weather for the selected city.
- Current location weather.
- Rain alert card.
- Smart recommendation card.
- Hourly forecast section.
- Detailed precipitation screen.
- 7-day forecast.
- Weather metrics: humidity, wind, UV index, AQI, sunrise, sunset.
- Interactive Weather Map for selecting any location on OpenStreetMap.
- Forecast preview for the selected map point.
- Saving a selected map point as a city.
- City search and saved cities.
- Settings for units, theme, and refresh behavior.
- Language setting.
- Local caching for the last loaded forecast.
- Native ad placement.
- Loading, error, empty, and offline states.

## v1.0 Screens

Weatherly v1.0 includes these standalone screens:

1. Home.
2. Precipitation.
3. Weather Map.
4. Cities.
5. Settings.

Hourly forecast, 7-day forecast, AQI, and UV Index are part of v1.0, but they
are presented as Home and Weather Map content instead of standalone screens.

## Not Included in v1.0

- Weather radar.
- Animated cloud movement.
- RainViewer.
- Weather map layers.
- Mapbox Weather.
- Push notifications for rain alerts and severe weather.
- Home widgets.
- Premium subscription.
- Authorization.
- Precipitation maps.
- Complex weather animations.
- Apple Watch support.
- WearOS support.

## Roadmap

### v1.0

- Current weather.
- Hourly forecast.
- 7-day forecast.
- Precipitation timeline.
- AQI.
- UV Index.
- Multi-city support.
- Weather Map as an interactive location picker.
- Offline cache.
- Ads.

### v1.1

- Weather layers.
- Cloud layer.
- Temperature layer.
- Wind layer.

### v1.2

- Animated radar.
- Rain notifications.
- Home widgets.
- Premium subscription.

## API

Use Open-Meteo as the primary weather provider.

Use `flutter_map` with OpenStreetMap tiles for the Weather Map. The map is used
for selecting locations, not for radar or weather overlays in v1.0.

Required Open-Meteo data:

- Current weather.
- Hourly forecast.
- Daily forecast.
- Precipitation probability.
- Precipitation amount.
- Air quality data.
- Sunrise and sunset.
- UV index.
- Wind speed and direction.

Use geocoding for city search and reverse geocoding.

## Main User Flows

### Open App

1. App loads the saved city or current location.
2. App shows cached weather immediately if available.
3. App refreshes data from the network.
4. Home screen updates with a subtle fade and scale animation.

### Check Rain

1. User sees a rain alert card on the Home screen.
2. User taps the card.
3. App opens the Precipitation screen.
4. User sees rain start time, intensity chart, intervals, and total amount.

### Change City

1. User opens Cities.
2. User searches for a city.
3. User selects a result.
4. App saves the city and opens its weather.

### Check Air Quality

1. User sees AQI summary on the Home screen.
2. User reads AQI value and label directly in the Home metric section.
3. Detailed standalone AQI screen is not part of v1.0.

### Select Location on Map

1. User opens Weather Map.
2. User pans or zooms the OpenStreetMap map.
3. User taps a point on the map.
4. App loads Open-Meteo forecast for the selected coordinates.
5. Bottom sheet shows current weather, precipitation, and hourly timeline.
6. User can save the selected point as a city or view it on Home.

## Home Screen Content Order

1. Top navigation: menu, city/date, search.
2. Current weather hero.
3. Rain alert card.
4. Smart recommendation card.
5. Hourly forecast preview.
6. Precipitation preview.
7. 7-day forecast.
8. Weather metric cards.
9. Native ad placement.

## Smart Recommendation Examples

Rain recommendation:

```text
Take an umbrella
Rain starts in 40 minutes. Around 15 mm of precipitation is expected.
```

Walking recommendation:

```text
Good time for a walk
No precipitation until 18:00. Comfortable temperature: 24 degrees.
```

AQI recommendation:

```text
Air quality is good
AQI is 42. Outdoor activity is comfortable for most people.
```

## Functional Requirements

- The app must support dark and light themes.
- Dark theme must be the default.
- The app must support Celsius and Fahrenheit.
- The app must support km/h, m/s, and mph wind units.
- The app must support app language selection.
- The app must support manual refresh.
- The app must allow selecting any point on the Weather Map.
- The app must load forecast data for selected map coordinates.
- The app must allow saving a selected map point as a city.
- The app must cache the last successful weather response.
- The app must show cached data when offline.
- The app must support native ad placement in the Home feed.
- The app must expose clear error states for location, network, and API errors.
- The app must not require login.

## Non-Functional Requirements

- First useful paint should happen from cache when available.
- Network requests should be cancellable when changing city quickly.
- UI should remain usable on small phones.
- Text must not overflow cards or buttons.
- Charts must be readable in both themes.
- Animations should be smooth and short.
- The app should be built with testable business logic.

## Acceptance Criteria

- A user can open the app and understand current weather in under 5 seconds.
- A user can understand whether rain is coming without opening details.
- A user can open precipitation details from the Home screen.
- A user can select a location on Weather Map and see its forecast.
- A user can save a selected map location as a city.
- A user can search, add, select, and remove cities.
- A user can switch units and theme.
- A user can switch app language.
- The app works with cached weather when offline.
- All MVP screens have loading, error, empty, and content states.
