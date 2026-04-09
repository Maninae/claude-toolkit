# Design Principles & Creative Brief

These principles govern every visualization. Read this file before generating ANY HTML.

---

## The Creative Brief (Mandatory)

Before writing a single line of HTML, complete ALL six fields. This is your design contract — every decision must trace back to it.

```
PURPOSE:    [What is this communicating? Who reads it? What should they feel/do after?]
METAPHOR:   [What visual world does this live in? "Mission control", not "dashboard".]
TYPOGRAPHY: [Two Google Fonts. Why these? What emotional register do they set?]
PALETTE:    [One dominant hue + why. One accent + why. One neutral.]
SIGNATURE:  [The ONE thing that makes this memorable. A hero animation? A data-ink ratio trick? An unexpected layout?]
COMPOSITION:[Dense/spacious? Scroll/fixed? Grid/organic? Centered/full-bleed?]
```

The brief prevents generic output. If you skip it, you'll produce slop.

---

## Anti-Slop Rules

These are the most common failure modes. Violating any of these means the output is rejected.

### 1. No Gradient Soup
- Maximum ONE gradient per page, and only if it serves the metaphor
- Gradients must be subtle (10-15% opacity range) or structural (hero section background)
- Never: rainbow gradients, gratuitous linear-gradient on every section, gradient text unless it's the signature element

### 2. No Card Carnival
- Not everything is a card. Cards imply discrete, comparable units
- If content is sequential (a narrative, a timeline), use flow — not cards
- If content is hierarchical, use indentation or nesting — not cards
- Maximum card count: 8 per viewport. More than that = use a table or list

### 3. No Font Fiesta
- Exactly TWO fonts: one for headings, one for body
- Never use more than 3 font weights total
- Font sizes: use a modular scale (1.25 or 1.333 ratio). No arbitrary sizes.

### 4. No Animation Avalanche
- Entrance animations: ONE style (e.g., fade-up), staggered across elements
- No animation should last longer than 600ms
- No bouncing, wiggling, or pulsing unless it's the signature element
- `prefers-reduced-motion: reduce` must disable all animations

### 5. No Emoji Overload
- Zero emoji in headings
- Maximum 1 emoji per section, and only if it adds genuine semantic value
- Icons (SVG) are almost always better than emoji

### 6. No Filler Sections
- Every section must contain real content. No "Lorem ipsum" or placeholder text.
- No decorative sections that exist only to fill space
- If a section doesn't serve the purpose from the brief, delete it

### 7. No Dark Mode Afterthought
- Dark mode must be designed, not computed
- Dark backgrounds: use desaturated deep tones (not pure #000 or #111)
- Dark text: use off-white (#e0e0e0 to #f0f0f0), not pure white
- Cards/surfaces in dark mode: subtle elevation via lighter background, not borders

---

## Typography Contract

- Load via Google Fonts `<link>` in `<head>` (never @import in CSS)
- Define as CSS custom properties:
  ```css
  :root {
    --font-heading: 'Chosen Heading Font', sans-serif;
    --font-body: 'Chosen Body Font', sans-serif;
  }
  ```
- Modular scale for sizing (base 1rem, ratio 1.25 or 1.333)
- Line height: 1.5-1.7 for body, 1.1-1.3 for headings
- Max line length: 65-75 characters (use `max-width: 65ch` on prose)

---

## Color Contract

CSS custom properties are mandatory. This is the minimum set:

```css
:root {
  --color-bg: #ffffff;
  --color-surface: #f8f9fa;
  --color-text: #1a1a2e;
  --color-text-secondary: #6b7280;
  --color-primary: /* dominant hue from brief */;
  --color-accent: /* accent from brief */;
  --color-border: #e5e7eb;
}

body.dark-mode {
  --color-bg: #0f1117;
  --color-surface: #1a1d2e;
  --color-text: #e2e8f0;
  --color-text-secondary: #94a3b8;
  --color-primary: /* slightly lighter/more saturated for dark */;
  --color-accent: /* adjusted for dark contrast */;
  --color-border: #2d3348;
}
```

Every color reference in the stylesheet MUST use these variables. No hardcoded colors.

---

## Motion Contract

```css
:root {
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --duration-fast: 200ms;
  --duration-normal: 400ms;
  --duration-slow: 600ms;
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

- Page-load entrance: fade + translateY(20px) → translateY(0), staggered by 80ms per element
- Hover transitions: use `--duration-fast`
- Section reveals: use IntersectionObserver, animate once only

---

## CDN Libraries (Use Sparingly)

Only load what you actually use. Always include SRI integrity hashes.

| Library | When to use | CDN |
|---------|-------------|-----|
| Mermaid | Flowcharts, sequence diagrams, ERDs | cdnjs or jsdelivr |
| Chart.js | Bar, line, pie, radar charts | cdnjs or jsdelivr |
| D3.js | Complex data visualizations, force graphs | cdnjs or jsdelivr |
| html2canvas | Save-as-image button | cdnjs or jsdelivr |
| Prism.js | Syntax highlighting in code blocks | cdnjs or jsdelivr |

Generate SRI hashes or use the latest known-good hashes from cdnjs.

---

## UI Chrome (Every Page)

Every visualization includes these controls:

### Dark/Light Toggle
```html
<button id="theme-toggle" aria-label="Toggle dark mode">
  <!-- Sun/moon icon swap -->
</button>
```
- Position: top-right, fixed
- Respects `prefers-color-scheme` on first load
- Persists choice in `localStorage`

### Fullscreen Button
```html
<button id="fullscreen-btn" aria-label="Toggle fullscreen">
  <!-- Expand icon -->
</button>
```

### Save as Image
- Load `html2canvas` on demand (not on page load)
- Trigger: button click → capture → download as PNG

### Navigation (Long Pages)
- Hamburger menu with section links for pages with 4+ sections
- Smooth scroll to anchors
- Active section highlighting

---

## Composition Patterns

Choose ONE per visualization:

| Pattern | Best For | Key Property |
|---------|----------|-------------|
| **Hero + Flow** | Narratives, summaries, reports | Single column, hero section, scrolling |
| **Grid Dashboard** | Metrics, KPIs, status pages | CSS Grid, dense, fixed viewport |
| **Split Compare** | Comparisons, before/after, diffs | Two-column, side-by-side |
| **Slide Deck** | Presentations, talks, pitches | Full-viewport slides, keyboard nav |
| **Timeline** | Changelogs, roadmaps, history | Vertical timeline, alternating sides |
| **Masonry** | Galleries, card collections | CSS columns or grid auto-fill |
