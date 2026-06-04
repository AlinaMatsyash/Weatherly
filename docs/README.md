# Weatherly Specification

This folder contains the implementation-ready specification for Weatherly.

Weatherly is a premium Flutter weather app focused on clear current conditions,
rain awareness, hourly planning, weekly forecast, map-based location selection,
air quality, and useful weather metrics. The visual direction is inspired by
Apple Weather, glassmorphism, minimalism, and premium dark UI.

## Documents

- [Product Requirements](product_requirements.md): product goal, MVP scope,
  data requirements, user flows, and acceptance criteria.
- [Design System](design_system.md): colors, typography, spacing, cards,
  animations, charts, and visual rules.
- [Architecture Specification](architecture_spec.md): Clean Architecture,
  packages, folder structure, domain entities, data sources, BLoCs, routing,
  caching, and implementation rules.
- [Sprint Roadmap](implementation_plan.md): sprint-by-sprint build order.

## Screen Specifications

- [Home Screen](screens/home_screen.md)
- [Precipitation Screen](screens/precipitation_screen.md)
- [Weather Map Screen](screens/weather_map_screen.md)
- [Cities Screen](screens/cities_screen.md)
- [Settings Screen](screens/settings_screen.md)

## Sprint Order

Build Weatherly v1.0 in this order:

1. Project Setup, Design System, Themes, Navigation, DI.
2. Open-Meteo API, Models, Repository, Use Cases.
3. Home Screen, Current Weather, Hourly Forecast, 7-Day Forecast.
4. Precipitation Screen, Charts, Rain Logic.
5. Cities, Search, Geolocation.
6. Weather Map.
7. Offline Cache, Settings, Ads.
8. Polish, Animations, Testing, Bug Fixes.

Weather radar, animated cloud movement, weather layers, push notifications,
home widgets, and premium subscriptions are not part of v1.0.
