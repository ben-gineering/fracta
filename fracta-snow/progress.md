# Progress

## Current status
- Folder initialized
- Project README drafted
- Fracta Snow selected as first lamp to develop
- OpenSCAD scaffold created
- First draft parametric code started
- Current preferred direction is the twisted stacked-layer concept (v2)

## Design concept
- Fractal basis: Koch snowflake / recursive crystalline edge growth
- Lamp type: pendant
- Primary expression: layered geometric shade with radial symmetry
- Core intent: crisp silhouette, patterned shadows, simple hardware integration

## Working assumptions
- Use OpenSCAD with BOSL2
- Target IKEA-compatible E27 socket + cord hardware
- Maintain safe bulb clearance and easy bulb access
- Favor deterministic, parametric geometry over organic randomness

## Next steps
1. Validate the first-draft snowflake code in OpenSCAD
2. Define target dimensions for actual IKEA-compatible socket hardware
3. Refine the top mounting geometry and bulb access
4. Decide whether to continue with:
   - stacked 2D profiles,
   - lofted shell,
   - or ribbed frame
5. Split reusable hardware and geometry helpers into separate modules
6. Generate low-, medium-, and high-complexity variants for review

## Notes
- README title bug in other folders should be fixed later
- Fracta Snow is a good first project because it is structured and manufacturable
- First draft uses stacked recursive 2D snowflake layers because that is simple, legible, and fabrication-friendly
- Ribbed snowflake v3 was explored and rejected; reverted to the earlier stacked twisted version
