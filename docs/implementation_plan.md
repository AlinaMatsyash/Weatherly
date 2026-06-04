# Weatherly Sprint Roadmap

Weatherly v1.0 will be built by sprints. Each sprint should produce a usable,
reviewable result and avoid unrelated feature work.

## Sprint 1: Project Setup, Design System, Themes, Navigation, DI

Scope:

- Replace the starter Flutter counter app.
- Add project dependencies.
- Create `lib/design_system/`.
- Create design tokens: `AppColors`, `AppSpacing`, `AppRadius`,
  `AppTypography`, `AppShadows`.
- Create `WeatherlyDarkTheme`.
- Create `WeatherlyLightTheme`.
- Create reusable UI kit components:
  - `WeatherCard`.
  - `WeatherMetricCard`.
  - `HourlyForecastItem`.
  - `DailyForecastTile`.
  - `RainAlertCard`.
  - `PrecipitationChart`.
  - `CityTile`.
- Create `go_router` navigation shell.
- Create DI setup with `get_it`.

Acceptance criteria:

- App launches without starter counter UI.
- Dark and light themes compile.
- Navigation routes exist for Home, Precipitation, Weather Map, Cities, and
  Settings.
- Shared UI kit components exist and can be reused by feature screens.

## Sprint 2: Open-Meteo API, Models, Repository, Use Cases

Scope:

- Create `DioClient`.
- Create Open-Meteo API models.
- Create weather remote data source.
- Create air quality remote data source.
- Create geocoding integration.
- Create weather entities:
  - `Weather`.
  - `CurrentWeather`.
  - `HourlyWeather`.
  - `DailyWeather`.
- Create `WeatherRepository`.
- Create use cases:
  - `GetWeatherByCoordinates`.
  - `GetWeatherByCity`.
  - `GetCurrentLocationWeather`.

Acceptance criteria:

- Weather can be loaded by coordinates.
- Weather can be loaded by city.
- API models are mapped into domain entities.
- Domain logic is testable without Flutter widgets.

## Sprint 3: Home Screen, Current Weather, Hourly Forecast, 7-Day Forecast

Scope:

- Create `WeatherBloc`.
- Build Home screen.
- Render current weather.
- Render rain alert card.
- Render hourly forecast section.
- Render 7-day forecast section.
- Render humidity, wind, UV, and AQI metric cards.

Acceptance criteria:

- Home screen matches the approved dark premium visual direction.
- User can understand current weather without scrolling.
- Hourly and 7-day forecast sections render from weather data.

## Sprint 4: Precipitation Screen, Charts, Rain Logic

Scope:

- Build Precipitation screen.
- Build rain start logic.
- Build precipitation intervals.
- Build precipitation chart.
- Show total precipitation amount.
- Show plain-language summary.

Acceptance criteria:

- User can see when rain starts.
- User can see rain intensity and total amount.
- User can open Precipitation from Home.

## Sprint 5: Cities, Search, Geolocation

Scope:

- Create `CitiesBloc`.
- Build Cities screen.
- Add city search.
- Add saved cities list.
- Add city selection.
- Add city removal.
- Add current location support through `LocationService`.

Acceptance criteria:

- User can search, add, select, and remove cities.
- App works when location permission is denied.
- Selected city updates Home weather.

## Sprint 6: Weather Map

Scope:

- Build Weather Map screen.
- Add OpenStreetMap through `flutter_map`.
- Show current location marker.
- Show saved city markers.
- Allow selecting any map point.
- Load Open-Meteo forecast for selected coordinates.
- Show forecast bottom sheet.
- Add `Save City`.
- Add `View Details`.

Acceptance criteria:

- User can move the map and select a point.
- Selected point weather loads from Open-Meteo.
- User can save selected point as a city.
- No radar or weather layer is implemented in v1.0.

## Sprint 7: Offline Cache, Settings, Ads

Scope:

- Create `HiveService`.
- Cache last successful weather responses.
- Cache saved cities.
- Cache selected city.
- Cache app settings.
- Build Settings screen.
- Add theme setting.
- Add units setting.
- Add language setting.
- Add native ad placement.

Acceptance criteria:

- App can show cached weather offline.
- Settings persist after restart.
- Ads are integrated without breaking the premium layout.

## Sprint 8: Polish, Animations, Testing, Bug Fixes

Scope:

- Add loading skeletons.
- Add empty states.
- Add error states.
- Add offline labels.
- Add 300 ms animations.
- Check small phone layout.
- Check light and dark themes.
- Add unit tests.
- Add BLoC tests.
- Add widget tests for UI kit components.

Acceptance criteria:

- No visible text overflow.
- Main flows work in dark and light themes.
- Core domain and BLoC logic has test coverage.
- Weatherly v1.0 is ready for store-quality portfolio review.

## After v1.0

- Weather layers.
- Cloud layer.
- Temperature layer.
- Wind layer.
- Animated radar.
- Rain notifications.
- Home widgets.
- Premium subscription.
