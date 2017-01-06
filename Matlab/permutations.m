%% Plot 1: Permutations 

%x-axis (in kilobytes)
memoryl2 = log2([2.344 14.648 58.594 131.836  234.375 1464.844 5859.375 13183.594 23437.500]);

memoryFP = memoryl2; 

%y-axis variables (in MFLOPS/s)
natMFLOPS = [1657.531 1737.248 1722.938 1820.201 1790.412 1459.729 1357.600 1338.640 1410.984];

mknMFLOPS = [1669.484 2237.021 2174.440 2347.731 2362.906 2495.389 2584.372 2579.091 2647.656];

kmnMFLOPS = [1694.178 1715.251 2185.604 2363.759 2432.226 2350.606 2422.848 2474.717 2464.947];

knmMFLOPS = [1342.414 1458.288 1543.887 1605.928 1653.034  968.252  621.985  626.797  628.236];

nkmMFLOPS = [1326.821 1376.625 1541.638 1622.800 1632.371  942.094  630.812  596.521  645.259];

nmkMFLOPS = [1614.073 1801.236 1742.267 1757.213 1783.677 1626.988 1439.758 1498.896 1511.946];

libMFLOPS = [2156.152 4616.871 4424.696 4007.367 4511.847 4640.353 4573.360 3980.559 4552.058];

%note: add horizontal line of 36,800 as theoretical peak

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
  hold off;

plot(memoryFP, natMFLOPS, memoryFP, mknMFLOPS, memoryFP, kmnMFLOPS, memoryFP, knmMFLOPS, memoryFP, nkmMFLOPS, memoryFP, nmkMFLOPS, memoryFP, libMFLOPS);
legend('nat', 'mkn', 'kmn', 'knm', 'nkm', 'nmk', 'lib', 'Location', 'NorthEast')
xlabel('Memory Footprint (kb)')
ylabel('Mflops/sec')
vline(log2(  35), 'k', 'L1')
vline(log2( 256), 'k', 'L2')
vline(log2(30700), 'k', 'L3')
%saveas(gcf, 'permutationsPlot.png');  

%% Plot 2: BLK : Performance for best permutation (nmk?) when changing Block Size

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
%saveas(gcf, 'blockSizePlot.png');  


%% Plot 3: BLK : 

memoryFP2 = log2([2.344 58.594 131.836  234.375 1464.844 5859.375 13183.594 23437.500 ]);

%b10  = []; 
b35  = [1187.995 1585.796 1492.042 1595.711 1506.629 1614.711 1579.804 1602.808];
%b100 = [];
b550 = [1246.331 1840.000 1934.367 1805.673 2122.493 2288.677 1956.010 1918.450];
b700 = [1300.929 1665.948 1991.171 1864.329 2131.478 2262.787 2193.315 2052.646]; 

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',14);
set(gcf, 'Color', 'w');
  hold off;
  
plot(memoryFP2, b35, memoryFP2, b550, memoryFP2, b700);
legend('b35', 'b550', 'b700', 'Location', 'NorthEast')

vline(log2(  35), 'k', 'L1')
vline(log2( 256), 'k', 'L2')
vline(log2(30700), 'k', 'L3')
xlabel('Memory Footprint (log2(kb))')
ylabel('Mflops/sec')
%saveas(gcf, 'blockSizePlot.png'); 
