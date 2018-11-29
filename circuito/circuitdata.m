close all
clc
clear all

N=6;
alg = [-8.659994215590098 -8.660081952393531 -8.660081952393531 -8.659994215590098];
alat = [40.6340575338096 40.63419519288379 40.63419519288379 40.6340575338096];
data = textread('vel10_01.txt','','delimiter',',');
data2 = textread('vel10.txt','','delimiter',',');
data3 = textread('ccrtkbasegooglefix7.txt','','delimiter',',');
data4 = textread('CCtofix40.txt','','delimiter',',');

%data = textread('circuitnortk.txt','','delimiter',',');
pontlat = 40.66;
pontlong=-8.63415

dd = []
%for i = 50:length(data(:,4))
 %   subplot(3,1,1);
  %  plot(pontlat,pontlong,'+')
   % hold on
    %plot(data(1:i,4)-40,data(1:i,5)+8,'*');
    
    %hold on
    %subplot(3,1,2)
    %plot(data(1:i,8))
    %hold on
    %subplot(3,1,3)
    %dd = [dd dist(pontlat,data(i,4),pontlong,data(i,5))]
    %plot(dd);
    
    %drawnow
%end
figure()
plot(data(:,4),data(:,5))

mm = min(data(:,4))
m = max(data(:,4))

mmg = min(data(:,5))
mg = max(data(:,5))

mlat = (mm + m)/2
mg = (mg + mmg)/2

hold on
plot(mlat,mg,'+')

figure()
plot(data(:,4)-mlat,data(:,5)-mg)

centerlat = data(:,4)-mlat;
centerlg = data(:,5)-mg;

centerlat2 = data2(:,4)-mlat;
centerlg2 = data2(:,5)-mg;

centerlat3 = data3(:,4)-mlat;
centerlg3 = data3(:,5)-mg;

centerlat4 = data4(:,4)-mlat;
centerlg4 = data4(:,5)-mg;

[theta2,rho2] = cart2pol(centerlat2,centerlg2)
[theta,rho] = cart2pol(centerlat,centerlg)
[theta3,rho3] = cart2pol(centerlat3,centerlg3)
[theta4,rho4] = cart2pol(centerlat4,centerlg4)
figure()
plot(theta)
figure()
plot(rho)
figure()
polarplot(theta,rho,'+')



cl2 = data2(:,4)-mean(data(:,4))


di =[]
for k = 1:length(data(:,4))
    di = [di dist(data(k,4),mlat,data(k,5),mg)];
end
 distance=[];
for j = 1:length(data(:,4))
distance=[distance dist(mlat,mlat+centerlat(j),mg,mg+centerlg(j))];
end
distance2 = [];
for j = 1:length(data2(:,4))
distance2=[distance2 dist(mlat,mlat+centerlat2(j),mg,mg+centerlg2(j))];
end


distance4 = [];
for j = 1:length(data4(:,4))
distance4=[distance4 dist(mlat,mlat+centerlat4(j),mg,mg+centerlg4(j))];
end

distance3 = [];
for j = 1:length(data3(:,4))
distance3=[distance3 dist(mlat,mlat+centerlat3(j),mg,mg+centerlg3(j))];
end



figure()
plot(centerlat,centerlg)
figure()
plot(rho)
figure()
plot(di)
figure()
polarplot(theta,distance,'.-')

figure()
polarplot(theta+0.7505,distance,'*')

xi = 0:0.1:2*pi


figure()
plot(distance)

f = fft(distance);

[x,y] = pol2cart(theta+0.88,rho)
figure()
plot3(x,y,x.*0)


graus = 1:1:179;
med =[]
sum = 0;
dg = radtodeg(theta)
for i=1:length(graus)
   X=find(dg>i-1 & dg<i+1)
   for j =1:length(X)
       sum = sum + distance(X(j));
   end
   
   med = [med sum/length(X)]
   sum = 0
end

figure()
polarplot(degtorad(graus),med,'*')

nt = []
nr = []

subplot(3,1,1)
plot(data(:,6))
subplot(3,1,2)
plot(data(:,8))
subplot(3,1,3)
plot(data(:,9))


vel = (data4(:,9)./100).*(5*6.212765957446808);
figure()
plot(data(:,8));
hold on 
plot(vel);


time = []

for l = 1:length(data(:,1))
    timeh = data(l,1) - data(1,1); 
    timem = data(l,2) - data(1,2);
    times = data(l,3) - data(1,3);

   time =[time (timeh*60 + timem + times/60)];
end

figure()
subplot(3,1,1)
plot(data(:,5),data(:,4))
title('Coordenadas do veículo')
ylabel('Latitude');
xlabel('Longitude');

%hold on 
%plot(data2(:,5),data2(:,4))
%hold on
%plot(data3(:,5),data3(:,4))
%hold on
%plot(data4(:,5),data4(:,4))
subplot(3,1,2)
plot(time,data(:,6))
title('Estado do sistema GPS-RTK ao longo do tempo');
xlabel('Tempo(minutos)')
ylabel('Estado');
subplot(3,1,3)
plot(time,data(:,9))
hold on
plot(time,data(:,8))

title('Velocidade do veículo ao longo do tempo');
xlabel('Tempo(minutos)');
ylabel('Velocidade (km/h)');
legend('Velocidade - Passa Baixo', 'Velocidade GPS-RTK');


figure()
subplot(2,1,1)
plot(data(:,5),data(:,4),'*r')
hold on
plot(data2(:,5),data2(:,4),'*b')
title('Cicuito RTK e FRTK')
legend('RTK','FRTK')
xlabel('Longitude')
ylabel('Latitude');

subplot(2,1,2)


polarplot(theta,distance,'.r')
hold on
polarplot(theta2,distance2,'.b')
title('Distância entre o veículo e ponto central');
legend('RTK','FRTK')



figure()
subplot(2,1,1)
plot(data(:,5),data(:,4),'*g');
hold on
plot(data2(:,5),data2(:,4),'*y');
hold on 
plot(data3(:,5),data3(:,4),'*b');
hold on
plot(data4(:,5),data4(:,4),'*r');
title('Coordenadas do veículo das diferentes bases');
xlabel('Longitude')
ylabel('Latitude');
legend('Base actual','Base 1','Base 2','Base 3');

subplot(2,1,2)
polarplot(theta,distance,'.g')
hold on
polarplot(theta2,distance2,'.y')
hold on
polarplot(theta3,distance3,'.b')
hold on
polarplot(theta4,distance4,'.r')
legend('Base actual','Base 1','Base 2','Base 3');
title('Distância(m) entre o veículo e o ponto central');









