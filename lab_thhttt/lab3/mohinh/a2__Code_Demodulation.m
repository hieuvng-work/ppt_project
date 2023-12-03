clc; clear; close all;

ts = 1/20000; % Th?i gian l?y m?u
fs = 1/ts;
t = 0:ts:0.2; 

% ============== Thông tin ==========
Vm = 1; fm = 500; 
mt = Vm*sin(2*pi*fm*t);

% ============== Sóng mang ==========
Vc = 5; fc = 3000; omegac = 2*pi*fc;
xct = Vc*sin(2*pi*fc*t);

% ============== ?? nh?y t?n s? =====
kf = 2000; 

% ============== ?i?u ch? FM ========
yFM = zeros(1,length(t));
for i = 1:length(t)
    
    to = 0:ts:t(i);
    mtt = sin(2*pi*fm*to);
    TP = sum(mtt*ts);
    yFM(i) = Vc*cos(omegac*t(i) + 2*pi*kf*Vm*TP);
    
end
yFM;

% =============== Demodulation FM =======================
yFM_dh = diff(yFM);  % ??o hàm

yFM_bp = yFM_dh.^2;  % Bình ph??ng

fc = 750; % T?n s? c?t c?a l?c
[b,a] = butter(12,fc/(fs/2));

mDem = filter(b,a,yFM_bp);  % L?c t?n s? cao
mDem = (mDem - 11.5)/11.5;  % C?n ch?nh biên ??

% ================== Do thi ==================
startp = 50;
endp = 300;

figure(1)
subplot(4,1,1)
plot(t(startp:endp),mt(startp:endp),'b-','linewidth',1.6); hold on;
legend('m(t)');
xlabel('t'); ylabel('V');

subplot(4,1,2)
plot(t(startp:endp),xct(startp:endp),'g-','linewidth',1.6); hold on;
legend('x_c(t)');
xlabel('t'); ylabel('V');

subplot(4,1,3)
plot(t(startp:endp),yFM(startp:endp),'r-','linewidth',1.6); hold on;
legend('y_{FM}(t)');
xlabel('t'); ylabel('V');

subplot(4,1,4)
plot(t(startp:endp),mDem(startp:endp),'c-','linewidth',1.6); hold on;
legend('m_{de}(t)');
xlabel('t'); ylabel('V');

