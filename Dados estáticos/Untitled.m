close all
clc
clear
subplot(2,1,1)
c=[
  40.634265879999397 ,-8.660143157590529
40.634265879998949,  -8.660143531184946
40.634265880005643,-8.660142998874418
 40.634265880000207,  -8.660143786240017
40.634265879999703,-8.660143778319613
40.634265879999710, -8.660143840000002
 40.634265879999525,-8.660143832011142
40.634265621119461, -8.660143160681216
40.634265880000250, -8.660142582608669
 40.634265879998807, -8.660142879999713
  40.634265879999198,-8.660142880000226
40.634265880000235,-8.660142977627094
  40.634265880000072,  -8.660142888384250];



c1 =  [40.634271488646597,-8.660135158501355
        40.634264517689687, -8.660142624056398];


meanl = mean(c(:,1))
meang = mean(c(:,2))

plot(c(:,2),c(:,1),'*')
hold on 
plot(meang,meanl,'+')
title('Coordenadas estáticas do véiculo');
xlabel('Longitude');
ylabel('Latitude');
legend('Coordenadas do veículo','Ponto Central');



cmlt = c(:,1)-meanl;
cmlg = c(:,2)-meang;
d = []
for i = 1:length(c(:,1))
   d = [d dist(meanl,meanl+cmlt(i),meang,meang+cmlg(i))]
end

cmlt1 = c1(:,1)-meanl;
cmlg1 = c1(:,2)-meang;
d2 = []
for l = 1:length(c1(1,:))
      d2 = [d2 dist(meanl,meanl+cmlt1(l),meang,meang+cmlg1(l))]
end



[theta,rho] = cart2pol(cmlt,cmlg);
[theta1,rho] = cart2pol(cmlt1,cmlg1);

subplot(2,1,2)
polarplot(theta,d,'*')
title('Distância(m) entre as coordenadas estáticas e ponto central')






figure()

polarplot(theta1,d2,'*')