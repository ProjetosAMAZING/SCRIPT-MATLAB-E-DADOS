close all
clc
clear all

N=6;

data = textread('vel15.txt','','delimiter',',');
%data = textread('ve.txt','','delimiter',',');
pontlat = 40.66;
pontlong=-8.63415



figure()
plot(data(:,8));
hold on
plot(data(:,9));
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
polarplot(theta,distance,'.-')

figure()
polarplot(theta+0.7505,distance,'*')


figure()
subplot(3,2,1);
plot(data(:,4),data(:,5))
subplot(3,2,2)
plot(data(:,6));
subplot(3,2,[3 4])
plot(data(:,4),data(:,5));
subplot(3,2,[5 6])
plot(data(:,8))
hold on
plot(data(:,9))



