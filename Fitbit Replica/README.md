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
| `high_activity_part4.v` | Tracks sustained periods of high activity based on step-rate thresholds. |
| `num_over_32.v` | Counts the number of seconds where activity exceeds 32 steps per second. |
| `binaryToBCD.v` | Converts binary values into BCD format for display output. |
| `BCDToSevenSegment.v` | Converts BCD values into seven-segment display signals. |
| `oneSecondCounter_pulse.v` | Generates a pulse signal every two seconds. |
| `OneSecondCounter.v` | Tracks elapsed time in seconds and increments a counter. |
| `oneHZperiodclock.v` | Generates one-second and two-second timing signals. |
| `combinationalMux_14BitOutput.v` | Selects and routes Fitbit tracking data to the display output based on the current display mode. |
| `outputSelector.v` | Controls which Fitbit data is displayed by rotating between outputs every two seconds and routes data to the seven-segment display. |
| `binaryTo_4Digit_SevenSeg.v` | Converts Fitbit tracking data into multiplexed four-digit seven-segment display output for real-time visualization. |
| `mileTo_4Digit_SevenSeg.v` | Converts distance data into a four-digit seven-segment display format for real-time mileage visualization. |
| `BCDToSevenSegment.v` | Converts a single BCD digit into the corresponding seven-segment display output. |
| `tb_*.v` | Testbench files used to simulate and verify module functionality. |
