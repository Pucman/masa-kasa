function raport(k)
m = input("Podaj liczbe m wierszy macierzy [m,n], gdzie m=>n:\n");

s = input("Podaj liczbe n kolumn macierzy [m,n], gdzie m=>n:\n");
k=k;

proby = linspace(1,k,k);	%tworz� wektory, do kt�rych p�zniej b�d� wk�ada� odpowiednie warto�ci
czasy = zeros(1,k);
czasy1 = zeros(1,k);
normy =zeros(1,k);
normy1 =zeros(1,k);
for i=1:k
 A = rand(m,s);		%generacja losowych macierzy do uk�adu r�wna�
b = rand(m,1);



	tic();							%tic i toc w celu zmierzenia czasu, normy(i) i czasy(i) wsadzenie warto�ci
	norma = rozw_chol(A,b);			% z danej pr�by do wektora
	normy(i)=norma;
	czasy(i)=toc;
	
	
	tic();
	norma1 = rozw_givens(A,b);
	normy1(i)=norma1;
	czasy1(i)=toc;
endfor

	figure;									%rysowanie
	plot(proby,czasy,proby, czasy1)
	czasy1;
	czasy;
	
	print wykresy_czas.jpg					%zapisanie do pliku
	Suma_czasow_chol=sum(czasy)				%suma czas�w
	Suma_czasow_givens=sum(czasy1)
	normy=sum(normy);
	normy1=sum(normy1);
	
	Srednie_czasy_chol=Suma_czasow_chol/k			%suma czas�w przez ilo�� pr�b - �rednia
	Srednie_czasy_givens=Suma_czasow_givens/k
	
	Srednie_drugie_residuum_chol=normy/k			%�rednia z drugich residuum
	Srednie_drugie_residuum_givens=normy1/k