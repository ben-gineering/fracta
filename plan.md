# Fracta Design Plan

This document lays out the plan for developing the remaining four lamps in the Fracta series using the same iterative method established with Fracta Snow.

## Core process for each lamp
For each lamp concept, follow this sequence:

1. **Concept setup**
   - Update the lamp `README.md`
   - Update or create a detailed `progress.md`
   - Define intended lamp type, silhouette, fractal logic, and provisional hardware assumptions

2. **CAD scaffold**
   - Create:
     - `openscad/`
     - `reference/`
     - `renders/`
   - Add:
     - main `.scad` file
     - `openscad/README.md`
     - `reference/hardware-notes.md`

3. **Iteration loop**
   - Build first-pass geometry in OpenSCAD
   - Render from command line
   - Review iso/front/side/top views
   - Make targeted changes
   - Repeat until the design has a coherent and compelling silhouette

4. **Versioning discipline**
   - Make a git commit for each meaningful design iteration
   - Use git history instead of version suffixes in filenames
   - Keep render filenames stable per lamp:
     - `renders/<lamp>_iso.png`
     - `renders/<lamp>_front_xy.png`
     - `renders/<lamp>_side_yz.png`
     - `renders/<lamp>_top_xy.png`

5. **Quality criteria**
   - Fractal concept must be legible
   - Lamp must look intentional from multiple views
   - CAD model should remain parametric and editable
   - The structure should suggest real fabrication paths
   - Standard IKEA-compatible hardware assumptions should remain central

---

## Lamp-by-lamp plan

## 1. Fracta Spiral
**Priority:** Highest

### Concept target
A sculptural pendant built from recursively scaled fins or blades arranged along a spiral path. This should become one of the flagship lamps in the series.

### Design goals
- Capture motion and upward flow
- Keep a readable central bulb cavity
- Use repeated blades or petals as a manufacturable pattern
- Preserve strong visual drama in iso render

### CAD strategy
- Start with repeated fin modules placed along a helical path
- Try scaled rotation progression
- Test both open and semi-enclosed variants
- Evaluate whether 3, 4, or 6 primary spiral families work best

### Iteration checklist
- v1: simple spiral fin array
- v2: improved taper and density
- v3: integrated top mount and cleaner lower opening
- v4+: silhouette and manufacturability refinement as needed

### Review focus
- Does the form feel dynamic rather than messy?
- Is the central volume controlled?
- Does it look premium rather than purely computational?

---

## 2. Fracta Fern
**Priority:** High

### Concept target
An organic branching shade or table/pendant lamp based on fern-like recursive growth.

### Design goals
- Express natural self-similarity
- Avoid looking too random or biologically literal
- Keep the branching structure elegant and printable
- Produce rich shadow play

### CAD strategy
- Generate recursive branching ribs from a trunk or stem axis
- Explore symmetric and asymmetric branch systems
- Consider a pendant variant first for hardware simplicity
- Use BOSL2 transforms to manage branch repetition and scaling

### Iteration checklist
- v1: simple recursive branch scaffold
- v2: fuller branching density and silhouette control
- v3: integrated lamp envelope and socket interface
- v4+: refine openness, balance, and assembly strategy

### Review focus
- Does it read as botanical but still designed?
- Is the branch density balanced?
- Does the negative space create a pleasant light pattern?

---

## 3. Fracta Canopy
**Priority:** Medium

### Concept target
A dome-like pendant derived from branching canopy logic, with structural members spreading outward from a top hub.

### Design goals
- Warm, architectural, sheltering form
- Strong pendant presence
- More cohesive enclosure than Fern
- Premium and calm rather than sharp or aggressive

### CAD strategy
- Create branching struts radiating from a top node
- Fit the structure inside a dome or canopy envelope
- Use repeating branch tiers rather than pure randomness
- Explore sparse and dense variants early

### Iteration checklist
- v1: primary branch dome
- v2: secondary branching and shape correction
- v3: mounting and lower opening refinement
- v4+: improve enclosure and visual rhythm

### Review focus
- Does it feel like a canopy instead of a cage?
- Does the dome silhouette read clearly?
- Is the branch logic visible but not chaotic?

---

## 4. Fracta Coral
**Priority:** Medium/Exploratory

### Concept target
A porous sculptural lamp inspired by coral growth, clustering, and voids.

### Design goals
- Most atmospheric and sculptural object in the range
- Softer and more ambient than the others
- Controlled irregularity
- Strong object quality even when unlit

### CAD strategy
- Start from clustered nodes / spheres / hulls / branching pores
- Keep the geometry deterministic and parameterized where possible
- Consider a smaller table lamp first
- Focus on outer silhouette before internal complexity

### Iteration checklist
- v1: clustered porous mass study
- v2: improved void distribution and access opening
- v3: hardware cavity and stable base integration
- v4+: surface refinement and printability checks

### Review focus
- Does it feel intentional rather than blobby?
- Are the voids visually rich?
- Does it retain a strong object silhouette?

---

## Optional inspiration research
If useful during development:
- search for precedent imagery and forms
- review natural references for each fractal family
- check OpenSCAD techniques for spirals, recursive branching, or volumetric approximations
- keep inspiration external, but avoid copying existing commercial designs

---

## Commit policy
For each remaining lamp, create commits at these milestones minimum:
- initialize lamp scaffold
- first draft geometry
- first rendered review pass
- major refinement pass(es)
- preferred concept selection / cleanup

---

## Execution order
1. Develop **Fracta Spiral** next
2. Then **Fracta Fern**
3. Then **Fracta Canopy**
4. Then **Fracta Coral**

The goal is to build a consistent Fracta series with each lamp developed as a real iterative design project, not just a one-pass concept sketch.
