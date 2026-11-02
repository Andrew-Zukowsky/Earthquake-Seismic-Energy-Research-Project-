# Earthquake-Seismic-Energy-Research-Project-
MatLab Model of Earthquake response for three cities

# Earthquake Seismic Energy Risk Model (MATLAB)
Independent research project analyzing how much seismic energy three cities receive from 13,584 recorded earthquakes: Peshawar (Pakistan), Taipei (Taiwan), and San Diego (California).

## What it does
- Calculates each earthquake's surface and hypocentral distance to each city
- Converts magnitude to energy released (log10 E = 5.24 + 1.44M)
- Estimates energy received at each city (E / D^1.3)
- Filters out quakes too weak (M < 4), too deep (>300 km), or too far (>1000 km) to cause damage
- Builds a combined risk score weighting energy, distance, and depth equally
- Compares cities with histograms, summary statistics, and a world map of quakes and cities

## How to run
Requires MATLAB with the Mapping Toolbox (for distance() and geoscatter).
Place earthquakes.csv in the same folder and run the script.

## Data
earthquakes.csv: USGS Earthquake Hazards Program, real-time CSV feed
(https://earthquake.usgs.gov/earthquakes/feed/v1.0/csv.php),
downloaded [08/3/26]. 13,584 earthquakes.

Author: Andrew Zukowsky
