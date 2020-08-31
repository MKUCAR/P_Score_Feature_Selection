function [egitim, egitimc, test, testc] = orneklem(data,ornekyuzde)
% Veri setinden örneklem oluþturma programý

% SÝSTEMATÝK ÖRNEKLEME
 
% Toplum hacminin 1000 dolaylarýnda olduðu ve
% birimlere 1’den N’e kadar sýra numarasý verilebildiði
% durumlarda uygulanýr . 
% n örnek; 
% 1) Devir sayýsý (d) ; d <= N/n
% 2) Baþlangýç sayýsý (a); 1<= a <= d belirlenir .
% 3) Örnek no’larý a, a+d, a+2d, ..., a+(n-1)d þeklinde
% belirlenir .

% Not: Örneklem oluþturulurken satýr sayýlarý arasýnda örnek seçilir. Sütunlar dikkate alýnmaz.
% Not: Genel veri setinin öncelikle seçilecek özelliðie göre sýralanmasý gerekmektedir.
% Sýralama için  B = sortrows(A,3) komutu kullanýlabilir. A sýralanacak
% matris, 3 ise referans olarak sýralanacak matrisi ifade eder.

N =  size(data,1);
% ornekyuzde = 25 ;
n = floor(N*ornekyuzde/100) ;

% n = orneklem, N adet örnekten seçilecek yüzdelik miktarý miktarýný temsil eder.

% Devir sayýsýnýn hesaplanmasý
d = round(N/n) ; 

% Baþlangýç sayýsý (a)
a = 1 ;
s = size(data,2) ;
% Örneklenmiþ matris oluþturma (OM) Test verisi olarak kullanýlacaktýr.
% Test Veri seti
for i=1:n
    B=(a+d*(i-1));
    if (B>N)
        C=B-N;
    else
        C=B;
    end
	test1(i,:) = data(C,:) ;
end

test = test1(:,1:s-1) ;

testc = test1(:,s) ;

% Eðitim Veri seti

egitim1 = data ;
for i=1:n
	silme(i) = (a+d*(i-1)) ;
end    
    
silme=sort(silme,'descend');

for i=1:n
    k = silme(i) ;
    egitim1(k,:) = [] ;
end    

egitim = egitim1(:,1:s-1) ;

egitimc = egitim1(:,s) ;

end