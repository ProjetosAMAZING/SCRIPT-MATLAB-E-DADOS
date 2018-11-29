close all
clc
clear all

N=6;

data = textread('v15.txt','','delimiter',',');
%data = textread('circuitnortk.txt','','delimiter',',');
pontlat = 40.66;
pontlong=-8.63415   


alg=[-8.660000871904897 -8.660300966032665 -8.659994564039398 -8.659689714064383 -8.660000871904897];
alat = [40.63438801844669 40.63416100607418 40.63392273711636 40.63415857249284 40.63438801844669];
figure()
plot(alat,alg);

figure()
plot(data(:,4),data(:,5))
hold on
plot(alat,alg);
figure()
plot(data(:,5),data(:,4));

mlat = (max(data(:,4)) + min(data(:,4)))/2;
mlg  = (max(data(:,5)) + min(data(:,5)))/2;

hold on 
figure()



nlat = data(:,4)-mlat;
nlg = data(:,5)-mlg;

[theta,rho] = cart2pol(nlg,nlat);
theta = theta - pi/2;
polarplot(theta,rho);

figure()
distance = [];

for i=1:length(theta)
    distance = [distance dist(mlat,mlat+nlat(i),mlg,mlg+nlg(i))];
end

polarplot(theta,distance)

figure()
plot(radtodeg(theta),distance)

graus = radtodeg(theta);
nth=[]
nro=[]
r = 0;
for k = 0:0.5:175.5
   x = find(graus>= k & graus < 0.5)
   if(length(x)>0)
       r = sum(rho(x))
   end
end

[xData, yData] = prepareCurveData( theta, rho );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.99550723913842791;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );


figure()
polarplot(theta+0.83,fitresult(theta))
figure()
polarplot(theta+0.90,fitresult(theta))


[x,y]=pol2cart(theta+degtorad(0),fitresult(theta));

figure()
plot(x,y);
hold on
plot(nlat,nlg)


plot(x+mlat,y+mlg)
hold on
plot(mlat,mlg,'*');
%hold on
%plot(alat,alg);
%hold on
%plot(data(:,4),data(:,5),'+');
figure()
plot(x.*(3.276897869998653e+06),y.*(2.476882430661434e+06))


scal = 1/max(y);
hold on
plot((alat-mlat).*(3.276897869998653e+06),(alg-mlg).*(2.476882430661434e+06))

figure()
polarplot(degtorad(graus),fitresult(degtorad(graus)))
hold on
polarplot(theta,rho);

figure()
plot(x.*scal,y.*scal);



figure()

plot(data(:,4),data(:,5),'.')
hold on
plot(mlat,mlg,'*');
title('Circuito');
xlabel('Latitude');
ylabel('Longitude');
legend('Pontos do veículo','Ponto Central');
figure()
polarplot(theta,rho,'*');
title('Diferença entre os pontos do veículo e ponto central');
figure()
subplot(2,1,1);
plot(fitresult, xData, yData );
subplot(2,1,2)
polarplot(theta,rho,'+r');
hold on
polarplot(degtorad(graus),fitresult(degtorad(graus)),'linewidth',3)
title('Circuito Spline');
legend('Diferença entre os pontos do veículo e ponto central','Função spline');
figure()
polarplot(degtorad(graus),fitresult(degtorad(graus)).*(scal*700),'linewidth',3)
title('Circuito para o script Js');


