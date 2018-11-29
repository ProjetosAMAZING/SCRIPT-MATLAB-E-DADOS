close all
clc
clear all

N=6;

%data = textread('begin.txt','','delimiter',',');
data = textread('rtkbasegooglefix16.txt','','delimiter',',');




subplot(5,1,1)
plot(data(:,4),data(:,5),'*')
lat1m = mean(data(:,4));
long1m = mean(data(:,5));
hold on 
plot(lat1m,long1m,'+');
dd = [];
for i=1:length(data(:,4))
   dd =[dd dist(lat1m,data(i,4),long1m,data(i,5))];
end
subplot(5,1,2)
plot(dd);
subplot(5,1,3)
plot(data(:,6));
subplot(5,1,4);
ind = 0;
ind = find(data(:,6)==4,1,'first');

rtklat = data(ind:length(data(:,4)),4);
rtklong = data(ind:length(data(:,4)),5);
rtklatm = mean(rtklat);
rtklongm = mean(rtklong);
rtk = [];
for l = 1:length(data(:,4))
   if data(l,6) == 4
    rtk = [rtk l]
   end
end
rtklatm = mean(data(rtk,4));
rtklongm = mean(data(rtk,5));
plot(rtklat,rtklong,'*')
hold on
plot(rtklatm,rtklongm,'+')
ddrtk = []
for k = 1:length(rtklong)
    ddrtk=[ddrtk dist(rtklatm,rtklat(k),rtklongm,rtklong(k))];
end
subplot(5,1,5)
plot(ddrtk);

first= [ data(find(data(:,1)<24,1,'first'),1) data(find(data(:,1)<24,1,'first'),2) data(find(data(:,1)<24,1,'first'),3)]
rtkfirst = [data(ind,1) data(ind,2) data(ind,3)]

convergetime = rtkfirst-first
if(convergetime(1)>=1)
    time = convergetime(1)*60+convergetime(2)+convergetime(3)/60
else
    time = convergetime(2)+convergetime(3)/60
end

figure()
subplot(2,1,1)
plot(data(ind:length(data(:,4)),4),data(ind:length(data(:,4)),5),'*')
meanbrtklt = mean(data(ind:length(data(:,4)),4));
meanbrtklg = mean(data(ind:length(data(:,4)),5));
hold on
plot(meanbrtklt,meanbrtklg,'+');
meanbrtklt = rtklatm
meanbrtklg =rtklongm
ddr = []
for j = ind:length(data(:,4))
    ddr = [ddr dist(meanbrtklt,data(j,4),meanbrtklg,data(j,5))];
end
subplot(2,1,2)
plot(ddr);

 centerlat = data(:,4)-meanbrtklt;
 centerlg = data(:,5)-meanbrtklg;
 
 [theta,rho] = cart2pol(centerlat,centerlg)
 
 figure()
 
 polarplot(theta,rho,'*')

 distance = []
for j = ind:length(data(:,4))
    distance=[distance dist(meanbrtklt,meanbrtklt+centerlat(j),meanbrtklg,meanbrtklg+centerlg(j))];
end

figure()
polarplot(theta(ind:length(data(:,4))),distance,'*');
%indbasefix = find(data(:,1) == 15 & data(:,2) == 12,1,'first')
indbasefix = ind
figure()
subplot(2,1,1)
plot(data(indbasefix:length(data(:,4)),4),data(indbasefix:length(data(:,4)),5),'*')
meanbrtklt = mean(data(indbasefix:length(data(:,4)),4));
meanbrtklg = mean(data(indbasefix:length(data(:,4)),5));
hold on
plot(meanbrtklt,meanbrtklg,'+');

ddr = []
for j = indbasefix:length(data(:,4))
    ddr = [ddr dist(meanbrtklt,data(j,4),meanbrtklg,data(j,5))];
end
subplot(2,1,2)
plot(ddr);

mlat = meanbrtklt;
mg = meanbrtklg

figure()
plot(data(:,4)-mlat,data(:,5)-mg,'*')




centerlat = data(:,4)-rtklatm;
centerlg = data(:,5)-rtklongm;
[theta,rho] = cart2pol(centerlat,centerlg)
figure()
plot(theta)
figure()
plot(rho)
figure()
polarplot(theta,rho,'+')


di =[]
for k = 1:length(data(:,4))
    di = [di dist(data(k,4),mlat,data(k,5),mg)];
end
 distance=[];
for j = 1:length(data(:,4))
distance=[distance dist(mlat,mlat+centerlat(j),mg,mg+centerlg(j))];
end



figure()
plot(centerlat,centerlg)
figure()
plot(rho)
figure()
plot(di)
figure()


polarplot(theta,distance,'*')




rtk = [];
frtk = [];
dgps = [];
rest = [];

figure()
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
l = length(data(:,1));
time = []
for l = 1:length(data(:,1))
    timeh = data(l,1) - data(1,1); 
    timem = data(l,2) - data(1,2);
    times = data(l,3) - data(1,3);

   time =[time (timeh*60 + timem + times/60)];
end


subplot(2,2,4)

p = polarplot(theta(rtk),distance(rtk),'*r');

 ax = gca;
ax.RLim = [0 0.10];
 %ax.RTick = [0.001,0.002,0.005,0.010,0.20];
 
 title('Distância(m) entre o veículo e ponto central após convergir para o estado RTK');

subplot(2,2,3)
polarplot(theta(frtk),distance(frtk),'*g');
hold on
polarplot(theta(dgps),distance(dgps),'*y');
hold on
polarplot(theta(rest),distance(rest),'*b');
hold on
polarplot(theta(rtk),distance(rtk),'*r');

legend('FRTK','RTK');
 ax = gca;
 ax.RTick = [0.1 0.2 0.4 0.6 0.8 1 2 3 4 8 10 20];
  title('Distância(m) entre o veículo e ponto central');
subplot(2,2,1);

plot(data(frtk,5),data(frtk,4),'*g');

hold on
plot(data(dgps,5),data(dgps,4),'*y');

hold on
plot(data(rest,5),data(rest,4),'*b');

hold on
plot(data(rtk,5),data(rtk,4),'*r');

hold on
plot(mg,mlat,'+');

%legend('Float RTK','DGPS','Dados Inválidos','RTK');
legend('FRTK','RTK','Ponto Central');

xlabel('Longitude');
ylabel('Latitude');
title('Coordenadas do Veículo');
subplot(2,2,2)
plot(time,data(:,6))
xlabel('Tempo(Minutos)');
ylabel('Estado');
title('Estado do sistema GPS-RTK');



