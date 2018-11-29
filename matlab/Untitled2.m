angle = pi/4;
reference_line = [0 1 2 3 4 5 6];
data_x = [0 1 2 3 4 5 6];
data_y = [0 1.1 2.2 3.3 4.4 5.5 6.6];
% 2D rotation
x2 = data_x*cos(angle)-data_y*sin(angle);
y2 = data_y*cos(angle)+data_x*sin(angle);
figure;
hold on;
p1=plot(reference_line,reference_line,'marker','none','linestyle','--');
p2=plot(data_x,data_y,'-r');
p3=plot(x2,y2,'-b');
p4=plot(zeros(1,7),reference_line,'-k');
set(gca,'ylim',[0 6],'xlim',[-6 6]);
axis square;
legend([p1,p2,p3,p4],{'Reference line','Original data','Rotated data','Vertical line'},'Location','southwest');