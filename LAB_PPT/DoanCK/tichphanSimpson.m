function y = tichphanSimpson(fx,a,b,N)
    h = (b - a)/N;
    sum = 0;
    for i = 1: N-1
        if mod(i,2)
            sum = sum + 4*fx(a + i*h);
        else
            sum = sum + 2*fx(a + i*h);
        end
    end
    y = h/3*(fx(a) + fx(b) + sum);
end
