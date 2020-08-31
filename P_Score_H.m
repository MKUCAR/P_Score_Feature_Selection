function [N_S_O,N_S_O_20,S_O,S_O_20]=P_Score_H(A)
%% Bu kodlar P-Score'a g�re se�im yap�lm��t�r.
% close all; clear; clc;
% tic
% %% Verilerin y�klenmesi
% cd .. ; cd a_Data\a_Gruplu
% load Gruplu
% cd ..\.. ; cd b_Kod ;
%% Performansa dayal� �zellik Se�me
% Burada �zellikler s�rayla s�n�fland�r�lacak. Her �zellik i�in performans
% de�erleri hesaplanacak.
% Data=[A(:,1) A(:,end)];
% Data=A;
ornekyuzde=50;
[Satir Sutun]=size(A);
P_Score=[linspace(1, Sutun-1, Sutun-1)' linspace(0, 0, Sutun-1)'];
tic
for i=1:Sutun-1
    Data=[A(:,i) A(:,end)];
    [egitim, egitimc, test, testc] = orneklem(Data,ornekyuzde);
% SVMs yap�s�n�n olu�turulmas�
SVMstruct=fitcsvm(egitim,egitimc,'KernelFunction','rbf','Standardize', ...
    1,'KernelScale','auto','BoxConstraint',1,'OutlierFraction',0.05);
tests = predict(SVMstruct,test) ;
%% Performans�n hesaplanmas�
gercek_sonuclar = testc ;
simulasyon_sonuclari = tests ;
capraz_tablo = crosstab(gercek_sonuclar, simulasyon_sonuclari) ;
[s1 s2]=size(capraz_tablo);
if s2==1
    capraz_tablo(1,2)=0;
    capraz_tablo(2,2)=0;
end
% Tablonun sa� taraf�ndaki toplamlar�n yaz�d�rlmas�
capraz_tablo(1,3) = capraz_tablo(1,1) + capraz_tablo(1,2) ;
capraz_tablo(2,3) = capraz_tablo(2,1) + capraz_tablo(2,2) ;
% Tablonun alt taraf�ndaki toplamlar�n yaz�d�rlmas�
capraz_tablo(3,1) = capraz_tablo(1,1) + capraz_tablo(2,1) ;
capraz_tablo(3,2) = capraz_tablo(1,2) + capraz_tablo(2,2) ;
capraz_tablo(3,3) = capraz_tablo(3,1) + capraz_tablo(3,2) ;
%% �lk S�n�f i�in S�n�f do�ruluk oran�, Sensivity ve specificity de�erlerinin hesaplanmas�
TP = capraz_tablo(1,1) ;
FN = capraz_tablo(1,2) ;
TN = capraz_tablo(2,2) ;
FP = capraz_tablo(2,1) ;
% Do�ruluk Oran�
ACC =(TP+TN)/(TP+TN+FP+FN) ; 
% Sensivity
Sensivitiy=TP/(TP+FN) ;
% Specificity
if TN==0
  Specificity=0;
else
    Specificity = TN / (TN+FP) ;
end
F_olcumu=(2*Sensivitiy*Specificity)/(Sensivitiy+Specificity) ;
% Kappa
kappa = cohenskappa(testc,tests) ;
% AUC
[AUC] = AUC_hesaplama(testc, tests) ;

% Performans Parametrelerinin toplanmas�
Performans=[ACC;Sensivitiy;Specificity;F_olcumu;kappa;AUC];
% Performans Score'�n hesaplanmas�
P_Score(i,2)=mean(Performans);
end
T1=toc;
tic
%% V1
%% 1.E�ik de�erine g�re �zellikler se�ilecektir.
P_Score_Esik=mean(P_Score(:,2),1);
a=0;
for i=1:Sutun-1
    if P_Score(i,2)>P_Score_Esik
        a=a+1;
        Sec(a,:)=P_Score(i,:);
    end
end
Sec=sortrows(Sec,1,'ascend');
N_S_O=size(Sec,1);
S_O=[A(:,Sec(:,1)) A(:,end)];
T2=toc;
tic
%% V2
%% 2. %20 �zellikler se�ilecektir.
N_S_O_20=round(20*(Sutun-1)/100);
S_O_20=[A(:,Sec(1:N_S_O_20,1)) A(:,end)];
T3=toc;
V1=T1+T2;
V2=T1+T3;
end