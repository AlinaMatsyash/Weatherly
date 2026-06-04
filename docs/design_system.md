# Weatherly Design System

## Visual Direction

Weatherly should use a premium dark glassmorphism style inspired by Apple
Weather. The UI should feel calm, polished, spacious, and modern.

Avoid:

- Default Material 3 visual style.
- Bright acidic colors.
- Colorful unrelated cards.
- Harsh shadows.
- Heavy outlines.
- Decorative clutter.

Use:

- Dark navy backgrounds.
- Soft gradients.
- Glass-like cards.
- Large spacing.
- Large rounded corners.
- Subtle borders.
- Clear typography.
- Smooth 300 ms animations.

## Themes

Dark theme is the primary theme. Light theme is supported but secondary.

## Design System Structure

The implementation should start from:

```text
lib/
  design_system/
    tokens/
    theme/
    widgets/
```

Required token classes:

- `AppColors`.
- `AppSpacing`.
- `AppRadius`.
- `AppTypography`.
- `AppShadows`.

## Dark Theme Colors

| Token | Value | Usage |
| --- | --- | --- |
| `background` | `#07111F` | App background |
| `surface` | `#111C2B` | Main cards |
| `surfaceElevated` | `#172538` | Elevated cards |
| `border` | `#26384D` | Subtle card borders |
| `primary` | `#4A90E2` | Main accent |
| `rain` | `#3BA7FF` | Precipitation |
| `success` | `#22C55E` | Good AQI and positive states |
| `warning` | `#F59E0B` | UV and warnings |
| `error` | `#EF4444` | Errors and severe alerts |
| `textPrimary` | `#FFFFFF` | Primary text |
| `textSecondary` | `#A9B4C2` | Secondary text |
| `textTertiary` | `#718096` | Muted text |

## Light Theme Colors

| Token | Value | Usage |
| --- | --- | --- |
| `background` | `#F7F8FA` | App background |
| `surface` | `#FFFFFF` | Main cards |
| `surfaceElevated` | `#F1F5F9` | Elevated cards |
| `border` | `#E5E7EB` | Subtle card borders |
| `primary` | `#1D70C9` | Main accent |
| `rain` | `#248CE8` | Precipitation |
| `textPrimary` | `#111827` | Primary text |
| `textSecondary` | `#4B5563` | Secondary text |
| `textTertiary` | `#6B7280` | Muted text |

## Gradients

### Sunny

```dart
LinearGradient(
  colors: [
    Color(0xFF4A90E2),
    Color(0xFF7CC6FF),
  ],
)
```

### Rainy

```dart
LinearGradient(
  colors: [
    Color(0xFF1E3A5F),
    Color(0xFF3B82F6),
  ],
)
```

### Night

```dart
LinearGradient(
  colors: [
    Color(0xFF07111F),
    Color(0xFF172538),
  ],
)
```

### Storm

```dart
LinearGradient(
  colors: [
    Color(0xFF111827),
    Color(0xFF334155),
  ],
)
```

## Typography

Use Inter through `google_fonts`.

| Style | Size | Weight | Usage |
| --- | ---: | ---: | --- |
| `temperatureLarge` | 72 | 700 | Current temperature |
| `cityTitle` | 22 | 600 | City name |
| `screenTitle` | 20 | 600 | Screen titles |
| `sectionTitle` | 18 | 600 | Section headers |
| `cardTitle` | 14 | 600 | Card labels |
| `body` | 14 | 500 | Main card text |
| `caption` | 12 | 400 | Secondary metadata |
| `metricValue` | 18 | 600 | Metric card values |

Rules:

- Do not scale font size with viewport width.
- Letter spacing should be `0`.
- Long text must wrap cleanly.
- No text may overlap charts, icons, or card edges.

## Spacing

Use this fixed spacing scale only:

```text
4, 8, 12, 16, 20, 24, 32, 40, 48
```

Common usage:

- Screen horizontal padding: `16`.
- Card internal padding: `16`.
- Section gap: `20` or `24`.
- Compact item gap: `8` or `12`.
- Large hero spacing: `32`.

## Radii

| Token | Value | Usage |
| --- | ---: | --- |
| `radiusSmall` | 8 | Small controls |
| `radiusMedium` | 16 | Inputs and compact cards |
| `radiusLarge` | 24 | Standard cards |
| `radiusHero` | 32 | Hero weather cards |

## Cards

All cards should use consistent styling:

```dart
borderRadius: 24
background: surface
border: Border.all(color: border)
shadowBlur: 20
shadowOpacity: 0.08
```

Glass effect:

- Use a subtle translucent surface where appropriate.
- Keep blur soft.
- Do not make text hard to read.

## UI Kit Components

Create these reusable components before implementing screens:

- `WeatherCard`: base card for all weather content.
- `WeatherMetricCard`: metric card for UV, AQI, wind, and humidity.
- `HourlyForecastItem`: compact hourly forecast item.
- `DailyForecastTile`: weekly forecast row.
- `RainAlertCard`: rain starting card.
- `PrecipitationChart`: reusable precipitation chart.
- `CityTile`: city row for saved cities and search results.

## Icons

Preferred icon libraries:

- `phosphor_flutter`
- `hugeicons`

Avoid using Material Icons for the main UI because they make the app feel too
generic.

Weather condition icons may be custom assets or lightweight illustrations.

## Charts

Use `fl_chart`.

Temperature chart:

- Line color: `#4A90E2`.
- Line width: `4`.
- Minimal grid.
- Clear labels.

Precipitation chart:

- Bar color: `#3BA7FF`.
- Bar radius: `4`.
- Show time labels.
- Show intensity levels: none, light, moderate, heavy.

## Weather Map UI

The Weather Map should feel like part of Weatherly, not like a default map
demo.

Map rules:

- Use OpenStreetMap as the base map.
- Keep map controls minimal.
- Use dark glass buttons over the map in dark theme.
- Use light translucent buttons over the map in light theme.
- Markers should use Weatherly accent colors, not default map pins.

Bottom sheet rules:

- Use `radiusLarge` on the top corners.
- Use `surface` background with subtle border.
- Keep content compact and scannable.
- Show current weather first, then precipitation, then hourly timeline.
- Primary actions are `Save City` and `View Details`.

Map controls:

- Current location button should be a circular icon button.
- Saved city markers should be visually smaller than the selected marker.
- Selected marker should use `primary`.
- Rain/precipitation values should use `rain`.

## Animations

Default animation:

```text
300 ms, easeOut
```

Screen transition:

```text
400 ms
```

Weather refresh:

- Fade.
- Scale.
- Avoid layout jumps.

## Responsive Rules

- The app is mobile-first.
- Cards must keep stable dimensions where possible.
- Horizontal forecast lists should scroll, not squeeze.
- Charts must have fixed minimum height.
- Buttons and touch targets should be at least 44 px high.
- No nested card layouts unless the inner card is an actual repeated item.
