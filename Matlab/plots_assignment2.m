%% data

%{
409.600000 1764.983276 6267.696292 0.159548 15.954825 #jacompsimple 
409.600000 1125.814329 3997.920203 0.250130 25.013005 #jacomp 
409.600000 3187.072513 11317.729095 0.088357 8.835695 #jacompsimple 
409.600000 2132.789504 7573.826363 0.132034 13.203366 #jacomp 
409.600000 5947.005385 21118.627077 0.047352 4.735156 #jacompsimple 
409.600000 4035.807410 14331.702449 0.069775 6.977538 #jacomp 
409.600000 8155.184382 28960.171810 0.034530 3.453018 #jacompsimple 
409.600000 5768.165318 20483.541612 0.048820 4.881968 #jacomp 
409.600000 9672.906127 34349.808690 0.029112 2.911224 #jacompsimple 
409.600000 7136.330933 25342.084278 0.039460 3.946005 #jacomp 
409.600000 10925.712971 38798.696628 0.025774 2.577406 #jacompsimple 
409.600000 8299.591929 29472.982703 0.033929 3.392938 #jacomp 
409.600000 12270.609731 43574.608421 0.022949 2.294914 #jacompsimple 
409.600000 9422.773447 33461.553435 0.029885 2.988504 #jacomp 
409.600000 12420.156348 44105.668850 0.022673 2.267282 #jacompsimple 
409.600000 10316.242629 36634.384337 0.027297 2.729676 #jacomp 
409.600000 13343.624649 47385.030714 0.021104 2.110371 #jacompsimple 
409.600000 10889.918681 38671.586226 0.025859 2.585878 #jacomp 
409.600000 12693.212683 45075.329129 0.022185 2.218508 #jacompsimple 
409.600000 11334.547988 40250.525527 0.024844 2.484440 #jacomp 
409.600000 489.780157 1739.276127 0.574952 57.495183 #jacompsimple 
409.600000 160.366781 569.484307 1.755975 175.597464 #jacomp
%}

%%  Initializing

%xaxis
threads = [1 2 4 6 8 10 12 14 16 18];

%for speed up calculations
t1_jomp = 25.013;
t1_jompsimple = 15.955;

jomp_time = [25.013 13.203366 6.977538 4.881968 3.946005 3.392938 2.988504 2.729676 2.585878 2.484440];
jomp_simple = [15.955 8.835695 4.735156 3.453018 2.911224 2.577406 2.294914 2.267282 2.110371 2.218508];

%yaxis
jomp_SU = t1_jomp ./ jomp_time;
jompsimple_SU = t1_jompsimple ./ jomp_simple; 

%fraction of parallel code
f_jomp = (1 - (jomp_time ./ t1_jomp)) / (1 - (1 ./ threads));
f_jompsimple = (1 - (jomp_simple ./ t1_jompsimple)) / (1 - (1 ./ threads));

%% Plotting 

%Plotting
figure('Position', [100, 0, 1000,1000]);
set(gca,'fontsize',20);
set(gcf, 'Color', 'w');
  hold on;

plot(threads, jomp_SU, threads, jompsimple_SU, threads, threads);
AX= legend('JACCOBI OMP', 'JACCOBI OMP SIMPLE', 'AMDAHLS', 'Location', 'NorthWest');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',20)
axis([1 18 1 11])
xlabel('Number of Threads')
ylabel('Speed Up')
saveas(gcf, 'speedupJaccobi.eps'); 

%% MATRIX PLOTS

u = [0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000;	
0.000000	-0.106377	-0.201226	-0.274270	-0.317592	-0.326498	-0.300022	-0.241035	-0.155928	-0.053924	0.053924	0.155928	0.241035	0.300022	0.326498	0.317592	0.274270	0.201226	0.106377	0.000000;	
0.000000	-0.201226	-0.380646	-0.518818	-0.600767	-0.617614	-0.567533	-0.455951	-0.294959	-0.102004	0.102004	0.294959	0.455951	0.567533	0.617614	0.600767	0.518818	0.380646	0.201226	0.000000;	
0.000000	-0.274270	-0.518818	-0.707144	-0.818840	-0.841802	-0.773542	-0.621457	-0.402027	-0.139031	0.139031	0.402027	0.621457	0.773542	0.841802	0.818840	0.707144	0.518818	0.274270	0.000000;	
0.000000	-0.317592	-0.600767	-0.818840	-0.948179	-0.974768	-0.895726	-0.719618	-0.465528	-0.160991	0.160991	0.465528	0.719618	0.895726	0.974768	0.948179	0.818840	0.600767	0.317592	0.000000;	
0.000000	-0.326498	-0.617614	-0.841802	-0.974768	-1.002103	-0.920844	-0.739798	-0.478583	-0.165506	0.165506	0.478583	0.739798	0.920844	1.002103	0.974768	0.841802	0.617614	0.326498	0.000000;	
0.000000	-0.300022	-0.567533	-0.773542	-0.895726	-0.920844	-0.846175	-0.679809	-0.439776	-0.152085	0.152085	0.439776	0.679809	0.846175	0.920844	0.895726	0.773542	0.567533	0.300022	0.000000;	
0.000000	-0.241035	-0.455951	-0.621457	-0.719618	-0.739798	-0.679809	-0.546152	-0.353312	-0.122184	0.122184	0.353312	0.546152	0.679809	0.739798	0.719618	0.621457	0.455951	0.241035	0.000000;	
0.000000	-0.155928	-0.294959	-0.402027	-0.465528	-0.478583	-0.439776	-0.353312	-0.228561	-0.079042	0.079042	0.228561	0.353312	0.439776	0.478583	0.465528	0.402027	0.294959	0.155928	0.000000;	
0.000000	-0.053924	-0.102004	-0.139031	-0.160991	-0.165506	-0.152085	-0.122184	-0.079042	-0.027335	0.027335	0.079042	0.122184	0.152085	0.165506	0.160991	0.139031	0.102004	0.053924	0.000000;	
0.000000	0.053924	0.102004	0.139031	0.160991	0.165506	0.152085	0.122184	0.079042	0.027335	-0.027335	-0.079042	-0.122184	-0.152085	-0.165506	-0.160991	-0.139031	-0.102004	-0.053924	0.000000;	
0.000000	0.155928	0.294959	0.402027	0.465528	0.478583	0.439776	0.353312	0.228561	0.079042	-0.079042	-0.228561	-0.353312	-0.439776	-0.478583	-0.465528	-0.402027	-0.294959	-0.155928	0.000000;	
0.000000	0.241035	0.455951	0.621457	0.719618	0.739798	0.679809	0.546152	0.353312	0.122184	-0.122184	-0.353312	-0.546152	-0.679809	-0.739798	-0.719618	-0.621457	-0.455951	-0.241035	0.000000;	
0.000000	0.300022	0.567533	0.773542	0.895726	0.920844	0.846175	0.679809	0.439776	0.152085	-0.152085	-0.439776	-0.679809	-0.846175	-0.920844	-0.895726	-0.773542	-0.567533	-0.300022	0.000000;	
0.000000	0.326498	0.617614	0.841802	0.974768	1.002103	0.920844	0.739798	0.478583	0.165506	-0.165506	-0.478583	-0.739798	-0.920844	-1.002103	-0.974768	-0.841802	-0.617614	-0.326498	0.000000;	
0.000000	0.317592	0.600767	0.818840	0.948179	0.974768	0.895726	0.719618	0.465528	0.160991	-0.160991	-0.465528	-0.719618	-0.895726	-0.974768	-0.948179	-0.818840	-0.600767	-0.317592	0.000000;	
0.000000	0.274270	0.518818	0.707144	0.818840	0.841802	0.773542	0.621457	0.402027	0.139031	-0.139031	-0.402027	-0.621457	-0.773542	-0.841802	-0.818840	-0.707144	-0.518818	-0.274270	0.000000;	
0.000000	0.201226	0.380646	0.518818	0.600767	0.617614	0.567533	0.455951	0.294959	0.102004	-0.102004	-0.294959	-0.455951	-0.567533	-0.617614	-0.600767	-0.518818	-0.380646	-0.201226	0.000000;	
0.000000	0.106377	0.201226	0.274270	0.317592	0.326498	0.300022	0.241035	0.155928	0.053924	-0.053924	-0.155928	-0.241035	-0.300022	-0.326498	-0.317592	-0.274270	-0.201226	-0.106377	0.000000;	
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000;	];

dif = [-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000;	
-0.000000	0.000947	0.001792	0.002442	0.002828	0.002907	0.002671	0.002146	0.001388	0.000480	-0.000480	-0.001388	-0.002146	-0.002671	-0.002907	-0.002828	-0.002442	-0.001792	-0.000947	0.000000	;
-0.000000	0.001792	0.003389	0.004619	0.005349	0.005499	0.005053	0.004060	0.002626	0.000908	-0.000908	-0.002626	-0.004060	-0.005053	-0.005499	-0.005349	-0.004619	-0.003389	-0.001792	0.000000	;
-0.000000	0.002442	0.004619	0.006296	0.007291	0.007495	0.006887	0.005533	0.003580	0.001238	-0.001238	-0.003580	-0.005533	-0.006887	-0.007495	-0.007291	-0.006296	-0.004619	-0.002442	0.000000	;
-0.000000	0.002828	0.005349	0.007291	0.008442	0.008679	0.007975	0.006407	0.004145	0.001433	-0.001433	-0.004145	-0.006407	-0.007975	-0.008679	-0.008442	-0.007291	-0.005349	-0.002828	0.000000	;
-0.000000	0.002907	0.005499	0.007495	0.008679	0.008922	0.008199	0.006587	0.004261	0.001474	-0.001474	-0.004261	-0.006587	-0.008199	-0.008922	-0.008679	-0.007495	-0.005499	-0.002907	0.000000	;
-0.000000	0.002671	0.005053	0.006887	0.007975	0.008199	0.007534	0.006053	0.003916	0.001354	-0.001354	-0.003916	-0.006053	-0.007534	-0.008199	-0.007975	-0.006887	-0.005053	-0.002671	0.000000	;
-0.000000	0.002146	0.004060	0.005533	0.006407	0.006587	0.006053	0.004863	0.003146	0.001088	-0.001088	-0.003146	-0.004863	-0.006053	-0.006587	-0.006407	-0.005533	-0.004060	-0.002146	0.000000	;
-0.000000	0.001388	0.002626	0.003580	0.004145	0.004261	0.003916	0.003146	0.002035	0.000704	-0.000704	-0.002035	-0.003146	-0.003916	-0.004261	-0.004145	-0.003580	-0.002626	-0.001388	0.000000	;
-0.000000	0.000480	0.000908	0.001238	0.001433	0.001474	0.001354	0.001088	0.000704	0.000243	-0.000243	-0.000704	-0.001088	-0.001354	-0.001474	-0.001433	-0.001238	-0.000908	-0.000480	0.000000	;
0.000000	-0.000480	-0.000908	-0.001238	-0.001433	-0.001474	-0.001354	-0.001088	-0.000704	-0.000243	0.000243	0.000704	0.001088	0.001354	0.001474	0.001433	0.001238	0.000908	0.000480	-0.000000	;
0.000000	-0.001388	-0.002626	-0.003580	-0.004145	-0.004261	-0.003916	-0.003146	-0.002035	-0.000704	0.000704	0.002035	0.003146	0.003916	0.004261	0.004145	0.003580	0.002626	0.001388	-0.000000	;
0.000000	-0.002146	-0.004060	-0.005533	-0.006407	-0.006587	-0.006053	-0.004863	-0.003146	-0.001088	0.001088	0.003146	0.004863	0.006053	0.006587	0.006407	0.005533	0.004060	0.002146	-0.000000	;
0.000000	-0.002671	-0.005053	-0.006887	-0.007975	-0.008199	-0.007534	-0.006053	-0.003916	-0.001354	0.001354	0.003916	0.006053	0.007534	0.008199	0.007975	0.006887	0.005053	0.002671	-0.000000	;
0.000000	-0.002907	-0.005499	-0.007495	-0.008679	-0.008922	-0.008199	-0.006587	-0.004261	-0.001474	0.001474	0.004261	0.006587	0.008199	0.008922	0.008679	0.007495	0.005499	0.002907	-0.000000	;
0.000000	-0.002828	-0.005349	-0.007291	-0.008442	-0.008679	-0.007975	-0.006407	-0.004145	-0.001433	0.001433	0.004145	0.006407	0.007975	0.008679	0.008442	0.007291	0.005349	0.002828	-0.000000	;
0.000000	-0.002442	-0.004619	-0.006296	-0.007291	-0.007495	-0.006887	-0.005533	-0.003580	-0.001238	0.001238	0.003580	0.005533	0.006887	0.007495	0.007291	0.006296	0.004619	0.002442	-0.000000	;
0.000000	-0.001792	-0.003389	-0.004619	-0.005349	-0.005499	-0.005053	-0.004060	-0.002626	-0.000908	0.000908	0.002626	0.004060	0.005053	0.005499	0.005349	0.004619	0.003389	0.001792	-0.000000	;
0.000000	-0.000947	-0.001792	-0.002442	-0.002828	-0.002907	-0.002671	-0.002146	-0.001388	-0.000480	0.000480	0.001388	0.002146	0.002671	0.002907	0.002828	0.002442	0.001792	0.000947	-0.000000	;
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	;
 ];

f = [-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000;	
-0.000000	-2.081100	-3.936680	-5.365660	-6.213187	-6.387420	-5.869476	-4.715483	-3.050495	-1.054938	1.054938	3.050495	4.715483	5.869476	6.387420	6.213187	5.365660	3.936680	2.081100	0.000000	;
-0.000000	-3.936680	-7.446760	-10.149867	-11.753080	-12.082663	-11.102903	-8.919970	-5.770421	-1.995557	1.995557	5.770421	8.919970	11.102903	12.082663	11.753080	10.149867	7.446760	3.936680	0.000000	;
-0.000000	-5.365660	-10.149867	-13.834179	-16.019343	-16.468563	-15.133158	-12.157841	-7.865033	-2.719926	2.719926	7.865033	12.157841	15.133158	16.468563	16.019343	13.834179	10.149867	5.365660	0.000000	;
-0.000000	-6.213187	-11.753080	-16.019343	-18.549662	-19.069838	-17.523501	-14.078220	-9.107346	-3.149549	3.149549	9.107346	14.078220	17.523501	19.069838	18.549662	16.019343	11.753080	6.213187	0.000000	;
-0.000000	-6.387420	-12.082663	-16.468563	-19.069838	-19.604600	-18.014900	-14.473006	-9.362737	-3.237870	3.237870	9.362737	14.473006	18.014900	19.604600	19.069838	16.468563	12.082663	6.387420	0.000000	;
-0.000000	-5.869476	-11.102903	-15.133158	-17.523501	-18.014900	-16.554106	-13.299417	-8.603530	-2.975317	2.975317	8.603530	13.299417	16.554106	18.014900	17.523501	15.133158	11.102903	5.869476	0.000000	;
-0.000000	-4.715483	-8.919970	-12.157841	-14.078220	-14.473006	-13.299417	-10.684630	-6.911997	-2.390343	2.390343	6.911997	10.684630	13.299417	14.473006	14.078220	12.157841	8.919970	4.715483	0.000000	;
-0.000000	-3.050495	-5.770421	-7.865033	-9.107346	-9.362737	-8.603530	-6.911997	-4.471442	-1.546337	1.546337	4.471442	6.911997	8.603530	9.362737	9.107346	7.865033	5.770421	3.050495	0.000000	;
-0.000000	-1.054938	-1.995557	-2.719926	-3.149549	-3.237870	-2.975317	-2.390343	-1.546337	-0.534762	0.534762	1.546337	2.390343	2.975317	3.237870	3.149549	2.719926	1.995557	1.054938	0.000000	;
0.000000	1.054938	1.995557	2.719926	3.149549	3.237870	2.975317	2.390343	1.546337	0.534762	-0.534762	-1.546337	-2.390343	-2.975317	-3.237870	-3.149549	-2.719926	-1.995557	-1.054938	-0.000000	;
0.000000	3.050495	5.770421	7.865033	9.107346	9.362737	8.603530	6.911997	4.471442	1.546337	-1.546337	-4.471442	-6.911997	-8.603530	-9.362737	-9.107346	-7.865033	-5.770421	-3.050495	-0.000000	;
0.000000	4.715483	8.919970	12.157841	14.078220	14.473006	13.299417	10.684630	6.911997	2.390343	-2.390343	-6.911997	-10.684630	-13.299417	-14.473006	-14.078220	-12.157841	-8.919970	-4.715483	-0.000000	;
0.000000	5.869476	11.102903	15.133158	17.523501	18.014900	16.554106	13.299417	8.603530	2.975317	-2.975317	-8.603530	-13.299417	-16.554106	-18.014900	-17.523501	-15.133158	-11.102903	-5.869476	-0.000000	;
0.000000	6.387420	12.082663	16.468563	19.069838	19.604600	18.014900	14.473006	9.362737	3.237870	-3.237870	-9.362737	-14.473006	-18.014900	-19.604600	-19.069838	-16.468563	-12.082663	-6.387420	-0.000000	;
0.000000	6.213187	11.753080	16.019343	18.549662	19.069838	17.523501	14.078220	9.107346	3.149549	-3.149549	-9.107346	-14.078220	-17.523501	-19.069838	-18.549662	-16.019343	-11.753080	-6.213187	-0.000000	;
0.000000	5.365660	10.149867	13.834179	16.019343	16.468563	15.133158	12.157841	7.865033	2.719926	-2.719926	-7.865033	-12.157841	-15.133158	-16.468563	-16.019343	-13.834179	-10.149867	-5.365660	-0.000000	;
0.000000	3.936680	7.446760	10.149867	11.753080	12.082663	11.102903	8.919970	5.770421	1.995557	-1.995557	-5.770421	-8.919970	-11.102903	-12.082663	-11.753080	-10.149867	-7.446760	-3.936680	-0.000000	;
0.000000	2.081100	3.936680	5.365660	6.213187	6.387420	5.869476	4.715483	3.050495	1.054938	-1.054938	-3.050495	-4.715483	-5.869476	-6.387420	-6.213187	-5.365660	-3.936680	-2.081100	-0.000000	;
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	;
];

s = [-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000;	
-0.000000	-0.105430	-0.199435	-0.271828	-0.314764	-0.323590	-0.297351	-0.238889	-0.154540	-0.053444	0.053444	0.154540	0.238889	0.297351	0.323590	0.314764	0.271828	0.199435	0.105430	0.000000	;
-0.000000	-0.199435	-0.377257	-0.514198	-0.595418	-0.612115	-0.562480	-0.451891	-0.292333	-0.101096	0.101096	0.292333	0.451891	0.562480	0.612115	0.595418	0.514198	0.377257	0.199435	0.000000	;
-0.000000	-0.271828	-0.514198	-0.700848	-0.811549	-0.834307	-0.766655	-0.615923	-0.398447	-0.137793	0.137793	0.398447	0.615923	0.766655	0.834307	0.811549	0.700848	0.514198	0.271828	0.000000	;
-0.000000	-0.314764	-0.595418	-0.811549	-0.939737	-0.966089	-0.887751	-0.713211	-0.461384	-0.159558	0.159558	0.461384	0.713211	0.887751	0.966089	0.939737	0.811549	0.595418	0.314764	0.000000	;
-0.000000	-0.323590	-0.612115	-0.834307	-0.966089	-0.993181	-0.912645	-0.733211	-0.474322	-0.164032	0.164032	0.474322	0.733211	0.912645	0.993181	0.966089	0.834307	0.612115	0.323590	0.000000	;
-0.000000	-0.297351	-0.562480	-0.766655	-0.887751	-0.912645	-0.838641	-0.673756	-0.435860	-0.150731	0.150731	0.435860	0.673756	0.838641	0.912645	0.887751	0.766655	0.562480	0.297351	0.000000	;
-0.000000	-0.238889	-0.451891	-0.615923	-0.713211	-0.733211	-0.673756	-0.541290	-0.350166	-0.121096	0.121096	0.350166	0.541290	0.673756	0.733211	0.713211	0.615923	0.451891	0.238889	0.000000	;
-0.000000	-0.154540	-0.292333	-0.398447	-0.461384	-0.474322	-0.435860	-0.350166	-0.226526	-0.078338	0.078338	0.226526	0.350166	0.435860	0.474322	0.461384	0.398447	0.292333	0.154540	0.000000	;
-0.000000	-0.053444	-0.101096	-0.137793	-0.159558	-0.164032	-0.150731	-0.121096	-0.078338	-0.027091	0.027091	0.078338	0.121096	0.150731	0.164032	0.159558	0.137793	0.101096	0.053444	0.000000	;
0.000000	0.053444	0.101096	0.137793	0.159558	0.164032	0.150731	0.121096	0.078338	0.027091	-0.027091	-0.078338	-0.121096	-0.150731	-0.164032	-0.159558	-0.137793	-0.101096	-0.053444	-0.000000	;
0.000000	0.154540	0.292333	0.398447	0.461384	0.474322	0.435860	0.350166	0.226526	0.078338	-0.078338	-0.226526	-0.350166	-0.435860	-0.474322	-0.461384	-0.398447	-0.292333	-0.154540	-0.000000	;
0.000000	0.238889	0.451891	0.615923	0.713211	0.733211	0.673756	0.541290	0.350166	0.121096	-0.121096	-0.350166	-0.541290	-0.673756	-0.733211	-0.713211	-0.615923	-0.451891	-0.238889	-0.000000	;
0.000000	0.297351	0.562480	0.766655	0.887751	0.912645	0.838641	0.673756	0.435860	0.150731	-0.150731	-0.435860	-0.673756	-0.838641	-0.912645	-0.887751	-0.766655	-0.562480	-0.297351	-0.000000	;
0.000000	0.323590	0.612115	0.834307	0.966089	0.993181	0.912645	0.733211	0.474322	0.164032	-0.164032	-0.474322	-0.733211	-0.912645	-0.993181	-0.966089	-0.834307	-0.612115	-0.323590	-0.000000	;
0.000000	0.314764	0.595418	0.811549	0.939737	0.966089	0.887751	0.713211	0.461384	0.159558	-0.159558	-0.461384	-0.713211	-0.887751	-0.966089	-0.939737	-0.811549	-0.595418	-0.314764	-0.000000	;
0.000000	0.271828	0.514198	0.700848	0.811549	0.834307	0.766655	0.615923	0.398447	0.137793	-0.137793	-0.398447	-0.615923	-0.766655	-0.834307	-0.811549	-0.700848	-0.514198	-0.271828	-0.000000	;
0.000000	0.199435	0.377257	0.514198	0.595418	0.612115	0.562480	0.451891	0.292333	0.101096	-0.101096	-0.292333	-0.451891	-0.562480	-0.612115	-0.595418	-0.514198	-0.377257	-0.199435	-0.000000	;
0.000000	0.105430	0.199435	0.271828	0.314764	0.323590	0.297351	0.238889	0.154540	0.053444	-0.053444	-0.154540	-0.238889	-0.297351	-0.323590	-0.314764	-0.271828	-0.199435	-0.105430	-0.000000	;
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	-0.000000	;];
%% Plotting u matrix

x1 = linspace(-1, 1, 20);
x2 = linspace(-1, 1, 20);
[X1,X2]=meshgrid(x1,x2);
surf(X2, X1, u);
saveas(gcf, 'jacU.eps'); 
xlabel('y')
ylabel('x')
zlabel('u')

%% Plottting difference matrix
imagesc(dif)
xlabel('N')
ylabel('N')


%% Plottting f matrix

x1 = linspace(-1, 1, 20);
x2 = linspace(-1, 1, 20);
[X1,X2]=meshgrid(x1,x2);
surf(X2, X1, f);
saveas(gcf, 'jacf.eps'); 
xlabel('y')
ylabel('x')
zlabel('f')

%% Plottting s matrix

x1 = linspace(-1, 1, 20);
x2 = linspace(-1, 1, 20);
[X1,X2]=meshgrid(x1,x2);
surf(X2, X1, s);
saveas(gcf, 'jacS.eps'); 
xlabel('y')
ylabel('x')
zlabel('s')