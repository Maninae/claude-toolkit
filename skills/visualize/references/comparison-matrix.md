# Archetype: Comparison Matrix

## Communication Goal

Help the viewer make a decision by presenting options side-by-side with clear differentiators. The comparison should be fair, comprehensive, and scannable. The viewer should be able to identify the best option for their needs within 30 seconds.

## Detection Signals

"compare", "comparison", "vs", "versus", "evaluation", "trade-offs", "pros and cons", "which should I use"

## Layout DNA

- **Structure**: Table or side-by-side cards, scrollable horizontally on mobile
- **Density**: MEDIUM-HIGH — dense data but well-organized with clear visual hierarchy
- **Anchor column**: First column = criteria/features, frozen on horizontal scroll
- **Highlight**: Winning cells get subtle background tint or checkmark
- **Typography**: Compact body (0.85-0.95rem), clear header row (1.1rem bold)

## Comparison Types

| Type | Structure | When |
|------|-----------|------|
| Feature Matrix | Rows = features, Cols = options, Cells = yes/no/partial | Comparing tools, libraries, services |
| Pros/Cons | Two columns per option: pros (green) and cons (red) | Evaluating trade-offs |
| Weighted Score | Feature matrix + weight column + calculated totals | Data-driven decisions |
| Before/After | Split view, left = before, right = after | Showing improvements |
| Attribute Radar | Radar/spider chart per option, overlaid | Comparing multi-dimensional profiles |

## Flavor Seeds

- **Analyst Brief**: Clean white, blue headers, minimal borders. Think Gartner comparison.
- **Developer Docs**: Monospace labels, dark surface cards, green checkmarks. Think framework comparison page.
- **Product Page**: Branded columns, highlighted "recommended" option, CTA-style layout. Think pricing page.

## Technical Requirements

- Sticky header row and frozen first column for large matrices
- Sortable columns (click header to sort by that criteria)
- Filter/search for rows when matrix has 15+ features
- Color coding: green = advantage, red = disadvantage, gray = neutral
- Summary row at bottom with verdict or score
- Responsive: horizontal scroll with sticky first column on mobile

## Anti-Patterns

- Comparing more than 5 options (cognitive overload — narrow down first)
- Inconsistent cell formats (mixing "Yes", "true", checkmarks in same matrix)
- Missing a summary/recommendation section
- Using only text when visual indicators (icons, color) would scan faster
- Biased presentation (one option clearly styled as "the winner" without evidence)
