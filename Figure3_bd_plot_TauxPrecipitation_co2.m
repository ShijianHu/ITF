clear; close all; clc;
load CMIP6_CO2mass_his_1pctCO2.mat
co2mass_co2=co2mass_co2*1E-15;
co2mass_his=co2mass_his*1E-15;
load CMIP6_T_S_P_Tauxy_IP_1pct_0127.mat

S_IO=nanmean(mscmo_u200_xyz_i);
T_IO=nanmean(mtcmo_u200_xyz_i);
taux_IO=nanmean(mtauxcmo_xy_i)*1000;   taux_IO=taux_IO-nanmean(taux_IO);
rainfall_IO=nanmean(mpcmo_xy_i);  rainfall_IO=rainfall_IO-nanmean(rainfall_IO);

S_PO=nanmean(mscmo_u200_xyz_p);
T_PO=nanmean(mtcmo_u200_xyz_p);
taux_PO=nanmean(mtauxcmo_xy_p)*1000;   taux_PO=taux_PO-nanmean(taux_PO);
rainfall_PO=nanmean(mpcmo_xy_p);  rainfall_PO=rainfall_PO-nanmean(rainfall_PO);

colorIO=[200/250 130/250 40/250];
colorPO=[38/250 63/250 140/250];

figure;  hold on;
plot(rmean(nanmean(co2mass_co2),6),rmean(taux_IO,6),'linestyle','none','marker',...
    'o','markerfacecolor',colorIO,'markeredgecolor',[1 1 1],'markersize',3);
plot(rmean(nanmean(co2mass_co2),6),rmean(taux_PO,6),'linestyle','none','marker',...
    'o','markerfacecolor',colorPO,'markeredgecolor',[1 1 1],'markersize',3);
diffTaux=rmean(taux_PO,6)-rmean(taux_IO,6);
y0=diffTaux;  x0=rmean(nanmean(co2mass_co2),6);
k=1;
interval=1;
for i=2:interval:10
  num=find((x0<i+interval)&(x0>i-interval));
  x(k,1)=i;
  y(k,1)=nanmean(y0(num));
  k=k+1;
end
y=y*5;
plot(x,y,'color',[0 0 0],'linewidth',1,'marker','.','markersize',15);
plot(x,y,'color','w','linewidth',3);
plot(x,y,'color',[0 0 0],'linewidth',1,'marker','.','markersize',15);
nT=[FindNumber(x,3) FindNumber(x,8)];
plot(x(nT),y(nT),'linestyle','none','marker','o','markerfacecolor','r','markeredgecolor','w','markersize',10);
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',12);
ylabel('\tau_x anomaly (10^{-3} N m^{-2})','fontname','arial','fontsize',12);
fig1(0,12); grid on;
ylim([-10 10]);
L=legend('EIO','WPO','(WPO-EIO)*5');
set(L,'fontsize',12,'location','northout','orientation','horizontal','box','off');
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 9 8]);
set(gca,'Position',[.21 .19 .75 .65]);


figure;  hold on;
plot(rmean(nanmean(co2mass_co2),6),rmean(rainfall_IO,6),'linestyle','none','marker',...
    'o','markerfacecolor',colorIO,'markeredgecolor',[1 1 1],'markersize',3);
plot(rmean(nanmean(co2mass_co2),6),rmean(rainfall_PO,6),'linestyle','none','marker',...
    'o','markerfacecolor',colorPO,'markeredgecolor',[1 1 1],'markersize',3);
diffRainfall=rmean(rainfall_PO,6)-rmean(rainfall_IO,6);
y0=diffRainfall;  x0=rmean(nanmean(co2mass_co2),6);
k=1; interval=1;
clear x y;
for i=2:interval:10
  num=find((x0<i+interval)&(x0>i-interval));
  x(k,1)=i;
  y(k,1)=nanmean(y0(num));
  k=k+1;
end
plot(x,y,'color',[0 0 0],'linewidth',1,'marker','.','markersize',15);
plot(x,y,'color','w','linewidth',3);
plot(x,y,'color',[0 0 0],'linewidth',1,'marker','.','markersize',15);
nT=[FindNumber(x,3) FindNumber(x,8)];
plot(x(nT),y(nT),'linestyle','none','marker','o','markerfacecolor','r','markeredgecolor','w','markersize',10);
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',12);
ylabel('Precipitation anomaly (cm/yr)','fontname','arial','fontsize',12);
fig1(0,12); grid on;
ylim([-33 34]);
L=legend('EIO','WPO','WPO-EIO');
set(L,'fontsize',12,'location','northout','orientation','horizontal','box','off');
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 9 8]);
set(gca,'Position',[.21 .19 .75 .65]);
