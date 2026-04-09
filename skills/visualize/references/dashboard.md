# Archetype: Dashboard

## Communication Goal

Surface the most important metrics and status at a glance. The viewer should understand the current state in under 5 seconds of scanning. Dashboards answer "how are we doing?" — they don't tell stories.

## Detection Signals

"dashboard", "status", "metrics", "KPIs", "monitoring", "overview", "at a glance"

## Layout DNA

- **Structure**: CSS Grid, 12-column base, responsive breakpoints
- **Density**: HIGH — maximize information per viewport, minimize scrolling
- **Viewport**: Designed for a single screen (no infinite scroll). If content overflows, prioritize ruthlessly.
- **Typography scale**: Compact — metrics at 2-3rem, labels at 0.75-0.85rem
- **Spacing**: Tight but breathable — 12-16px gaps between grid items

## Component Hierarchy

1. **Hero Metrics** (top row): 3-5 KPI cards with large numbers, trend arrows, sparklines
2. **Primary Charts** (middle): 1-2 main charts showing the most important trends
3. **Supporting Data** (bottom): Tables, secondary charts, or status lists
4. **Status Indicators**: Color-coded (green/amber/red) for health checks

## Flavor Seeds

- **Mission Control**: Dark background, neon accent data, monospace numbers. Think NASA ops center.
- **Executive Brief**: White background, muted palette, serif headings. Think Bloomberg terminal meets editorial.
- **Engineering Ops**: Dark theme, green/amber/red status colors, grid-heavy. Think Grafana.
- **Product Analytics**: Light theme, blue/purple palette, rounded cards. Think Amplitude/Mixpanel.

## Technical Requirements

- Metric cards: number + label + trend indicator (arrow + percentage)
- Charts: use Chart.js for standard charts, D3 for custom visualizations
- Auto-fit: grid items should use `minmax()` and `auto-fit` for responsive behavior
- Number formatting: use `Intl.NumberFormat` for locale-aware display
- Timestamps: relative ("2 hours ago") with absolute tooltip

## Anti-Patterns

- Scrolling dashboards (if it scrolls, it's a report, not a dashboard)
- More than 6 KPI cards in the hero row
- Charts without axis labels or legends
- Using pie charts for more than 4 categories (use bar charts instead)
- Rainbow color schemes for categorical data (use a coherent 3-4 color palette)
- Decorative elements that consume grid space without adding information
