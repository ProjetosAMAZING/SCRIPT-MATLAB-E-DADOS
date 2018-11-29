clc;

clear all
close all


R=6371


% 
% x = [-8.660003548441999 -8.660310006172601 -8.660006921743527  -8.659699462693688 -8.660003548441999]
% y =[40.63393433444123 40.63417251358401 40.63440021714994  40.63417238627883 40.63393433444123]
% 
% plot(y,x);
% hold on
% 
% x2 = [40.633938 40.634176 40.634408 40.634172 40.633938]
% y2 = [-8.660007 -8.659692 -8.660006 -8.660320 -8.660007]
% plot(x2,y2,'r')
% hold on 

x3 = [40.633923 40.634159 40.6343895 40.634167 40.633923]
y3 = [-8.659995 -8.659692 -8.659995 -8.660284 -8.659995]
plot(x3,y3,'g')

hold on
plot(x3(1),y3(1),'*')


data = textread('rtkfix.txt','','delimiter',',');
z = data(:,4).*0;
plot3(data(1,4),data(1,5),z(),'r*')
az = 0;%.43.9
el = 90;
view(az, el);

lat1 = data(1,4);
lg1 = data(1,5);
dd = []
ii = []
figure()
for i = 2:length(data(:,4))
    
    subplot(3,1,1);
    plot3(data(1:i,4),data(1:i,5),z(1:i),'b*')
     latmean = mean(data(1:i,4));
    longmean = mean(data(1:i,5));
    
    plot(latmean,longmean,'r*');
    hold on
      plot(data(1:i,4),data(1:i,5),'b*')
    drawnow
    subplot(3,1,2);
   
    dd = [dd dist(latmean,data(i,4),longmean,data(i,5))];
    ii = [ii i ];
    plot(ii,dd,'*')
    drawnow
    subplot(3,1,3);
    plot(ii,data(2:i,8),'g')
    hold on 
    plot(ii,data(2:i,9),'r')
    drawnow
    lat1 = data(i,4)
    lat2 = data(i,5)
 
    
    
 end
figure()
plot(data(:,4),data(:,5),'g+')
hold on;
meanlat = mean(data(:,4));
meanlong = mean(data(:,5));


mu = [0 0];
Sigma = [.25 .3; .3 1];

[X1,X2] = meshgrid(data(:,4),data(:,5));
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = reshape(F,length(data(:,4)),length(data(:,4)));
surf(data(:,4),data(:,5),F);

xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

%angle = -44.1

%figure()
%plot(data(:,4).*cos(45),data(:,5).*sin(45),'b*')

%x2 = data(:,4).*cosd(angle)-data(:,5).*sind(angle);
%y2 = data(:,5).*cosd(angle)+data(:,4).*sind(angle);

%hold on

%plot3(x2,y2,z,'r*');


