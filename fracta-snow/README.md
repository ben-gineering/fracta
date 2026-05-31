# Fracta Snow

Fracta Snow is a geometric lamp concept in the Fracta series, inspired by the Koch snowflake and crystalline radial symmetry.

## Concept
A pendant lamp shade built from recursive snowflake geometry. The lamp uses layered or lofted fractal polygon profiles to create a lantern-like volume with crisp edges and patterned light.

## Design goals
- Build in OpenSCAD
- Use BOSL2 for reusable parametric geometry
- Design around IKEA-standard bulb, socket, and cable hardware
- Emphasize clean, Nordic, architectural form
- Keep the geometry manufacturable for 3D printing or flat-pack fabrication

## Product direction
- Primary type: pendant lamp
- Style: geometric, minimal, crystalline
- Light quality: patterned ambient light with controlled openings
- Construction: central hardware core with a fractal outer shade

## Proposed hardware assumptions
- Socket type: E27 pendant socket
- Cable: standard hanging lamp cord set
- Bulb type: warm white globe or pear bulb
- Mounting: central axial mount with retaining ring or shade collar

## Initial CAD strategy
- Create a recursive 2D snowflake generator
- Build one or more radial profiles from that generator
- Extrude, stack, or loft the profiles into a shade volume
- Add a standard internal hardware interface for socket fit and bulb clearance
- Split geometry into printable or easily assembled parts if needed

## Planned outputs
- Parametric OpenSCAD source
- Rendered concept views
- Dimensional envelope for bulb/socket clearance
- Iterations for simple, standard, and dense variants
