% DESCRIPTION:
%  These codes aim to plot the volume transport of Indonesian Throughflow
%  (ITF), as well as its thermosteric and helostrric components, as a function of atmospheric CO2 mass.
%  The ITF and atmospheric CO2 mass are from the CMIP6 simulations
%  Data source: https://aims2.llnl.gov/search/cmip6/
% AUTHOR:   Shijian Hu, 2025 (sjhu@hhu.edu.cn)

clear; 
close all; 
clc;

load CMIP6_CO2mass_his_1pctCO2.mat
load CMIP6_ITF_ensemble.mat
co2mass_co2=co2mass_co2*1E-15;    
co2mass_his=co2mass_his*1E-15;

co2mass_co2_mn=nanmean(co2mass_co2);
co2mass_his_mn=nanmean(co2mass_his);
nt1=FindNumber(co2mass_co2_mn,3);
nt2=FindNumber(co2mass_co2_mn,8);

CL1=[150 189 226];   CL1=CL1./255;
CL2=[247 224 149];   CL2=CL2./255;
CL3=[198 198 198];   CL3=CL3./255;

time=1:1800;

figure;  hold on;
plot(rmean(nanmean(co2mass_co2),6),rmean(itf_1pct_co2_u,6),'linestyle','none','marker',...
    'o','markerfacecolor',[0 0 0],'markeredgecolor',[1 1 1],'markersize',4);
plot(rmean(nanmean(co2mass_his),6),rmean(itf_his_u,6),'linestyle','none','marker',...
    'o','markerfacecolor','none','markeredgecolor',[.4 .5 .7],'markersize',2);
y0=rmean(itf_1pct_co2_u,6);  x0=rmean(nanmean(co2mass_co2),6);
k=1;
for i=2:1:10
  num=find((x0<i+1)&(x0>i-1));
  x(k,1)=i;
  y(k,1)=median(y0(num));
  k=k+1;
end
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x,y,'color','w','linewidth',3);
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x([2 7]),y([2 7]),'linestyle','none','marker','o','markerfacecolor','r','markeredgecolor','w','markersize',10);
xy=x+y;   x(isnan(xy))=[];  y(isnan(xy))=[];  Rate=polyfit(x,y,1); Rate=Rate(1,1);
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',14);
ylabel('ITF transport (Sv)','fontname','arial','fontsize',14);
fig1(0,14); grid on;
L=legend('1pctCO2','Hist','1pctCO2-EN');
set(L,'fontsize',14,'location','southeast');
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 10.5 9.5]);
set(gca,'Position',[.17 .19 .8 .78]);
yTS=y;


figure;  hold on;
plot(rmean(nanmean(co2mass_co2),6),rmean(itf_1pct_co2_ms,6),'linestyle','none','marker',...
    'o','markerfacecolor',[.2 .2 .6],'markeredgecolor',[1 1 1],'markersize',4);
y0=rmean(itf_1pct_co2_ms,6);  x0=rmean(nanmean(co2mass_co2),6);
k=1;
for i=2:1:10
  num=find((x0<i+1)&(x0>i-1));
  x(k,1)=i;
  y(k,1)=median(y0(num));
  k=k+1;
end
for i=1:8
    xx(i,1)=(x(i)+x(i+1))./2;
    grad_yy(i,1)=(y(i+1,1)-y(i));
end
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x,y,'color','w','linewidth',3);
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x([2 7]),y([2 7]),'linestyle','none','marker','o','markerfacecolor','r','markeredgecolor','w','markersize',10);
xy=x+y;   x(isnan(xy))=[];  y(isnan(xy))=[];  RateMS=polyfit(x,y,1); RateMS=RateMS(1,1);
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',14);
ylabel('ITF transport (Sv)','fontname','arial','fontsize',14);
fig1(0,14); grid on; 
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 10.5 9.5]);
set(gca,'Position',[.17 .19 .8 .78]);
yT=y;


figure;  hold on;
plot(rmean(nanmean(co2mass_co2),6),rmean(itf_1pct_co2_mt,6),'linestyle','none','marker',...
    'o','markerfacecolor',[.6 .2 .2],'markeredgecolor',[1 1 1],'markersize',4);
y0=rmean(itf_1pct_co2_mt,6);  x0=rmean(nanmean(co2mass_co2),6);
k=1;
for i=2:1:10
  num=find((x0<i+1)&(x0>i-1));
  x(k,1)=i;
  y(k,1)=median(y0(num));
  k=k+1;
end
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x,y,'color','w','linewidth',3);
plot(x,y,'color',[0 0 0],'linewidth',2);
plot(x([2 7]),y([2 7]),'linestyle','none','marker','o','markerfacecolor','r','markeredgecolor','w','markersize',10);
xy=x+y;   x(isnan(xy))=[];  y(isnan(xy))=[];  RateMT=polyfit(x,y,1); RateMT=RateMT(1,1); 
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',14);
ylabel('ITF transport (Sv)','fontname','arial','fontsize',14);
fig1(0,14); grid on; set(gca,'ytick',-10:-6);
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 10.5 9.5]);
set(gca,'Position',[.17 .19 .8 .78]);
yS=y;


diffyTS=diff(yTS);
diffyT=diff(yT);
diffyS=diff(yS);

figure; hold on;
area(2.5:9.5,diffyT,'facecolor',CL1,'FaceAlpha',0.5);
area(2.5:9.5,diffyTS,'facecolor',CL2,'FaceAlpha',0.5);
area(2.5:9.5,diffyS,'facecolor',CL3,'FaceAlpha',0.5);
plot([3 3],[-1 2.5],'linestyle','--','color','k','linewidth',0.5);
plot([8 8],[-1 2.5],'linestyle','--','color','k','linewidth',0.5);
plot([3 8],[-1 -1],'linestyle','none','marker','o','markersize',6,'markerfacecolor',[1 0 0]);
plot(4.5,1.6,'linestyle','none','marker','^','markersize',10,'markerfacecolor',[.8 0 0]);
set(gca,'xlim',[2.5 9.5],'xtick',2:10,'ylim',[-1 2.5]);
L=legend('ITF_T','ITF_{TS}','ITF_S');
set(L,'fontsize',14,'location','northeast','Orientation','horizontal', 'FontAngle', 'italic');
xlabel('CO2 (10^{15} Kg)','fontname','arial','fontsize',14);
ylabel('Change rate of ITF','fontname','arial','fontsize',14);  %  (Sv per (10^{15} Kg)
set(gca,'fontsize',14);
box on;
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 10.5 9.5]);
set(gca,'Position',[.17 .19 .8 .78]);

