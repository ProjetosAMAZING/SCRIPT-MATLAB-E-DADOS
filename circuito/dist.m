function [ d ] = dist(lat1,lat2,lg1,lg2)

R = 6371;

lat1 = lat1*pi/180;
lat2 = lat2*pi/180;
lg1 = lg1*pi/180;
lg2 = lg2*pi/180;
dlon = lg2 - lg1 ;
dlat = lat2 - lat1 ;
a = (sin(dlat/2))^2 + cos(lat1) * cos(lat2) * (sin(dlon/2))^2 ;
c = 2 * atan2( sqrt(a), sqrt(1-a) ) ;
d = (R * c) *1000;

end