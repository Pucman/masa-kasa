    function norma1 = rozw_givens(A,b);
 
		Y=A;  %przechowanie macierzy A
		
		[n,m] = size(A); %czytnie wielkoœci macierzy A
		
		
			
        Q = eye(n);
        

        for j = 1:m;			%od kolumny pierwszej do ostatniej
            for i = n:(-1):(j+1);  %od ostatniego wiersza, do wiersza j+1-szego, aby  zostawiæ przek¹tn¹ cofam siê o 1
                G = eye(n);			%tworzê macierz jednostkow¹ o rozmiarze n
                x=[A(i-1,j),A(i,j)]; 	%wektor, którego doln¹ wartoœæ bêdê zerowa³
				[c,s] = GivensRotation( A(i-1,j),A(i,j) ); 	%policzenie wartoœci c i s
                G(i-1,(i-1):i) = [c -s];	%"W³o¿enie" c i s w macierz jednostkow¹
                G(i,(i-1):i)   = [s c];		
                A=G*A;			%Liczenie macierzy R po danej rotacji.
				Q=Q*G';			%Liczenie macierzy Q po danej rotacji.
            end
        end
		
		for x=1:m;
			for y=1:m;
				R(x,y)=A(x,y);
			end
		end
			R;
			x=A\(Q'*b);		%rozwi¹zanie LZNK
			
			norma1 = norm((b-Y*x),2); 		%norma
	end
	
	