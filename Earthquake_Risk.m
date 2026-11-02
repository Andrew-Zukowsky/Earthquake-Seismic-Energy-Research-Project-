Earthquake Seismic Energy Research Project 

The dataset contains 13,584 earthquakes, so full results tables are not displayed. Each table shows the first 10 rows as a preview. All values are still calculated and used in the analysis.
%earthquakes=readtable("earthquakes.csv")
disp('Eathquakes')
head(earthquakes, 10)

Key Equations
%Equation list

%Surface Distance
% d = R_E * theta * (pi/180)

%Energy Released
%log10(E) = 5.24 + 1.44M

%Hypo Distance
%D = sqrt(distance^2 + depth^2)

%Impact
%E = Energy/((Hypo Distance)^R)

%Risk Score
%Risk = (1/3)*(log10(E)/Max_log10(E)) + (1/3)*(1 - (Distance/Max_Distance))
% +(1/3)*(1 - (Depth/Max_Depth))

Distance Calculations 
cities = [
34.008, 71.57849; % City 1 (Peshawar, Pakistan)
25.04776, 121.53185; % City 2 (Taipei, Taiwan)
32.7157, -117.1611 % City 3 (San Diego, California)
]

% 2. Initialize a matrix to store distances (Earthquakes x Cities)
num_eq = size(earthquakes, 1)
num_cities = size(cities, 1);
dist_matrix = zeros(num_eq, num_cities);

% 3. Calculate distance in degrees and convert to kilometers
earth_radius_km = 6371;

for i = 1:num_eq
for j = 1:num_cities

%q= earthquakes(i,2)

% distance() returns degrees by default
deg_dist = distance(earthquakes.latitude(i), earthquakes.longitude(i), cities(j,1), cities(j,2));

% Convert degrees to kilometers
dist_matrix(i,j) =  deg_dist * (pi/180) * earth_radius_km;

%[earthquakes.mag(i),
%dist_matrix_mag(i,4) = [earthquakes.mag(i), dist_matrix(i,j)]
end
end

% Display the result matrix (Rows = Earthquakes, Columns = Cities)

%disp('Distance Matrix (in km):');
%disp(dist_matrix);

%dist_matrix_mag = [earthquakes.mag, dist_matrix]


Distance Table
% Convert matrix to a table
% Insert a leading column for place name
% Rename columns to make sense

%resultsTable = array2table(dist_matrix_mag);
%resultsTable = addvars(resultsTable, earthquakes.place, 'Before', 'dist_matrix_mag1', 'NewVariableNames', 'Place');
%resultsTable = renamevars(resultsTable,"dist_matrix_mag1","Magnitude");
%resultsTable = renamevars(resultsTable,"dist_matrix_mag2","Peshawar, Pakistan");
%resultsTable = renamevars(resultsTable,"dist_matrix_mag3","Taipei, Taiwan");
%resultsTable = renamevars(resultsTable,"dist_matrix_mag4","San Diego")
disp('resultsTable')
head(resultsTable, 10)

Magnitude to Energy Calculations
%largest ever mag was 9.5

%mag = earthquakes.mag

%log10 E = 5.24 + 1.44 • Magnitude

Testmag = 9.5;
TestEnergy = (5.24 + (1.44 * (Testmag)));

maxMag = 9.5
MaxLog_Energy = (5.24 + (1.44 * (maxMag)))


%fix this loop equation 
for i = 1:num_eq
    
   Energy(i,1) = 10 ^ (5.24 + (1.44 * (earthquakes.mag(i))));

end
%disp('Energy');
%disp(Energy)


Percent Energy Calculations 
%EnergyTable = table((1:num_eq), Energy)
%VariableNames ={earthquakes,Energy}

Log_Energy = (5.24 + (1.44 .* (earthquakes.mag)));

%EnergyRisk = (Log_Energy/MaxLog_Energy)

%percentEnergy = (1/3).*(EnergyRisk)

Percent Depth Calculations
%most severe depth is on the surface at 0
%try using z score for depth distance like from deepest earth quake of 735.8km vs at 0

maxDepth = 735.8

depth = 0

%DepthRisk = (1 - ((earthquakes.depth) ./ maxDepth))

%percentDepth = (1/3).*(DepthRisk)

Hypo Distance
%Hypo distance

%Hyp_dist = sqrt(((dist_matrix).^2) + ((earthquakes.depth) .^ 2));

%format shortG 
%disp('Hypo_Distance')
%disp(Hyp_dist)

Realized Risk for All Earthquakes
%trying to used realized risk in order to get a more accurate percent of
%risk

%Realized_Risk = Raw Energy / ((Distance)^2 + (Depth)^2)

%Energy = 10 .^ Log_Energy

%We use R as 1.3 to account for the curvature of the earth in our
%calculation

R = 1.3;

Realized_Risk = Energy ./ (Hyp_dist.^R);

%format shortG
disp('Realized_Risk')
%disp(Realized_Risk)
head(Realized_Risk,10)

Realized Risk with Adjustments for Distance, Depth, and Magnitude/Energy
%Calculation from damage
%We need to ignore some factors like earthquakes being to far or having to
%low of a magnitude
%We also need to ignore the depth if it is a certain distance from the
%surface
%If the mag is very low it wont have any effect

minMag_mesausre = 4.0
maxdepth_mesausre = 300 
maxDist_mesausre = 1000

for i = 1:num_eq
for j = 1:num_cities
    if earthquakes.mag(i) >= minMag_mesausre && earthquakes.depth(i) <= maxdepth_mesausre && Hyp_dist(i,j) <= maxDist_mesausre
        Realized_Adujusted_Risk(i,j) = Energy(i) / Hyp_dist(i,j)^R;
    end
end
end

%format shortG
disp('Realized_Adujusted_Risk')
%disp(Realized_Adujusted_Risk)
head(Realized_Adujusted_Risk,10)

%this uses lat and long as functions of x and y
%we can use the total distance function that we made and draw the values
%from results table
%This is similar to depth in that both are the most effective when they are
%closet to the zero 
%this means the closer distance is the zero the more damage will occur 


max_sphere_distance = earth_radius_km * pi

Testdistance = 8677.97026216461;

%DistanceRisk = (1 - (dist_matrix ./ max_sphere_distance))

%percentDistance = (1/3) .* (DistanceRisk)


%this is a calculation for risk factor with mag depth and distance each
%being 1/3 of the score for risk 

%Risk_Score = percentDistance + percentDepth + percentEnergy
%Risk_Score_percent = Risk_Score * 100
disp('Risk_Score_percent')
head(Risk_Score_percent, 10)

%put depth mag and distance in total most severe value of each 
%take these value make each on 1/3 of the risk and add them 

Energy Histograms for each City
histogram(log10(Realized_Risk(:,1)))
xlabel('log10 Energy Recived')
ylabel('Number of earthquakes')
title('Energy Received at Peshawar, Pakistan')

histogram(log10(Realized_Risk(:,2)))
xlabel('log10 Energy Recived')
ylabel('Number of earthquakes')
title('Energy Received at Taipei, Taiwan')

histogram(log10(Realized_Risk(:,3)))
xlabel('log10 Energy Recived')
ylabel('Number of earthquakes')
title('Energy Received at San Diego, California')

Mean, Median, Mode, and Standard Deviation Calculations 
mean1 = mean(log10(Realized_Risk(:,1)));
med1 = median(log10(Realized_Risk(:,1)));
mo1 = mode(round(log10(Realized_Risk(:,1))));
s1 = std(log10(Realized_Risk(:,1)));

mean2 = mean(log10(Realized_Risk(:,2)));
med2 = median(log10(Realized_Risk(:,2)));
mo2 = mode(round(log10(Realized_Risk(:,2))));
s2= std(log10(Realized_Risk(:,2)));

mean3 = mean(log10(Realized_Risk(:,3)));
med3 = median(log10(Realized_Risk(:,3)));
mo3 = mode(round(log10(Realized_Risk(:,3))));
s3 = std(log10(Realized_Risk(:,3)));


statsTable = array2table([mean1,mean2,mean3; med1,med2,med3; mo1,mo2,mo3; s1,s2,s3], 'VariableNames', {'Peshawar', 'Taipei', 'San Diego'}, 'RowNames', {'Mean', 'Median', 'Mode', 'Std Dev'})

Combined Histogram for Energy
logRec = log10(Realized_Risk);
edges  = floor(min(logRec(:))) : 0.5 : ceil(max(logRec(:)));   % same bins for all the cites

figure
hold on
histogram(logRec(:,1), edges, 'FaceAlpha', 0.5)   % Peshawar
histogram(logRec(:,2), edges, 'FaceAlpha', 0.5)   % Taipei
histogram(logRec(:,3), edges, 'FaceAlpha', 0.5)   % San Diego
hold off
xlabel('log10(Energy received)')
ylabel('Number of earthquakes')
title('Energy Received at All Cities')
legend('Peshawar', 'Taipei', 'San Diego')

Earthquake and City Display 
geoscatter(earthquakes.latitude, earthquakes.longitude, 10, earthquakes.mag, 'filled')
hold on
geoscatter(cities(:,1), cities(:,2), 100, 'r', 'p', 'filled')   % cities as red stars
colorbar, title('Earthquakes (color = magnitude) and cities')
