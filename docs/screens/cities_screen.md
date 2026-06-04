# Cities Screen Specification

## Purpose

The Cities screen lets users search, save, select, and remove forecast
locations.

## Route

```text
/cities
```

## Entry Points

- Search icon on Home.
- Menu or Settings shortcut.

## Header

Elements:

- Back button.
- Screen title: `Cities`.

## Search

Elements:

- Search input.
- Clear button.
- Loading indicator during search.

Behavior:

- Search starts after debounce.
- Results come from Open-Meteo Geocoding API.
- Empty query shows saved cities.
- Selecting a result saves and selects the city.

## Saved Cities List

Content per city:

- City name.
- Country.
- Weather icon.
- Current temperature.
- Optional small condition label.

Behavior:

- Tap city to select and open Home.
- Swipe or menu action removes city.
- Selected city should be visually marked.

## Add City Action

Use an `Add City` button below the saved city list.

Behavior:

- Focuses the search input.
- Does not open a separate modal in MVP.

## Current Location

Show a current location item when permission is available.

Behavior:

- Tap to use current location weather.
- If permission is missing, request permission.
- If permission is denied, show a clear error and allow city search.

## States

### Loading

Show search loading state or saved city skeletons.

### Content

Show saved cities or search results.

### Empty

Show empty saved cities state with search input focused.

### Error

Show geocoding error, location permission error, or network error.

## Acceptance Criteria

- User can search for a city.
- User can save a city.
- User can select a saved city.
- User can remove a saved city.
- App still works if location permission is denied.
