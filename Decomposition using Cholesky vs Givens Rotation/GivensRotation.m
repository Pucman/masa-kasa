function [c,s] = GivensRotation(a,b)
        if b == 0	%dla 100% pewno�ci, �eby unikn�� r�nego rodzaju b��d�w numerycznych doda�em ten warunek
            c = 1;
            s = 0;
        else
                r=sqrt(a.^2 + b.^2);		%zgodnie z wzorem
				c=a/r;
				s=-b/r;
            
            
        end
    end