# Component Building Blocks

Opt-in building blocks for constructing visualizations. Not every visualization needs all of these — pick what serves the archetype and creative brief.

---

## Metric Card

A single KPI or number with context.

```html
<div class="metric-card">
  <span class="metric-label">Active Users</span>
  <span class="metric-value">12,847</span>
  <span class="metric-trend positive">+8.3% vs last week</span>
</div>
```

**CSS contract:**
- `.metric-value`: large (2-3rem), bold, `--color-text`
- `.metric-trend.positive`: green tint, up arrow
- `.metric-trend.negative`: red tint, down arrow
- `.metric-trend.neutral`: gray, dash

---

## Callout Box

Highlight key information, warnings, or insights.

```html
<div class="callout callout--insight">
  <strong>Key Finding:</strong> Response times improved 40% after the cache layer was added.
</div>
```

**Variants:** `callout--insight` (blue), `callout--warning` (amber), `callout--success` (green), `callout--error` (red)

**CSS:** Colored left border (4px), subtle background tint, padding 1rem 1.5rem.

---

## Timeline

Vertical sequence of events with timestamps.

```html
<div class="timeline">
  <div class="timeline-item">
    <div class="timeline-marker"></div>
    <div class="timeline-content">
      <time>2024-03-15 14:30</time>
      <h4>Deploy initiated</h4>
      <p>v2.3.1 pushed to production cluster</p>
    </div>
  </div>
</div>
```

**CSS:** Vertical line (2px, `--color-border`), circular markers (12px, `--color-primary`), alternating sides on desktop.

---

## Code Block

Syntax-highlighted code with copy button.

```html
<div class="code-block">
  <div class="code-header">
    <span class="code-filename">auth/middleware.ts</span>
    <button class="code-copy" onclick="copyCode(this)">Copy</button>
  </div>
  <pre><code class="language-typescript">// highlighted code here</code></pre>
</div>
```

**Requirements:** Prism.js for highlighting, copy-to-clipboard on button click, filename label, dark background regardless of theme.

---

## Data Table

Styled, sortable table for structured data.

```html
<table class="data-table">
  <thead>
    <tr><th data-sort="string">Name</th><th data-sort="number">Value</th></tr>
  </thead>
  <tbody>
    <tr><td>Item A</td><td>42</td></tr>
  </tbody>
</table>
```

**Features:** Sortable columns (click header), zebra striping, hover highlight, sticky header on scroll, horizontal scroll wrapper on mobile.

---

## Progress Bar

Visual indicator of completion or proportion.

```html
<div class="progress-bar">
  <div class="progress-fill" style="width: 73%">73%</div>
</div>
```

**CSS:** Rounded corners, `--color-primary` fill, `--color-surface` track, label inside or above.

---

## Tag / Badge

Small labels for categories, statuses, or metadata.

```html
<span class="badge badge--success">Completed</span>
<span class="badge badge--warning">In Progress</span>
<span class="badge badge--error">Blocked</span>
```

**CSS:** Pill shape (border-radius 9999px), small font (0.75rem), color-coded background with matching text.

---

## Accordion / Collapsible

Expandable sections for dense content.

```html
<details class="accordion">
  <summary>Click to expand details</summary>
  <div class="accordion-content">
    <!-- Content here -->
  </div>
</details>
```

**CSS:** Smooth height transition (use `grid-template-rows: 0fr → 1fr` trick), subtle border, chevron rotation on open.

---

## Split Panel

Side-by-side comparison layout.

```html
<div class="split-panel">
  <div class="split-left">
    <h3>Before</h3>
    <!-- content -->
  </div>
  <div class="split-right">
    <h3>After</h3>
    <!-- content -->
  </div>
</div>
```

**CSS:** `display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;` — stack vertically on mobile.

---

## Toast / Notification

Transient feedback messages.

```html
<div class="toast toast--success" role="alert">
  Image saved successfully
</div>
```

**CSS:** Fixed bottom-right, slide-in animation, auto-dismiss after 3s, `aria-role="alert"`.

---

## Navigation

Hamburger menu for long pages.

```html
<nav class="page-nav" id="page-nav">
  <button class="nav-toggle" aria-label="Toggle navigation">
    <span class="hamburger"></span>
  </button>
  <ul class="nav-links">
    <li><a href="#section-1">Overview</a></li>
    <li><a href="#section-2">Analysis</a></li>
  </ul>
</nav>
```

**Features:** Smooth scroll, active section highlighting via IntersectionObserver, closes on link click on mobile.
