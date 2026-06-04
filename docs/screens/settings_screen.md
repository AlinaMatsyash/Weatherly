# Settings Screen Specification

## Purpose

The Settings screen controls app preferences such as theme, units, language,
refresh behavior, and basic app information.

## Route

```text
/settings
```

## Entry Points

- Menu button from Home.
- Future navigation drawer.

## Header

Elements:

- Back button.
- Screen title: `Settings`.

## Sections

### Appearance

Controls:

- Theme mode: Dark, Light, System.

Default:

- Dark.

### Units

Controls:

- Temperature: Celsius, Fahrenheit.
- Wind speed: m/s, km/h, mph.
- Precipitation: mm, inches.

### Language

Controls:

- App language.

MVP language options:

- English.
- Russian.

### Weather Refresh

Controls:

- Manual refresh only.
- Auto refresh interval after MVP.

### Location

Controls:

- Use current location.
- Location permission status.
- Selected city shortcut.

### About

Content:

- App name.
- Version.
- Weather data provider: Open-Meteo.

## Behavior

- Changes apply immediately.
- Settings are saved locally.
- Home and detail screens react to settings changes.
- Unit changes should not trigger unnecessary network requests.
- Language changes should update app text without changing weather data.

## States

### Loading

Show settings placeholders.

### Content

Show current settings.

### Error

Show local storage error if settings cannot be saved.

## Acceptance Criteria

- User can switch theme.
- User can switch temperature units.
- User can switch wind units.
- User can switch language.
- Settings persist after app restart.
- Weather values update after unit changes.
