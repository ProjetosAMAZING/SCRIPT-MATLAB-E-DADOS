close all
clc
clear all

N=6;

%data = textread('rtknortk.txt','','delimiter',',');
data = textread('rtkbasegooglefix17nortk.txt','','delimiter',',');

rtk = [];
frtk = [];
dgps = [];
rest = []


for l = 1:length(data(:,4))
   if data(l,6) == 4
    rtk = [rtk l];
   end
   if data(l,6) == 5
    frtk = [frtk l];
   end
   if data(l,6) == 2
      dgps = [dgps l];
   end
   if data(l,6) < 2
     rest = [rest l];
   end
   
end



subplot(4,1,1)
plot(data(:,4),data(:,5),'*')
lat1m = mean(data(:,4));
long1m = mean(data(:,5));
hold on 
plot(lat1m,long1m,'+');
dd = [];
for i=1:length(data(:,4))
   dd =[dd dist(lat1m,data(i,4),long1m,data(i,5))];
end
subplot(4,1,2)
plot(dd);
subplot(4,1,3)
plot(data(:,6));



  ind = find(data(:,6)==5,1,'first');
  
 
 latmed = mean(data(frtk,4));
 longmed = mean(data(frtk,5));
 
 centerlat = data(:,4)-latmed;
 centerlg = data(:,5)-longmed;
 
 [theta,rho] = cart2pol(centerlat,centerlg)
 
 figure()
 
 polarplot(theta,rho,'*')
  
 distance = []
for j = 1:length(data(:,4))
    distance=[distance dist(latmed,latmed+centerlat(j),longmed,longmed+centerlg(j))];
end


time = []

for l = 1:length(data(:,1))
    timeh = data(l,1) - data(1,1); 
    timem = data(l,2) - data(1,2);
    times = data(l,3) - data(1,3);

   time =[time (timeh*60 + timem + times/60)];
end



figure()

rtk = [];
frtk = [];
dgps = [];
rest = []


for l = 1:length(data(:,4))
   if data(l,6) == 4
    rtk = [rtk l];
   end
   if data(l,6) == 5
    frtk = [frtk l];
   end
   if data(l,6) == 2
      dgps = [dgps l];
   end
   if data(l,6) < 2
     rest = [rest l];
   end
   
end

subplot(3,2,1)

label = num2str(frtk);
plot(data(frtk,5),data(frtk,4),'*g');

hold on
plot(data(dgps,5),data(dgps,4),'*y');

hold on
plot(data(rest,5),data(rest,4),'*b');


hold on
plot(data(rtk,5),data(rtk,4),'*r');

hold on 
plot(longmed,latmed,'+');
hold on



legend('Float RTK','DGPS','Ponto Central');
title('Coordenadas do veículo')
xlabel('Longitude')
ylabel('Latitude')

subplot(3,2,2)

plot(time, data(:,6));
title('Estado do sistema GPS-RTK');
xlabel('Tempo(Minutos)');
ylabel('Estado ');

subplot(3,2,[3 4])

plot(time,distance)
xlabel('Tempo(Minutos)');
ylabel('Distância(m)');
title('Distância entre o veículo e o ponto central ao longo do tempo');

subplot(3,2,5)

polarplot(theta(frtk),distance(frtk),'*g');

hold on
polarplot(theta(dgps),distance(dgps),'*y');

hold on
polarplot(theta(rest),distance(rest),'*b');


hold on
polarplot(theta(rtk),distance(rtk),'*r');

title('Distância entre veículo e o ponto central');

legend('Float RTK','DGPS');
subplot(3,2,6)

plot(time(300:length(data(:,4))),distance(300:length(data(:,4))))
title('Distância entre o veículo e o ponto central após o sistema GPS-RTK estabilizar');
xlabel('Tempo(Minutos)');
ylabel('Distância(m)');
figure()
plot3(time,data(:,5),data(:,4),'*')


