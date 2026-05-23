# Fitbit Replica

A Fitbit-inspired activity tracking system implemented on an FPGA using Verilog. This project simulates core wearable fitness tracker functionality through digital hardware design and FPGA prototyping.

## Project Overview

The system tracks simulated movement data using a pulse generator and displays activity information on a seven-segment display. Different movement modes were implemented to emulate varying activity levels.

## Features

- Total step counting
- Distance tracking
- High activity time
- Seven-segment display output
- Multiple movement modes (walk, jog, run, hybrid)

## Files

## Source Files

| File | Description |
|-------|-------------|
| `Top.v` | Top-level module that connects the Fitbit tracker, pulse generator, display logic, and control signals. |
| `Pulse_Generator.v` | Generates simulated step pulses for different activity modes (walk, jog, run, hybrid). |
| `totalStepCount.v` | Tracks and updates the total number of detected steps. |
| `distanceCovered.v` | Calculates estimated distance traveled based on accumulated step count. |
| `highActivityTime.v` | Tracks sustained periods of high activity based on step-rate thresholds. |
| `stepsOver32.v` | Counts the number of seconds where activity exceeds 32 steps per second. |
| `binaryToBCD.v` | Converts binary values into BCD format for display output. |
| `BCDToSevenSegment.v` | Converts BCD values into seven-segment display signals. |
| `DisplayController.v` | Controls display multiplexing and rotates displayed Fitbit information. |
| `ClockDivider.v` | Reduces clock frequency for timing and display updates. |
| `tb_*.v` | Testbench files used to simulate and verify module functionality. |
