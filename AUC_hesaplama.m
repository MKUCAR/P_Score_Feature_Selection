function [AUC_test] = AUC_hesaplama(testc, tests)

% ROC eðirilerinin çizdirilmesi
% close all ; clear all ; clc ;
% 
% load sonuc_PPG

L_tc = length(testc) ;
L_ts = length(tests) ;

for i = 1:L_tc
    if testc(i) == 1 ;
    testc(i) == testc(i) ;
    elseif testc(i) == 2 ;
        testc(i) = 0 ;
    end
end

for i = 1:L_ts
    if tests(i) == 1 ;
    tests(i) == tests(i) ;
    elseif tests(i) == 2 ;
        tests(i) = 0 ;
    end
end
% spss için ROC seti oluþturma
% ROC_test = [testc', tests'] ;

% AUC deðerinin hesaplanmasý
[Xt,Yt,Tt,AUC_test] = perfcurve(testc', tests',1); % 1 hasta olduðu için yazýldý. Hasta kodu baþka olsaydý baþka yazýlýrdý.

end
