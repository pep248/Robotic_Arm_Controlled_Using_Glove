startup_rvc

theta1=(90)*pi/180; %home a 90º, >90º anti-horari, <90º horari (0÷180)
theta2=(-40)*pi/180; %home a 0º, >0º amunt, <90º aball (0÷-180)
theta3=(+40)*pi/180; %home a 0º, >0º amunt, <90º aball (0÷180)
%theta4 es calcula sola a partir de theta2 i theta3
theta5=0;%(0÷270)

L1=310;
L2=80;
a2=240;
a3=300;
L5=240;

%introduïm les matrius jacobianes

l(1)=Link([0,L1,0,pi/2,0]);
l(2)=Link([0,L2,a2,0,0]);
l(3)=Link([0,0,a3,0,0]);
l(4)=Link([0,0,0,-pi/2,0]);
l(5)=Link([0,L5,0,0,0]);
R=SerialLink(l);

%deduïm, a partir de les thetes, la posició X, Y i Z de l apunta del
%actuador

X=+L2*sin(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+a3*cos(theta3)*cos(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-a3*sin(theta3)*cos(theta1)*sin(theta2)+a2*cos(theta1)*cos(theta2);
Y=-L2*cos(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+a3*cos(theta3)*sin(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-a3*sin(theta3)*sin(theta1)*sin(theta2)+a2*sin(theta1)*cos(theta2);
Z=L5*cos(theta2)*cos(theta3)*cos(-theta2-theta3-pi/2)-L5*cos(theta2)*sin(-theta2-theta3-pi/2)*sin(theta3)+a3*cos(theta2)*sin(theta3)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta2)+a3*cos(theta3)*sin(theta2)-L5*cos(-theta2-theta3-pi/2)*sin(theta2)*sin(theta3)+a2*sin(theta2)+L1;

teta1=theta1*180/pi;
teta2=theta2*180/pi;
teta3=theta3*180/pi;

if(X>350)
    
    X=350;
    
    syms theta1 theta2 theta3
    eqn1 = X==+L2*sin(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+a3*cos(theta3)*cos(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-a3*sin(theta3)*cos(theta1)*sin(theta2)+a2*cos(theta1)*cos(theta2);
    eqn2 = Y==-L2*cos(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+a3*cos(theta3)*sin(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-a3*sin(theta3)*sin(theta1)*sin(theta2)+a2*sin(theta1)*cos(theta2);
    eqn3 = Z==L5*cos(theta2)*cos(theta3)*cos(-theta2-theta3-pi/2)-L5*cos(theta2)*sin(-theta2-theta3-pi/2)*sin(theta3)+a3*cos(theta2)*sin(theta3)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta2)+a3*cos(theta3)*sin(theta2)-L5*cos(-theta2-theta3-pi/2)*sin(theta2)*sin(theta3)+a2*sin(theta2)+L1;
    sol = solve([eqn1, eqn2, eqn3], [theta1, theta2, theta3]);
    theta1 = (double(sol.theta1))*180/pi;
    theta2 = (double(sol.theta2))*180/pi;
    theta3 = (double(sol.theta3))*180/pi;
    
    teta1=atan(Y/350)+asin(80/sqrt(350^2+Y^2));
    teta1=teta1*180/pi;
    
    Axy=sqrt(350^2+Y^2-L2^2);
    Az=Z-310;
    
    teta2 = atan(((-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)/(Axy^2+Az^2-480*Axy+57600))/((Axy^2+Az^2+(-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)*Az/(Axy^2+Az^2-480*Axy+57600)-480*Axy+25200)/(Axy-240)));
%     teta2=teta2*180/pi;
    if(teta2<0)
        teta2=-teta2*180/pi-180;
        
    else
        teta2=-teta2*180/pi;
        
    end
    
    
    teta3=atan(((1/480)*(480*Axy^2+480*Az^2-230400*Axy+27648000)*(-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)/((144000*Axy-34560000)*(Axy^2+Az^2-480*Axy+57600))+(Axy^2*Az+Az^3-480*Axy*Az+25200*Az)/(144000*Axy-34560000))/((1/144000)*Axy^2+(1/144000)*Az^2-(1/300)*Axy-5/8));
    
    if(teta3<0)
        teta3=teta3*180/pi+180;
        
    else
        teta3=teta3*180/pi;
        
    end
    
elseif(X<-350)
    X=-350;
    
    syms theta1 theta2 theta3
    eqn1 = X==+L2*sin(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+a3*cos(theta3)*cos(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*cos(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*cos(theta1)*sin(theta2)-a3*sin(theta3)*cos(theta1)*sin(theta2)+a2*cos(theta1)*cos(theta2);
    eqn2 = Y==-L2*cos(theta1)-L5*cos(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+a3*cos(theta3)*sin(theta1)*cos(theta2)-L5*sin(theta3)*cos(-theta2-theta3-pi/2)*sin(theta1)*cos(theta2)+L5*sin(theta3)*sin(-theta2-theta3-pi/2)*sin(theta1)*sin(theta2)-a3*sin(theta3)*sin(theta1)*sin(theta2)+a2*sin(theta1)*cos(theta2);
    eqn3 = Z==L5*cos(theta2)*cos(theta3)*cos(-theta2-theta3-pi/2)-L5*cos(theta2)*sin(-theta2-theta3-pi/2)*sin(theta3)+a3*cos(theta2)*sin(theta3)-L5*cos(theta3)*sin(-theta2-theta3-pi/2)*sin(theta2)+a3*cos(theta3)*sin(theta2)-L5*cos(-theta2-theta3-pi/2)*sin(theta2)*sin(theta3)+a2*sin(theta2)+L1;
    sol = solve([eqn1, eqn2, eqn3], [theta1, theta2, theta3]);
    theta1 = (double(sol.theta1))*180/pi;
    theta2 = (double(sol.theta2))*180/pi;
    theta3 = (double(sol.theta3))*180/pi;
    
    teta1=atan(350/Y)+asin(80/(sqrt(Y^2+350^2)));
    teta1=teta1*180/pi+90;
    
    Axy=sqrt(350^2+Y^2-L2^2);
    Az=Z-310;
    
    teta2 = atan(((-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)/(Axy^2+Az^2-480*Axy+57600))/((Axy^2+Az^2+(-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)*Az/(Axy^2+Az^2-480*Axy+57600)-480*Axy+25200)/(Axy-240)));

    if(teta2<0)
        teta2=-teta2*180/pi-180;
        
    else
        teta2=-teta2*180/pi;
        
    end
    
    
    teta3=atan(((1/480)*(480*Axy^2+480*Az^2-230400*Axy+27648000)*(-Axy^2*Az-Az^3+480*Axy*Az+sqrt(-Axy^6-2*Axy^4*Az^2-Axy^2*Az^4+1440*Axy^5+1920*Axy^3*Az^2+480*Axy*Az^4-568800*Axy^4-396000*Axy^2*Az^2-57600*Az^4-6912000*Axy^3-31104000*Axy*Az^2+51204960000*Axy^2+10368000000*Az^2-11041920000000*Axy+727833600000000)-25200*Az)/((144000*Axy-34560000)*(Axy^2+Az^2-480*Axy+57600))+(Axy^2*Az+Az^3-480*Axy*Az+25200*Az)/(144000*Axy-34560000))/((1/144000)*Axy^2+(1/144000)*Az^2-(1/300)*Axy-5/8));
    
    if(teta3<0)
        teta3=teta3*180/pi+180;
        
    else
        teta3=teta3*180/pi;
        
    end
    
else
    
    theta1=theta1*180/pi;
    theta2=theta2*180/pi;
    theta3=theta3*180/pi;
    
end

teta1=teta1/180*pi;
teta2=teta2/180*pi;
teta3=teta3/180*pi;

X_=+L2*sin(teta1)-L5*cos(teta3)*cos(-teta2-teta3-pi/2)*cos(teta1)*sin(teta2)-L5*cos(teta3)*sin(-teta2-teta3-pi/2)*cos(teta1)*cos(teta2)+a3*cos(teta3)*cos(teta1)*cos(teta2)-L5*sin(teta3)*cos(-teta2-teta3-pi/2)*cos(teta1)*cos(teta2)+L5*sin(teta3)*sin(-teta2-teta3-pi/2)*cos(teta1)*sin(teta2)-a3*sin(teta3)*cos(teta1)*sin(teta2)+a2*cos(teta1)*cos(teta2);
Y_=-L2*cos(teta1)-L5*cos(teta3)*cos(-teta2-teta3-pi/2)*sin(teta1)*sin(teta2)-L5*cos(teta3)*sin(-teta2-teta3-pi/2)*sin(teta1)*cos(teta2)+a3*cos(teta3)*sin(teta1)*cos(teta2)-L5*sin(teta3)*cos(-teta2-teta3-pi/2)*sin(teta1)*cos(teta2)+L5*sin(teta3)*sin(-teta2-teta3-pi/2)*sin(teta1)*sin(teta2)-a3*sin(teta3)*sin(teta1)*sin(teta2)+a2*sin(teta1)*cos(teta2);
Z_=L5*cos(teta2)*cos(teta3)*cos(-teta2-teta3-pi/2)-L5*cos(teta2)*sin(-teta2-teta3-pi/2)*sin(teta3)+a3*cos(teta2)*sin(teta3)-L5*cos(teta3)*sin(-teta2-teta3-pi/2)*sin(teta2)+a3*cos(teta3)*sin(teta2)-L5*cos(-teta2-teta3-pi/2)*sin(teta2)*sin(teta3)+a2*sin(teta2)+L1;

teta1=teta1/pi*180;
teta2=teta2/pi*180;
teta3=teta3/pi*180;

zlim manual
xlim([-1000 1000])
ylim([-1000 1000])
zlim([0 1000])

% pos0=[90*pi/180 0 0 -90*pi/180 0];
% pos1=[180*pi/180 0 0 -90*pi/180 0];
% pos2=[270*pi/180 0 0 -90*pi/180 0];
% pos3=[360*pi/180 0 0 -90*pi/180 0];
% pos4=[450*pi/180 0 0 -90*pi/180 0];
% pos5=[-90*pi/180 0 0 -90*pi/180 0]
% pos6=[-90*pi/180 0 0 -90*pi/180 0]

t=0:0.1:1;%Time vector & steps

pos0=[90*pi/180 0 0 -90*pi/180 0];
pos1=[teta1*pi/180 teta2*pi/180 teta3*pi/180 (-teta2-teta3-90)*pi/180 0];
traj1=jtraj(pos0, pos1, t);
% traj2=jtraj(pos1,pos2,t,QD0,QDF);
R.plot(traj1,'trail',{'r','LineWidth',2},'zoom',3)

%
%     if(i==10)
%         pos0=[90*pi/180 0 0 -90*pi/180 0];
%         pos1=[teta1*pi/180 teta2*pi/180 teta3*pi/180 (-teta2-teta3-90)*pi/180 0];
%         traj1=jtraj(pos0, pos1, t);
%         % traj2=jtraj(pos1,pos2,t,QD0,QDF);
%         R.plot(traj1,'trail',{'r','LineWidth',2},'zoom',3)
%
%     else
%         pos0=pos1;
%         pos1=[teta1*pi/180 teta2*pi/180 teta3*pi/180 (-teta2-teta3-90)*pi/180 0];
%         traj1=jtraj(pos0, pos1, t);
%         R.animate(traj1)
%
%     end


%end

% for i = 0:n:90
%     pos0=[(i+90)*pi/180 0 0 -90*pi/180 0];
%     pos1=[(i+10+90)*pi/180 0 0 -90*pi/180 0];
%     traj2=jtraj(pos0, pos1, t,QD0,QDF);
%     R.animate(traj2)
% end


% traj1=jtraj(pos0,pos1,t);
% traj2=jtraj(pos1,pos2,t);
% traj3=jtraj(pos2,pos3,t);
% traj4=jtraj(pos3,pos4,t);

% R.plot(traj1,'trail',{'r','LineWidth',2},'zoom',3) %l'R.plot podem definir els paràmetres del ploting.
%R.animate(traj2)%l'R.animate agafa els aprametres de l'R.plot anterior i ho dibuixa a la mateixa finestra. Si utilitzessim R.plot un altre cop, esborraria els traços anteriors.
% R.animate(traj3)
% R.animate(traj4)

%pos2=[pi/2 0 -90*pi/180 45*pi/180+pi/2 0]
%traj2=jtraj(pos1,pos2,t);

%R.plot(traj2,'trail',{'r', 'LineWidth', 2},'zoom', 2)
