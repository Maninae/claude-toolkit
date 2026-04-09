# Archetype: Presentation Deck

## Communication Goal

Persuade, inform, or teach through a sequence of focused slides. Each slide makes ONE point. The audience should be able to follow the narrative without a speaker present — the slides are self-explanatory, not speaker notes.

## Detection Signals

"slides", "presentation", "deck", "pitch", "talk", "keynote", `--slides` flag on any command

## Layout DNA

- **Structure**: Full-viewport slides (`100vh` per slide), horizontal or vertical scroll
- **Navigation**: Arrow keys (left/right or up/down), click/tap, progress indicator, slide counter
- **Density**: LOW — maximum 3-5 elements per slide (heading + 2-3 supporting items)
- **Typography scale**: Aggressive — headings at 3-4rem, body at 1.2-1.5rem
- **Grid**: Centered content, max-width 900px, generous padding (8-12vh vertical)

## Slide Types

| Type | Structure | When |
|------|-----------|------|
| Title Slide | Large heading + subtitle + optional background | First slide |
| Content Slide | Heading + 2-4 bullet points or short paragraphs | Core content |
| Split Slide | Left: text, Right: image/diagram/code | Explaining with visuals |
| Quote Slide | Large pull quote + attribution | Key insight or testimonial |
| Data Slide | Heading + single chart or metric | Quantitative evidence |
| Section Divider | Large text, contrasting background | Transition between topics |
| Summary Slide | Key takeaways as numbered list | Conclusion |

## Flavor Seeds

Pick ONE direction per deck:

- **Keynote Editorial**: Clean white backgrounds, large serif headings, subtle photography. Think Apple keynote meets magazine layout.
- **Dark Cinema**: Deep dark backgrounds, cinematic type scale, accent color pops. Think conference talk.
- **Blueprint Technical**: Monospace accents, grid overlays, technical diagram aesthetic. Think engineering presentation.
- **Warm Narrative**: Soft warm palette, rounded shapes, friendly sans-serif. Think storytelling.

## Technical Requirements

```javascript
// Keyboard navigation
document.addEventListener('keydown', (e) => {
  if (e.key === 'ArrowRight' || e.key === 'ArrowDown') nextSlide();
  if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') prevSlide();
  if (e.key === 'f') toggleFullscreen();
});
```

- Slide transitions: crossfade or slide (300-400ms, ease-out)
- Progress bar at top or bottom (thin, accent color)
- Slide counter: "3 / 12" format, subtle placement
- Touch/swipe support for mobile
- Print styles: one slide per page

## Anti-Patterns

- Walls of text on a single slide (max 40 words per slide)
- Bullet point overload (max 5 bullets, prefer 3)
- Inconsistent slide layouts within a deck
- Tiny text that requires zooming
- Decorative animations between every slide (pick ONE transition style)
- Missing slide numbers or progress indication
