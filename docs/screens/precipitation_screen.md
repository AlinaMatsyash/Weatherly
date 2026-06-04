# Precipitation Screen Specification

## Purpose

The Precipitation screen provides detailed rain information. This is a key
feature of Weatherly and should feel more useful than a simple percentage.

## Route

```text
/precipitation
```

## Entry Points

- Rain alert card on Home.
- Precipitation preview on Home.

## Header

Elements:

- Back button.
- Screen title: `Precipitation`.

## Main Summary Card

Content:

- Rain start message.
- Time until rain starts.
- Intensity label.
- Large precipitation chart.
- Weather icon.

Example:

```text
Rain starting in
40 min
Intensity: Heavy
```

## Chart

Use `fl_chart` bar chart.

Required:

- Hourly precipitation bars.
- Time axis.
- Intensity scale.
- Highlight peak rain period.
- Rain color `#3BA7FF`.

Intensity labels:

- None.
- Light.
- Moderate.
- Heavy.

## Interval List

Content per interval:

- Time range.
- Intensity label.
- Precipitation amount.
- Weather icon.

Example:

```text
10:20 - 11:30
Heavy Rain
10.2 mm
```

## Total Amount

Show total expected precipitation:

```text
Total
15.8 mm
```

## Summary Card

Content:

- Plain-language rain summary.
- Umbrella recommendation if relevant.

Example:

```text
Rain from 10:20 to 17:20.
Heavy rain in the morning. Light rain in the afternoon.
```

## Behavior

- Back returns to Home.
- Screen uses selected city weather data.
- If no rain is expected, show a useful dry-weather state, not an empty screen.
- Chart and intervals must stay synchronized.

## States

### Loading

Show chart skeleton and interval placeholders.

### Content

Show rain summary, chart, intervals, total, and recommendation.

### No Rain

Show:

- No rain expected.
- Dry period duration.
- Next possible precipitation if available.

### Error

Show retry. Use cached data if available.

## Acceptance Criteria

- User understands when rain starts.
- User understands how strong the rain will be.
- User can see total expected precipitation.
- User can use the screen even when no rain is expected.
