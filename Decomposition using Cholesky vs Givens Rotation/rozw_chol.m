function norma = rozw_chol(A,b)
  
	M=A'*A	%z racji, �e nie zawsze wylosowana macierz b�dzie dodatnio okre�lona, musz� rozwi�za� uk�ad 
	B=A'*b	% A'*Ax=A'b, poniewa� A'*A spe�nia ten warunek
	
	n = length( M ) %macierz jest kwadratowa, wi�c wystarczy funkcja length, �eby pozna� wymiary
	L = zeros( n, n )	% w t� macierz b�d� wk�ada� kolejne policzone warto�ci dla rozk�adu L'L
for j=1:n	%jest to rozk�ad choleskiego-banachiewicza, czyli liczony jest wierszami, wi�c g�wna p�tla
			%to wiersze od pierwszego do ostatniego, dolna p�tla to kolumny od pierwszej do j-tej
   for i=1:j
		if i==j
			L(i, i) = sqrt(M(i, i) - L(i, :)*L(i, :)'); %dla element�w macierzy le��cych na przek�tnej
		else
		
      L(j, i) = (M(j, i) - L(i,:)*L(j ,:)')/L(i, i);	%dla pozosta�ych
	  endif
   end
end
	U=L'	
	  
	
	y=U'\B 	%rozwi�zanie LZNK
	x=U\y
	
	norma = norm((b-A*x),2);
	
	
	endfunction



