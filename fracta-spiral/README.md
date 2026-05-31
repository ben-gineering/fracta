# Fracta Spiral

Fracta Spiral is a sculptural pendant lamp concept in the Fracta series, inspired by recursive spiral growth, helical repetition, and shell-like motion.

## Concept
A pendant shade built from repeated snowflake-like or petal-like fins that twist upward around a central bulb cavity. The form should feel dynamic, elegant, and premium rather than chaotic.

## Design goals
- Build in OpenSCAD
- Use BOSL2 where useful for transforms and reusable modules
- Design around IKEA-standard bulb, socket, and cable hardware
- Emphasize motion, upward flow, and layered light control
- Keep the structure parametric and manufacturable

## Product direction
- Primary type: pendant lamp
- Style: dynamic, modern, sculptural
- Light quality: filtered ambient light with directional highlights
- Construction: central hardware core with repeated spiral fins

## Proposed hardware assumptions
- Socket type: E27 pendant socket
- Cable: standard hanging cord set
- Bulb type: warm white globe or pear bulb
- Mounting: central axial top mount with retaining ring or collar

## Initial CAD strategy
- Build a repeated fin module
- Place modules along a helical progression
- Scale and rotate the modules over height
- Maintain a central bulb clearance envelope
- Use top mount geometry that can plausibly connect to standard pendant hardware
