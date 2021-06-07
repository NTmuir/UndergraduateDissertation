%% MATLAB Model bearing values
close all
clear
clc
%Stating the values for the feeder cable per unit
rs_u = 0.33e-6; %(H/m)
ls_u = 0.0127; %(Ohm/m)
rp_u = 138; %(kOhm/m)
cp_u = 211; %(pF/m)
u = 5; %(m)

%Feeder cable values converted from length of cable
rs = (rs_u)*u;
ls = (ls_u)*u;
rp = (rp_u)*u;
cp = (cp_u)*u;

%Motor Phase Impedance
% Ra = 58.6; %('ohm)
% La = 0.3; %(mH)
Ra = (1/0.019); %'Ohm (YASA)
La = 0.428; %mH (YASA)

%Capacitive Couplings
% Csr = 24.06; %(pF)
% Csf = 8.81; %(nF)
% Crf = 217; %(pF)
Csr = 16.4; %(pF) (YASA)
Csf = 4.68; %(pF->nF) (YASA)
Crf = 6.55; %(pF) (YASA)

%Bearing equivalent model
Cb = 1.2; %(nF)
Rb = 2.5; %(Mohm)
RB = 6.5; %(Ohm)
LB = 150; %(nH)

% Bearing simulation parameters
Vth_Min = 3; %(V)
h_0 = 150;
Vth_Max = 30; %(V)
t1 = 0;
t2 = 40E-6;
t3 = 75E-6;
t4 = 130E-6;
% dt = 
% 
%% Common Ground Plot

sim('Motor_Bearing_Model.slx')

figure
plot(ans.tout,ans.Vcom)
xlabel('Time (s)');
ylabel ('Voltage Common (V)');

%% Discharge Calculations


[E_Cond] = abs(0.5*(Cb + Crf)*[ans.Vtb].^2*(1/1000));
 
[Eint] = abs([ans.Vb].*[ans.Ib].*(1/1000));

[Vb] = abs(ans.Vb.*1/60);

[Ib] = abs(ans.Ib.*1/6);

Discharge = abs([E_Cond]./[Eint])*30;

%% Graphics of voltage and current

yyaxis left
ylabel('|Bearing Voltage [V]|')
plot(ans.tout,Vb)
hold on
yyaxis right
ylabel('|Bearing Current [A]|')
plot (ans.tout,Ib)
xlim([0,0.1])
xlabel('Time (s)')

%% PDF calcalutions and curve fitter

x_Di = 0:5:800;
x_V = 0:1:20;
x_I = 0:0.01:0.4;

pdDi = fitdist(Discharge,'Kernel');

pdV = fitdist(Vb,'Kernel');

pdI = fitdist(Ib,'Kernel');

yDi = cdf(pdDi,x_Di);

yV = cdf(pdV,x_V);

yI = cdf(pdI,x_I);

figure
histogram(Discharge,'BinWidth',25);
xlabel('|Discharge Energy Bearing [nJ]|');
ylabel ('Frequency');

figure
histogram(Vb,'BinWidth',1)
xlabel('|Bearing Voltage [V]|');
ylabel ('Frequency');


figure
histogram(Ib)
xlabel('|Bearing Current [A]|');
ylabel ('Frequency');

figure
plot(x_Di,yDi,'k-','LineWidth',2)
xlabel('|Discharge Energy Bearing [nJ]|');
ylabel ('CDF');

figure
plot(x_V,yV,'k-','LineWidth',2)
xlabel('|Bearing Voltage [V]|');
ylabel ('CDF');

figure
plot(x_I,yI,'k-','LineWidth',2)
xlabel('|Bearing Current [A]|');
ylabel ('CDF');

%% Mean and Variance values

Eb_MU = mean(pdDi);
Eb_Var = var(pdDi);

V_MU = mean(pdV);
V_Var = var(pdV)*0.1;

I_MU = mean(pdI);
I_Var = var(pdI);

T = table(Eb_MU,Eb_Var,V_MU,V_Var,I_MU,I_Var);
T(1:1,:)

%% Damage radius criterium
% Assuming n_melt and n_vap to be 50%

E_Melt = 0.5*Eb_MU*10^-6; %(J)

E_Vap = Eb_MU*10^-6; %(J)

rhoHv = 1.2*10^10; %(J/m^3)

rhoHm = 5.72*10^9; %(J/m^3)

V_exp_Melt = (E_Melt/rhoHm)*(1e18); %(um^3)

V_exp_Vap = (E_Vap/rhoHv)*(1e18); %(um^3)

r_d_Melt = (((3*V_exp_Melt)/(2*pi))^(1/3));

r_d_Vap = (((3*V_exp_Vap)/(2*pi))^(1/3));

R = table(r_d_Melt,r_d_Vap,V_exp_Melt,V_exp_Vap);
R(1:1,:)

%% Life calculation
%Using the current with hertizian contact of the preload

Hertz = 0.394;
%Hertz = 0.496;
%Hertz = 0.568;
BCD = (I_MU/Hertz);

life = 7867204*10^(-(2.17*BCD));
disp(life)