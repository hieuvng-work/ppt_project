function y = tichphanhinhthang(fx,a,b,N)
    h = (b - a)/N;
    sum = 0;
    for i = 1:N-1
        sum = sum + 2*fx(a + i*h);
    end
    y = h/2*(fx(a) + fx(b) + sum);
end
