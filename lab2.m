load birth.dat
% Load datan som vi är intresserade över
alder = birth(:, 4);
hojd = birth(:, 16);
viktMamma = birth(:, 15);
viktBarn = birth(:, 3);

% Plotta jämförelse med Normalfördelning

subplot(2,2,1)
normplot(alder), title('mammans ålder')
subplot(2,2,2)
normplot(hojd), title("mammans längd") 
subplot(2,2,3)
normplot(viktMamma), title("mammans vikt") 
subplot(2,2,4)
normplot(viktBarn), title("barnets vikt")


alder = birth(:, 4);
hojd = birth(:, 16);
viktMamma = birth(:, 15);
viktBarn = birth(:, 3); 
procent = 0.05;
% Kollar JB-test
alderJB = jbtest(alder, procent); 
hojdJB = jbtest(hojd, procent); 
viktMammaJB = jbtest(viktMamma, procent); 
viktBarnJB = jbtest(viktBarn, procent); 
fprintf('\nMammans ålder är Normalfördelad'), if alderJB==1, fprintf(", är falsk"), end
fprintf('\nMammans längd är Normalfördelad'), if hojdJB==1, fprintf(", är falsk"), end
fprintf('\nMammans vikt är Normalfördelad'), if viktMammaJB==1, fprintf(", är falsk"), end
fprintf('\nBarnets vikt är Normalfördelad'), if viktBarnJB==1, fprintf(", är falsk"), end


load moore.dat 

x = moore(:, 1); 
y = moore(:, 2); 
%Transistorernas värde från expontentiellt till länjärt 
w = log(y); 

% matris med 1or till vänster och datavärden till höger
X = [ones(length(x),1), x]; 

[B_circumflex,bint,r,rint,STATS] = regress(w, X);
w_circumflex = X*B_circumflex; 
figure 
plot(x, w) 
hold on 
plot(x, w_circumflex) 

%Kollar om skillnaden mellan datan (w) och modellens värde (w_circumflex) (moore's lag) är normalfördelat figure 
diff = w-w_circumflex; 
subplot(2,1,1), normplot(diff), subplot(2,1,2), hist(diff) 

% Få R^2 
R2 = STATS(1); 
% Funktion för antal transistorer/ytenhet för något år enligt modellen, använder ekvation för att hitta
% wi=log(yi)=0+1xi
antal2025 = exp(B_circumflex(1) + B_circumflex(2)*2025); 
fprintf('2025 antal: %d \n', antal2025) 
fprintf('R^2: %d \n', R2)


load birth.dat

%hur mammans längd påverkar barnens vikt, scatter plot
%enkel linjär modell, liten positiv relation
langdM = birth(:,16);   % Mammans längd
viktB = birth(:,3);    % Barns vikt

X = [ones(length(langdM),1), langdM];
B_circumflex = regress(viktB, X);
viktB_circumflex = X*B_circumflex;  % Skattning av barnets vikt

%plottar koden ovan
figure
scatter(langdM, viktB)
hold on
plot(langdM, viktB_circumflex)

%multipel linjär regressionsmodell med alla andra variabler
%innehåller mammans vikt, rökvanor, alkoholvanor i relation till barnens vikt
viktM = birth(:,15);      % Mammans vikt
rokM = birth(:,20)==3;   % Om mamman röker
drickM = birth(:,26)==2;   % Om mamman dricker

viktB2 = birth(:, 3);      % Barns vikt

X2 = [ones(size(viktM)), viktM, rokM, drickM];
[B,BINT,R] = regress(viktB2, X2);
viktB2_circumflex = X2*B;    % Skattning av barnets vikt 

fprintf('%d \n %d \n %d \n %d \n', B, BINT(:,1), BINT(:,2))
% Residualer verklig - regressvärde
figure
normplot(R)