function norma = rozw_chol(A,b)
  
	M=A'*A	%z racji, ¿e nie zawsze wylosowana macierz bêdzie dodatnio okreœlona, muszê rozwi¹zaæ uk³ad 
	B=A'*b	% A'*Ax=A'b, poniewa¿ A'*A spe³nia ten warunek
	
	n = length( M ) %macierz jest kwadratowa, wiêc wystarczy funkcja length, ¿eby poznaæ wymiary
	L = zeros( n, n )	% w tê macierz bêdê wk³ada³ kolejne policzone wartoœci dla rozk³adu L'L
for j=1:n	%jest to rozk³ad choleskiego-banachiewicza, czyli liczony jest wierszami, wiêc gówna pêtla
			%to wiersze od pierwszego do ostatniego, dolna pêtla to kolumny od pierwszej do j-tej
   for i=1:j
		if i==j
			L(i, i) = sqrt(M(i, i) - L(i, :)*L(i, :)'); %dla elementów macierzy le¿¹cych na przek¹tnej
		else
		
      L(j, i) = (M(j, i) - L(i,:)*L(j ,:)')/L(i, i);	%dla pozosta³ych
	  endif
   end
end
	U=L'	
	  
	
	y=U'\B 	%rozwi¹zanie LZNK
	x=U\y
	
	norma = norm((b-A*x),2);
	
	
	endfunction



