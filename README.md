# Chromablock

Chromablock is an isometric 2D puzzle game built in Godot where the player solves environmental puzzles by pushing crates onto floor switches to manipulate the level and unlock new paths.

## Core Gameplay

The gameplay focuses on spatial puzzle solving in an isometric environment:

- Move the player in an isometric 2D world
- Push crates through structured puzzle rooms
- Match crates to specific floor switches
- Trigger environmental changes such as doors and blocked paths
- Solve logic-based puzzles using positioning and movement

Each interaction can change the state of the level and affect progression.

## Mechanics

### Player Movement
- Isometric 2D movement using CharacterBody2D
- Directional input mapped to isometric movement
- Animation changes based on movement direction
- Smooth movement with physics-based handling

### Crates
- Pushable objects using physics-based movement
- Each crate has a unique crate_id
- Movement speed is lower than the player for controlled puzzle design
- Friction slows crates when not being pushed

### Floor Switches
- Built using Area2D detection
- Activates when a crate with a matching crate_id is placed on them
- Changes visual state between pressed and unpressed
- Triggers connected environmental objects

### Doors
- Controlled by floor switches
- Collision can be enabled or disabled to block or allow passage
- Visual state updates based on activation

## Interaction System

The game uses an ID-based interaction system:

- Each crate has a crate_id
- Each switch has a required_id
- When they match, the switch activates and triggers connected objects

This allows scalable puzzle design without hardcoding individual interactions.

## Built With

- Godot Engine 4.6.1
- GDScript
- 2D physics (CharacterBody2D and Area2D)

## Current Features

- Isometric player movement and animation system
- Pushable crate mechanics
- Floor switch activation system
- Door opening and closing system
- Sprite state changes based on interactions

## Planned Features

- Multiple crate types with different behaviors
- More complex switch combinations
- Timed and sequence-based puzzles
- Level transitions
- Audio feedback and polish improvements

## Design Goal

The goal of Chromablock is to create simple but satisfying isometric puzzle rooms where small mechanical interactions combine into larger logical challenges.
