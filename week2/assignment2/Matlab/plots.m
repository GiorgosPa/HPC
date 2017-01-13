%% Plot 1: Permutations 
clear
close all
%x-axis (in kilobytes)
memoryFP = log([1.600000 6.400000 25.600000 102.400000 409.600000 1638.400000 6553.600000 26214.400000 64000.000000 108160.000000]);

%y-axis variables (in MFLOPS/s)



jacMFLOPS = [3735.262282 3259.987635 3039.079669 2953.680994 2836.005167 2758.214691 2539.027343 1983.362903 1651.073868 1719.338242];

gaussMFLOPS = [3888.043505 2640.190663 1886.628210 1641.067016 1534.335785 1486.305320 1463.261890 1444.946924 1434.286246 1437.160387];

jacomp1pMFLOPS = [896.687007  1110.588934 1143.779299 1126.134151 1123.330813 1121.606962 1106.877329 1091.728264 1089.993151 1089.467167];

jacomp2pMFLOPS = [80.508593 298.314360  833.613323  1567.998125 2025.394627 2168.813336 2191.957214 2197.379137 2160.075642 2154.990276];

jacomp1aMFLOPS = [903.749879  1110.314585 1142.240933 1126.860061 1124.288293 1120.794403 1106.567067 1091.476030 1088.252974 1087.259811];

jacomp2aMFLOPS = [167.154829  529.964480  1244.893599 1909.577943 2131.229343 2201.143833 2198.442547 2198.958710 2161.833518 2153.958826];

jacomp4aMFLOPS = [155.109459  556.864139  1624.790719 3134.164591 4025.523904 4314.433234 4354.302586 4365.806475 4290.047027 4285.969039];

jacomp8aMFLOPS = [132.096385  495.684194  1701.713831 4326.166032 7176.174030 8231.893618 8537.861399 8638.686232 8245.673375 8101.747311];

jacomp12aMFLOPS = [129.340561  505.245663  1559.918916 4932.983611 9392.862431 11816.16716 12539.37651 12831.06318 10143.58851 9008.478030];

jacomp16aMFLOPS = [122.218091  470.367710  1494.095785 4848.464474 10786.93025 14897.24316 16414.13487 16901.17646 10860.99567 10172.031286];

jacomp16aompifMFLOPS = [906.783309  1111.085100 1146.485139 4875.434789 10644.51101 14888.81606 16301.99209 16907.38364 10025.42441 10218.224859];

jacomp16acifMFLOPS = [3709.700390 3261.017826 3036.543347 4806.575329 10962.53896 14787.24924 16440.36655 16915.30610 10164.19994 9955.684405];

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, jacMFLOPS, memoryFP, gaussMFLOPS, memoryFP, jacomp1pMFLOPS, memoryFP, jacomp2pMFLOPS);
legend('jaccobi', 'gauss', 'jac opm 1 thread passive policy', 'jac opm 2 thread passive policy', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')
vline(log(35), 'k', 'L1')
vline(log(256), 'k', 'L2')
vline(log(30700), 'k', 'L3')
saveas(gcf, 'performance1.png');  

figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, jacMFLOPS, memoryFP, gaussMFLOPS, memoryFP, jacomp1aMFLOPS, memoryFP, jacomp2aMFLOPS, memoryFP, jacomp4aMFLOPS, memoryFP, jacomp8aMFLOPS, memoryFP, jacomp12aMFLOPS, memoryFP, jacomp16aMFLOPS);
legend('jaccobi', 'gauss', 'jac opm 1 thread active policy', 'jac opm 2 thread active policy', 'jac opm 4 thread active policy', 'jac opm 8 thread active policy', 'jac opm 12 thread active policy', 'jac opm 16 thread active policy', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')
vline(log(35), 'k', 'L1')
vline(log(256), 'k', 'L2')
vline(log(30700), 'k', 'L3')
saveas(gcf, 'performance2.png');


figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, jacMFLOPS, memoryFP, gaussMFLOPS, memoryFP, jacomp16aompifMFLOPS, memoryFP, jacomp16acifMFLOPS);
legend('jaccobi', 'gauss', 'jac opm 16 thread active policy omp condition', 'jac opm 16 thread active policy c condition', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')
vline(log(35), 'k', 'L1')
vline(log(256), 'k', 'L2')
vline(log(30700), 'k', 'L3')
saveas(gcf, 'performance3.png'); 

%% Plot 2: BLK : Performance for best permutation (mkn) when changing Block Size

%x-axis: block size
blockSize = [10 20 35 50 90 100 110 115 120 300 550 600 700 800 900 1000 1100 1200 1300 1400 1500 2000];
blkMFLOPS = [1736.375 1721.432 1593.550 1720.877 2234.976 2293.927 2320.875 2329.321 2315.167 2282.475  2397.009 2448.727 2470.655 2450.602 2564.082 2692.199 2731.257 2145.386 2243.436 2156.953 2009.851 1999.055];

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
  hold off;

plot(blockSize, blkMFLOPS);
vline(  35, 'k', 'L1')
vline( 115, 'k', 'L2')
vline(1100, 'k', 'L3')
xlabel('Block Size (# of elements)')
ylabel('Mflops/sec')
saveas(gcf, 'blockSizePlot.png');  


%% Plot 3: BLK : 

memoryFP2 = log2([2.344 14.648 58.594 131.836 234.375 1464.844 5859.375 13183.594 23437.500 93750.000]);

%b10  = []; 
b35  = [1187.995 1787.822 1585.796 1492.042 1595.711 1506.629 1614.711 1579.804 1602.808 1658.971];
b100 = [1387.556 1736.331 1799.174 2185.479 2308.248 2156.930 2239.147 2281.437 2311.155 2294.255];
b550 = [1246.331 1890.386 1840.000 1934.367 1805.673 2122.493 2288.677 1956.010 1918.450 2649.848];
b700 = [1300.929 1876.420 1665.948 1991.171 1864.329 2131.478 2262.787 2193.315 2052.646 2691.293]; 

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
  hold off;
  
plot(memoryFP2, b35, memoryFP2, b100, memoryFP2, b550, memoryFP2, b700, memoryFP, mknMFLOPS, memoryFP, libMFLOPS);
legend('b35', 'b100','b550', 'b700', 'mkn', 'lib', 'Location', 'NorthEast')

vline(log2(  35), 'k', 'L1')
vline(log2( 256), 'k', 'L2')
vline(log2(30700), 'k', 'L3')
xlabel('Memory Footprint (log2(kb))')
ylabel('Mflops/sec')
saveas(gcf, 'blockSizePlot2.png'); 
