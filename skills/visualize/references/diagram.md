# Archetype: Diagram

## Communication Goal

Make invisible structure visible. Diagrams reveal relationships, flows, hierarchies, and dependencies that are impossible to convey in prose. The viewer should grasp the system's shape in one look, then zoom in for details.

## Detection Signals

"diagram", "flowchart", "sequence diagram", "architecture", "ERD", "entity relationship", "graph", "network", "connections", "map", "knowledge graph", "system design"

## Layout DNA

- **Structure**: Full-width canvas, centered diagram, minimal surrounding chrome
- **Density**: Depends on complexity — simple diagrams get generous spacing, complex ones use zoom/pan
- **Interaction**: Zoom, pan, hover-for-details on nodes. Click to expand collapsed groups.
- **Typography**: Labels use body font at 0.8-0.9rem. Title above diagram at 1.5rem.
- **Background**: Subtle dot grid or clean white — the diagram IS the content

## Diagram Types

| Type | Engine | When |
|------|--------|------|
| Flowchart | Mermaid | Process flows, decision trees, algorithms |
| Sequence Diagram | Mermaid | API calls, request/response flows, protocol exchanges |
| Architecture | Mermaid or custom SVG | System components and their connections |
| ERD | Mermaid | Database schema, data models |
| Class Diagram | Mermaid | OOP hierarchies, interface relationships |
| Force Graph | D3.js | Networks, knowledge graphs, dependency maps |
| Timeline | Custom HTML/CSS | Historical sequences, project phases |
| Tree | D3.js or custom | Hierarchies, org charts, file structures |

## Flavor Seeds

- **Blueprint**: Dark navy background, white/cyan lines, monospace labels. Think technical schematic.
- **Whiteboard**: Off-white background, hand-drawn-style edges (Mermaid `%%{init: {'theme': 'neutral'}}%%`), marker-style text. Think team whiteboard photo.
- **Neon Circuit**: Black background, glowing colored edges, node pulse animations. Think sci-fi system display.
- **Clean Technical**: White background, gray edges, blue accent nodes. Think official documentation.

## Technical Requirements

- Mermaid diagrams: render with `mermaid.init()`, custom theme via `%%{init}%%` directive
- D3 force graphs: collision detection, drag interaction, zoom/pan with d3-zoom
- All diagrams must have a legend if using color-coded categories
- SVG-based rendering preferred (scales cleanly, searchable text)
- Export: the save-as-image button should capture the diagram at 2x resolution

## Anti-Patterns

- Diagrams with 50+ nodes and no grouping (use subgraphs/clusters to organize)
- Crossing lines everywhere (reorder nodes to minimize crossings)
- Missing labels on edges (every arrow should explain the relationship)
- Tiny text that requires zooming to read (minimum 12px equivalent)
- Static screenshots of diagrams when interactive would be better
- Using Mermaid for everything — some diagrams need D3's flexibility
