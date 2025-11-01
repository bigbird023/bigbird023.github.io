---
layout: page
title: draw.io / diagrams.net
permalink: /knowledge/diagrams/drawio
---

# draw.io / diagrams.net — Overview & Best Practices

draw.io (now diagrams.net) is a versatile, free, browser-first diagram editor that works offline and integrates well with cloud storage (Google Drive, OneDrive) and Git. It's excellent for flowcharts, architecture diagrams, network diagrams, org charts, and simple UI mockups.

## When to use draw.io

- You need a traditional drag-and-drop diagram editor with a large library of shapes.
- You want editable XML-based diagrams that can be stored in Git, Drive, or OneDrive.
- You prefer creating diagrams interactively with visual alignment guides and snapping.

## Quickstart

1. Visit [https://app.diagrams.net/](https://app.diagrams.net/) or install the desktop app.
2. Choose a storage option (Local device, Google Drive, OneDrive, GitHub).
3. Drag shapes from the left palette, connect them, and use the Format panel to style.
4. Save as `.drawio` (XML), export to PNG/SVG/PDF for sharing.

## Great example uses

- System architecture diagram (services, data stores, external systems)
- Network topology and VLAN diagrams
- Deployment diagrams with nodes and containers
- Sequence diagrams using the draw.io shape library extensions

## Versioning and collaboration tips

- Store `.drawio` files in Git; the files are XML and reasonably diffable if formatted. Consider using the "compressed XML" option carefully — uncompressed XML is easier to diff.
- When collaborating, export SVG/PNG snapshots for pull-request previews and store the editable `.drawio` source in the repo.
- Use layers to separate documentation overlays (annotations, ownership) from the structural diagram.

## Exporting & embedding

- Export to SVG for crisp vector images in documentation.
- Use the "Include a copy of the diagram" option when exporting so consumers can re-open the file.

## Helpful resources

- diagrams.net website and documentation: https://www.diagrams.net/
- Keyboard & UI tips: use Alt/Shift/Ctrl modifiers for quick alignment and duplication

---

