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
Place earthquakes.csv in the same folder as earthquake_risk.m and run the script.

## Data
earthquakes.csv: USGS Earthquake Catalog (https://earthquake.usgs.gov/earthquakes/search/), magnitude 5.0+ earthquakes through December 31, 2009. Downloaded 08/03/26. 13,584 earthquakes.

Author: Andrew Zukowsky
