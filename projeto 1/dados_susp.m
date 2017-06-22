%Definiçao das matrizes
kf=20000;
kp=250000;
ms=400;
mr=50;
ba=1000;
A=[0 1 0 0;-(kf/ms) -(ba/ms) (kf/ms) (ba/ms); 0 0 0 1; (kf/mr) (ba/mr) -(kf+kp)/mr -(ba/mr)]; 
%Matriz A corrigida, estava errado o A(4,3)=-(kf+kp)/mr;
B=[0 0;0 -1/ms; 0 0;(kp/mr) (1/mr)];  % MATRIZ B TEM SINAL INVERTIDO !
%B=[0 0;0 0; 0 0;(kp/mr) 0];
C=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1]; %matriz C corrigida, estava errado o C(3,4)
D=[0 0; 0 0; 0 0; 0 0]; 
%R=zeros(4,2);
%D=zeros(4,4);
Con = 1400;
Coff = 500;

VabsTol = [-0.25, -0.125, 0, 0.125, 0.25];
VrelTol = [-5 -2.5 0 2.5 5];

for i = 1:5
   for j = 1:5
       if(VabsTol(i)*VrelTol(j) >= 0)
            M(i,j) = Con*VabsTol(i) + Coff*VrelTol(j);
       else
            M(i,j) = Coff*VrelTol(j);
       end
   end
end

%% Run code
clear t p a f;
for SEL = 1:4
    sim('susp_utf8')
    t{SEL} = tempo;
    p{SEL} = pos;
    a{SEL} = acel;
    f{SEL} = forca;
end
%% Plot
figure
plot(t{1},p{1},t{2},p{2},t{3},p{3},t{4},p{4})
title('Posição Chassis')
ylabel('Pos [m]')
xlabel('Tempo [s]')
legend('Fuzzy', 'Cont Variavel', 'On Off', 'Fuzzy Conf')
figure
plot(t{1},a{1},t{2},a{2},t{3},a{3},t{4},a{4})
title('Aceleração')
ylabel('Acel [m/s^2]')
xlabel('Tempo [s]')
legend('Fuzzy', 'Cont Variavel', 'On Off', 'Fuzzy Conf')
figure
plot(t{1},f{1},t{2},f{2},t{3},f{3},t{4},f{4})
title('Esforço de Controle')
ylabel('Fa [N]')
xlabel('Tempo [s]')
legend('Fuzzy', 'Cont Variavel', 'On Off', 'Fuzzy Conf')