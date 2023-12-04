function [nghiem,solanlap] = tieptuyen(f,a,b,saiso)
         syms x;
         fd1 = str2func(['@(x)' char(diff(f(x)))]);
         fd2 = str2func(['@(x)' char(diff(fd1(x)))]);
         nostop = 1;
         temp1 = double(solve(diff(f(x))));
         temp2 = double(solve(diff(fd1(x))));
         %Kiem tra f'(x) co doi dau trong khoang phan li nghiem hay khong
         if ~isempty(temp1)
             for i=1:length(temp1)
                 if (temp1(i)<=b) && (temp1(i)>=a)
                     nostop=0;
                     nghiem = 0;
                     solanlap = 0;
                     break;
                 end
             end
         end
         %Kiem tra f"(x) co doi dau trong khoang phan li nghiem hay ko
         if ~isempty(temp2)
             for i=1:length(temp2)
                 if (temp2(i)<=b) && (temp2(i)>=a)
                     nostop=0;
                     nghiem = 0;
                     solanlap = 0;
                     break;
                 end
             end
         end
         if (nostop)
             solanlap= 0;
             syms x;
             f_dh1 = str2func(['@(x)' char(diff(f(x)))]);
             f_dh2 = str2func(['@(x)' char(diff(f_dh1(x)))]);
             x0= a;
             while (f(x0)*f_dh2(x0))<=0
                 x0= (x0+b)/2;
             end
             while (1)
                 nghiem= x0-(f(x0)/f_dh1(x0));
                 if abs(nghiem-x0)< saiso
                     break;
                 end
                 x0= nghiem;
                 solanlap= solanlap+1;
             end
             nghiem= double(nghiem);
         end
end
