# Home Screen Specification

## Purpose

The Home screen is the main weather dashboard. It should answer the user's most
important questions immediately:

- What is the weather now?
- Will it rain soon?
- What happens over the next few hours?
- What is the weekly outlook?
- Are there important metrics like AQI, UV, wind, sunrise, or sunset?

## Entry Point

Default route:

```text
/home
```

## Layout Order

1. Top navigation.
2. Current weather hero.
3. Rain alert card.
4. Smart recommendation card.
5. Hourly forecast preview.
6. Precipitation preview.
7. 7-day forecast.
8. Weather metric cards.
9. Native ad placement.

## Top Navigation

Elements:

- Menu button.
- City name.
- Current date.
- Search button.
- Optional map button.

Behavior:

- Menu opens Settings or a compact navigation drawer.
- Search opens Cities screen.
- Map opens Weather Map screen.
- City name reflects selected city.
- Date uses local city timezone when available.

## Current Weather Hero

Content:

- Current temperature.
- Weather condition label.
- Feels-like temperature.
- High and low temperature.
- Large weather icon or illustration.

Behavior:

- Updates when selected city changes.
- Uses fade and scale animation after refresh.
- Shows cached data immediately if available.

## Rain Alert Card

Content examples:

```text
Rain starting in
40 min
Take an umbrella with you
```

Also show:

- Rain icon.
- Small rain drops.
- Intensity label when available.

Behavior:

- Tapping opens `/precipitation`.
- If no rain is expected, show a positive message instead:

```text
No rain expected
Dry weather through the afternoon
```

## Smart Recommendation Card

Purpose:

Convert weather data into practical advice.

Possible recommendations:

- Take an umbrella.
- Good time for a walk.
- High UV, use sunscreen.
- Air quality is poor, reduce outdoor activity.
- Strong wind expected.

Behavior:

- Recommendation is generated from current, hourly, precipitation, UV, and AQI
  data.
- Only one primary recommendation is shown on Home.
- The card should be concise and not feel like a tutorial.

## Hourly Forecast Preview

Content:

- Horizontal scroll list.
- Current hour plus next hours.
- Weather icon.
- Temperature.
- Precipitation probability.

Behavior:

- The section stays on Home in v1.0.
- A standalone hourly screen is not part of v1.0.
- List should scroll horizontally.
- Items should keep stable width.

## Precipitation Preview

Content:

- Small bar chart.
- Time labels.
- Intensity labels: none, light, moderate, heavy.
- "See details" action.

Behavior:

- Tapping the card or action opens `/precipitation`.
- If no precipitation is expected, show a calm empty chart state.

## 7-Day Forecast

Content:

- Day/date.
- Weather icon.
- Min temperature.
- Max temperature.
- Temperature range line.
- Precipitation probability.

Behavior:

- Full daily details can be added after v1.0.
- Rows should be dense but readable.

## Metric Cards

Required metrics:

- Humidity.
- Wind.
- UV Index.
- Air Quality.
- Sunrise.
- Sunset.

Behavior:

- AQI is shown directly on Home in v1.0.
- Other metric cards may open future detail screens.

## States

### Loading

- Show skeleton cards.
- Keep layout stable.

### Content

- Show fresh or cached weather.

### Offline Cached

- Show cached content.
- Display subtle "Updated earlier" or "Offline" label.

### Error

- If cache exists, keep content and show a non-blocking error.
- If no cache exists, show full error state with retry.

### Empty

- If no city is selected and location is unavailable, ask user to choose a city.

## Acceptance Criteria

- User understands current weather without scrolling.
- User can see whether rain is coming.
- User can open precipitation details from the rain card.
- User can open city search from the top bar.
- Home works in dark and light themes.
