# Weatherly Architecture Specification

## Architecture Goal

Weatherly v1.0 should use a practical Clean Architecture structure with a
strong design system first, then core infrastructure, then feature modules.

The main rule: do not start screen implementation before design tokens, themes,
and reusable UI kit components exist.

## Recommended Packages

### State, Routing, UI, and DI

```yaml
flutter_bloc
go_router
get_it
fl_chart
flutter_map
latlong2
google_fonts
phosphor_flutter
google_mobile_ads
```

### Networking, Location, Cache, and Formatting

```yaml
dio
hive
hive_flutter
geolocator
geocoding
intl
```

### Models and Utilities

```yaml
equatable
freezed_annotation
json_annotation
```

### Development

```yaml
build_runner
freezed
json_serializable
very_good_analysis
mocktail
bloc_test
```

## External Services

Use Open-Meteo:

- Weather Forecast API.
- Geocoding API.
- Air Quality API.

Use OpenStreetMap tiles through `flutter_map` for map rendering.

Weatherly v1.0 does not use radar providers, RainViewer, Mapbox Weather,
weather layers, or animated cloud layers.

## Suggested Folder Structure

```text
lib/
  main.dart
  app/
    weatherly_app.dart
    router/
      app_router.dart
      route_names.dart
    di/
      service_locator.dart
  design_system/
    tokens/
      app_colors.dart
      app_spacing.dart
      app_radius.dart
      app_typography.dart
      app_shadows.dart
      app_gradients.dart
    theme/
      weatherly_dark_theme.dart
      weatherly_light_theme.dart
    widgets/
      weather_card.dart
      weather_metric_card.dart
      hourly_forecast_item.dart
      daily_forecast_tile.dart
      rain_alert_card.dart
      precipitation_chart.dart
      city_tile.dart
      loading_state.dart
      error_state.dart
      empty_state.dart
  core/
    network/
      dio_client.dart
      network_info.dart
    errors/
      failure.dart
      network_failure.dart
      location_failure.dart
      cache_failure.dart
      api_failure.dart
    location/
      location_service.dart
    cache/
      hive_service.dart
    utils/
      date_formatter.dart
      coordinate_formatter.dart
      unit_converter.dart
      weather_code_mapper.dart
  features/
    weather/
      domain/
        entities/
          weather.dart
          current_weather.dart
          hourly_weather.dart
          daily_weather.dart
          precipitation.dart
          air_quality.dart
        repositories/
          weather_repository.dart
        usecases/
          get_weather_by_coordinates.dart
          get_weather_by_city.dart
          get_current_location_weather.dart
      data/
        datasources/
          open_meteo_weather_remote_data_source.dart
          open_meteo_air_quality_remote_data_source.dart
          weather_local_data_source.dart
        models/
          weather_response_model.dart
          air_quality_model.dart
        repositories/
          weather_repository_impl.dart
      presentation/
        bloc/
          weather_bloc.dart
          weather_event.dart
          weather_state.dart
        screens/
          home_screen.dart
          precipitation_screen.dart
          weather_map_screen.dart
        widgets/
    cities/
      domain/
        entities/
          city.dart
        repositories/
          city_repository.dart
        usecases/
          search_cities.dart
          save_city.dart
          remove_city.dart
          get_saved_cities.dart
          set_selected_city.dart
      data/
        datasources/
          open_meteo_geocoding_remote_data_source.dart
          cities_local_data_source.dart
        models/
          city_model.dart
        repositories/
          city_repository_impl.dart
      presentation/
        bloc/
          cities_bloc.dart
          cities_event.dart
          cities_state.dart
        screens/
          cities_screen.dart
    settings/
      domain/
        entities/
          app_settings.dart
        repositories/
          settings_repository.dart
        usecases/
          get_settings.dart
          update_settings.dart
      data/
        datasources/
          settings_local_data_source.dart
        models/
          settings_model.dart
        repositories/
          settings_repository_impl.dart
      presentation/
        cubit/
          settings_cubit.dart
        screens/
          settings_screen.dart
    ads/
      ads_service.dart
```

## Implementation Order

### Stage 1: Design Tokens

Create:

- `AppColors`.
- `AppSpacing`.
- `AppRadius`.
- `AppTypography`.
- `AppShadows`.

### Stage 2: Themes

Create:

- `WeatherlyDarkTheme`.
- `WeatherlyLightTheme`.

Dark theme is the default.

### Stage 3: UI Kit

Create reusable components before feature screens:

- `WeatherCard`.
- `WeatherMetricCard`.
- `HourlyForecastItem`.
- `DailyForecastTile`.
- `RainAlertCard`.
- `PrecipitationChart`.
- `CityTile`.

### Stage 4: Core

Create:

- `DioClient`.
- `Failure`.
- `NetworkFailure`.
- `LocationFailure`.
- `LocationService`.
- `HiveService`.

### Stage 5: Features

Implement:

- `weather`.
- `cities`.
- `settings`.
- `ads`.

## Layer Rules

### Presentation

Responsibilities:

- Render screens and widgets.
- Own BLoC and Cubit state.
- Convert domain entities into view data.
- Handle user interactions and navigation.

Rules:

- Do not call Dio directly.
- Do not parse API responses.
- Do not store business rules inside widgets.

### Domain

Responsibilities:

- Define entities.
- Define repository contracts.
- Implement use cases.
- Hold business rules such as rain summaries, AQI labels, and unit conversion
  decisions when they are not purely presentational.

Rules:

- No Flutter imports.
- No Dio imports.
- No Hive imports.

### Data

Responsibilities:

- Fetch data from Open-Meteo.
- Cache weather, cities, and settings through Hive.
- Map API models into domain entities.
- Handle local and remote data source coordination.

Rules:

- API response models stay in the data layer.
- Domain entities should not depend on JSON annotations.

## Core Services

### DioClient

Owns:

- Base Dio configuration.
- Timeouts.
- Logging for debug builds.
- API error conversion.

### LocationService

Owns:

- Location permission checks.
- Current position loading.
- Location unavailable handling.

### HiveService

Owns:

- Opening Hive boxes.
- Reading and writing cached weather.
- Reading and writing saved cities.
- Reading and writing selected city.
- Reading and writing app settings.

## Main Domain Entities

### Weather

Contains:

- City or coordinate-based location.
- Current weather.
- Hourly forecast.
- Daily forecast.
- Precipitation summary.
- Air quality summary.
- Weather metrics.
- Map coordinates.
- Last updated date.
- Source metadata.

### CurrentWeather

Contains:

- Temperature.
- Feels-like temperature.
- Condition code.
- Condition label.
- Weather icon key.
- Wind speed.
- Humidity.
- UV index.
- AQI.
- Sunrise.
- Sunset.

### HourlyWeather

Contains:

- Date and time.
- Temperature.
- Condition.
- Precipitation probability.
- Precipitation amount.
- Wind speed.

### DailyWeather

Contains:

- Date.
- Min temperature.
- Max temperature.
- Condition.
- Precipitation probability.
- UV index.
- Sunrise.
- Sunset.

## Repository Contracts

### WeatherRepository

Required methods:

- `getWeatherByCoordinates(double latitude, double longitude)`.
- `getWeatherByCity(String cityName)`.
- `getCurrentLocationWeather()`.
- `getCachedWeather(String cacheKey)`.

### CityRepository

Required methods:

- `searchCities(String query)`.
- `getSavedCities()`.
- `saveCity(City city)`.
- `removeCity(City city)`.
- `setSelectedCity(City city)`.
- `getSelectedCity()`.

### SettingsRepository

Required methods:

- `getSettings()`.
- `updateSettings(AppSettings settings)`.

## State Management

### WeatherBloc

Owns:

- Selected city weather.
- Selected map point weather.
- Home weather content.
- Precipitation details.
- Hourly forecast.
- 7-day forecast.
- Weather Map forecast preview.
- Refresh state.
- Cached/offline state.

### CitiesBloc

Owns:

- Saved cities.
- Search query.
- Search results.
- Selected city changes.

### SettingsCubit

Owns:

- Theme mode.
- Temperature unit.
- Wind unit.
- Precipitation unit.
- Language.
- Refresh settings.

## Routing

Use `go_router`.

Routes:

```text
/home
/precipitation
/weather-map
/cities
/settings
```

Navigation rules:

- Home is the default route.
- Rain card opens `/precipitation`.
- Weather Map entry opens `/weather-map`.
- Search icon opens `/cities`.
- Settings opens `/settings`.
- Hourly forecast and AQI are v1.0 sections, not standalone routes.

## Caching

Use Hive for:

- Last successful weather response per city.
- Last successful weather response for selected map coordinates.
- Saved cities.
- Selected city.
- App settings.

Cache rules:

- Show cached weather first when available.
- Refresh in background.
- Mark UI as offline when network fails but cache exists.
- Show error state when no cache and network fails.

## Error Handling

Use typed failures:

- `NetworkFailure`.
- `LocationFailure`.
- `ApiFailure`.
- `CacheFailure`.
- `UnknownFailure`.

Every screen must support:

- Loading state.
- Content state.
- Error state.
- Empty state where relevant.
- Offline cached state where relevant.

## Testing Requirements

Required tests:

- Unit tests for use cases.
- Unit tests for weather code mapping.
- Unit tests for unit conversion.
- Unit tests for precipitation summary generation.
- BLoC tests for Weather, Cities, and Settings.
- Widget tests for UI kit components.

## Implementation Rules

- Build design tokens before screens.
- Build reusable card components before feature screens.
- Keep widgets small and focused.
- Keep API models separate from domain entities.
- Implement Weather Map as a location picker, not as radar.
- Do not add push notifications, home widgets, premium subscriptions, auth,
  radar, weather layers, or complex weather animations to v1.0.
