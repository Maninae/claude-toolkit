---
name: diagram
description: Generate an interactive HTML diagram (flowchart, sequence, architecture, ERD, force graph). Auto-selects the best rendering engine.
argument-hint: <what to diagram>
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, AskUserQuestion, ToolSearch
---

# Diagram

Generate a standalone interactive diagram as an HTML page.

## Invocation

```
/diagram the auth flow
/diagram database schema for this project
/diagram architecture of the payment service
/diagram dependency graph of ./src/
/diagram --slides the request lifecycle    # As a slide deck
```

## Workflow

1. **Determine diagram type**:
   - Flowchart: processes, decision trees, algorithms, request flows
   - Sequence: API calls, protocol exchanges, multi-service interactions
   - Architecture: system components, service boundaries, data flow
   - ERD: database tables, relationships, data models
   - Force graph: dependencies, knowledge graphs, network relationships
   - Tree: hierarchies, org charts, file structures

2. **Gather structure**:
   - Read relevant source files to understand the actual structure
   - For architecture: identify services, databases, queues, external APIs
   - For ERD: find model definitions, migrations, schema files
   - For dependency graphs: parse import statements
   - Never guess — every node and edge must be grounded in code

3. **Read design references**:
   - Read `references/_principles.md` for creative brief
   - Read `references/diagram.md` for the archetype brief
   - Complete the creative brief — pick a flavor seed

4. **Select rendering engine**:
   - Mermaid: flowcharts, sequence diagrams, ERDs, class diagrams (< 30 nodes)
   - D3.js force layout: dependency graphs, knowledge graphs (any size, interactive)
   - Custom SVG: simple architecture diagrams with specific layout needs

5. **Generate HTML**:
   - Diagram is the hero — full width, centered, minimal surrounding chrome
   - Zoom and pan support (mouse wheel + drag)
   - Hover on nodes for details (tooltip with file path, description)
   - Legend for color-coded categories
   - Click to expand collapsed groups (for large diagrams)

6. **Write** to `~/.visualize/YYYY-MM-DD/diagram-<slug>/index.html` and open in browser.

## Quality Checklist

- Every node and edge is grounded in actual code (no imagined components)
- Diagram is readable without zooming (reasonable node count per view)
- Large diagrams use grouping/clustering to manage complexity
- Legend explains any color coding or shape conventions
- Interactive features (zoom, hover, click) work correctly
