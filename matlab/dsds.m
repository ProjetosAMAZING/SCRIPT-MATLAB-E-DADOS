clear
clc
close all

fileID = fopen('rtknewbase_07.txt','w')

s = serial('COM21', 'BaudRate',115200)
fopen(s)
x = [-8.660003548441999 -8.660310006172601 -8.660006921743527  -8.659699462693688 -8.660003548441999]
y =[40.63393433444123 40.63417251358401 40.63440021714994  40.63417238627883 40.63393433444123]
%plot(x,y);
hold on
long =zeros
while(1)
    out=fscanf(s);
    C = strsplit(out,',');
    A = cell2mat(C)
    
  carstate = str2num(A(1))
  HardV = str2num(A(2:4))
  Sentido = str2num(A(5))
  Lg = A(6:13)
  Lat = A(14:21)
  Hora = str2num(A(22:23))
  Minuto = str2num(A(24:25))
  Segundo = str2num(A(26:27))
  gpsV = str2num(A(28:30))
  gpsS = str2num(A(31))
  gpsQ = str2num(A(32:34))
  
  Lat =str2num(Lat)/100000000;
  Lat = Lat+40;
  
  Lg = str2num(Lg)/100000000;
  Lg = Lg*(-1) - 8;
  
   fprintf(fileID,'%i,%i,%i,%2.8f,%1.8f,%i,%i,%i,%i,%i,%i\n',Hora,Segundo,Minuto,Lat,Lg,gpsS,gpsQ,gpsV,HardV,carstate,Sentido);
   plot(Lat,Lg,'*');
   hold on;
  
   
 %%  if(Long ~= 0) && (Lat ~= 0)
       
   %%         if(st == 2)    
     %%           plot(Long,Lat,'r*')
       %%     elseif (st == 1)
         %%       plot(Long,Lat,'b*')
           %% elseif (st == 5)
             %% plot(Long,Lat,'g+')
               %% elseif (st==4)
            %%            plot(Long,Lat,'r+')
                   
           %% end  
                    
                   
   drawnow
   %%end
  
    
   
    
    
    %hold on;
end