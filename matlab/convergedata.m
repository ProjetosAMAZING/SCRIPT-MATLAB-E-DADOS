close all
clc
clear all

N=6;

data = textread('rtknewbase.txt','','delimiter',',');
%data = textread('convergRTK2.txt','','delimiter',',');
%data = textread('convergRTK3.txt','','delimiter',',');
%data = textread('convergeRTK4.txt','','delimiter',',');
%data = textread('convergeRTK5.txt','','delimiter',',');
%data = textread('convergeRTK6.txt','','delimiter',',');



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
ind = find(data(:,6)==4,1,'first');
rtklat = data(ind:length(data(:,4)),4);
rtklong = data(ind:length(data(:,4)),5);
rtklatm = mean(rtklat);
rtklongm = mean(rtklong);
plot(rtklat,rtklong,'*')
hold on
plot(rtklatm,rtklongm,'+')
ddrtk = []
for k = 1:length(rtklong)
    ddrtk=[ddrtk dist(rtklatm,rtklat(k),rtklongm,rtklong(k))];
end
subplot(5,1,5)
plot(ddrtk);

first= [ data(2,1) data(2,2) data(2,3)]
rtkfirst = [data(ind,1) data(ind,2) data(ind,3)]

convergetime = rtkfirst-first
if(convergetime(1)>=1)
    time = convergetime(1)*60+convergetime(2)+convergetime(3)/60
else
    time = convergetime(2)+convergetime(3)/60
end