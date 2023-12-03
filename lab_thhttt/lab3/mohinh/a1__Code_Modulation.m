clc; clear; close all;

ts = 1/20000; % Th?i gian l?y m?u
t = 0:ts:0.2; 

% ============== Thông tin ==========
Vm = 1; fm = 500; 
mt = Vm*sin(2*pi*fm*t);

% ============== Sóng mang ==========
Vc = 5; fc = 3000; omegac = 2*pi*fc;
xct = Vc*sin(2*pi*fc*t);

% ============== ?? nh?y t?n s? =====
kf = 2000; 

% ============== ?I?U CH? FM ========
yFM = zeros(1,length(t));
for i = 1:length(t)
    
    to = 0:ts:t(i);
    mtt = sin(2*pi*fm*to);
    TP = sum(mtt*ts);
    yFM(i) = Vc*cos(omegac*t(i) + 2*pi*kf*Vm*TP);
    
end

figure(1)
subplot(3,1,1)
plot(t,mt,'b-','linewidth',1.6); hold on;
legend('m(t)');
xlabel('t'); ylabel('V');
axis([0.1 0.11 -1.2 1.2])

subplot(3,1,2)
plot(t,xct,'g-','linewidth',1.6); hold on;
legend('x_c(t)');
xlabel('t'); ylabel('V');
axis([0.1 0.11 -5.2 5.2])

subplot(3,1,3)
plot(t,yFM,'r-','linewidth',1.6); hold on;
legend('y_{FM}(t)');
xlabel('t'); ylabel('V');
axis([0.1 0.11 -5.2 5.2])


