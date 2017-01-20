memoryl2 = log2([2.344 14.648 58.594 131.836  234.375 1464.844 5859.375 13183.594 23437.500 93750.000]);

memoryFP = memoryl2; 

gpu1MFLOPS = [2.288  4.811 5.205 5.274 5.298 5.328 4.883 4.880 4.937 4.880];

gpu2MFLOPS = [4.023 60.880 457.520 1403.646 3005.801 13948.402 29513.848 35699.175 39936.900 49142.313];

gpu3MFLOPS = [3.981 57.734 413.621 1245.842 2573.936 11114.035 22991.888 27399.818 31740.490 37581.711];

gpu4MFLOPS = [3.734 51.285 325.185 1060.113 1845.138 9237.336 20131.256 24968.189 29872.147 36700.531];
     
gpu532MFLOPS = [4.315 66.689 476.652 1495.340 3242.647 19319.580 56240.406 86529.587 109697.236 163604.201];

gpu516MFLOPS = [4.082 63.239 124.357 914.988 5949.367 19913.609 55063.683 85963.532 105844.726 147824.512 ];

gpu58MFLOPS = [3.976 71.485 125.548 931.240 5857.966 3596.017 45988.600 68364.750 81034.061 103222.074];

gpulibMFLOPS = [14.827 58.576 1383.111 3829.135 3040.484 19717.954 65189.048 119224.248 166278.683 324833.523];

mknMFLOPS = [1669.484 2237.021 2174.440 2347.731 2362.906 2495.389 2584.372 2579.091 2647.656 2514.919];

libSTMFLOPS = [2156.152 4616.871 4424.696 4007.367 4511.847 4640.353 4573.360 3980.559 4552.058 5033.796];

libMFLOPS = [2183.406 1399.713 3223.810 2675.022 4888.661 7189.015 8085.695 7449.673 8142.759 8712.409];

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu1MFLOPS, memoryFP, libSTMFLOPS, memoryFP, libMFLOPS);
legend('gpu1', 'lib 1 core', 'lib 2 cores', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec') 

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu2MFLOPS, memoryFP, libSTMFLOPS, memoryFP, libMFLOPS);
legend('gpu2', 'lib 1 core', 'lib 2 cores', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu3MFLOPS, memoryFP, libSTMFLOPS, memoryFP, libMFLOPS);
legend('gpu3', 'lib 1 core', 'lib 2 cores', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu4MFLOPS, memoryFP, libSTMFLOPS, memoryFP, libMFLOPS);
legend('gpu4', 'lib 1 core', 'lib 2 cores', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu532MFLOPS, memoryFP, gpu516MFLOPS, memoryFP, gpu58MFLOPS);
legend('gpu5 block size 32', 'gpu5 block size 16', 'gpu5 block size 8', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu532MFLOPS, memoryFP, libSTMFLOPS, memoryFP, libMFLOPS);
legend('gpu5 block size 32', 'lib 1 core', 'lib 2 cores', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',18);
set(gcf, 'Color', 'w');
  hold on;

plot(memoryFP, gpu532MFLOPS, memoryFP, gpulibMFLOPS, memoryFP, gpu2MFLOPS, memoryFP, gpu3MFLOPS, memoryFP, gpu4MFLOPS, memoryFP, libMFLOPS);
legend('gpu5 block size 32', 'gpulib', 'gpu2', 'gpu3', 'gpu4', 'lib', 'Location', 'NorthWest')
xlabel('Memory Footprint log(KB)')
ylabel('Mflops/sec')

