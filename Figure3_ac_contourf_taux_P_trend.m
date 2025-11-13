% DESCRIPTION:
%  These codes aim to plot the volume transport of Indonesian Throughflow
%  (ITF), as well as its thermosteric and helostrric components, as a function of atmospheric CO2 mass.
%  The ITF and atmospheric CO2 mass are from the CMIP6 simulations
%  Data source: https://aims2.llnl.gov/search/cmip6/
% AUTHOR:   Shijian Hu, 2025 (sjhu@hhu.edu.cn)

clear; 
close all; 
clc;

load CMIP6_1pctCO2_Tauxy_P_trend_1850d1880_1880d1970_20240410.mat 

trend_tauxcmo=trend_tauxcmo_1880_1970;
trend_pcmo=trend_pcmo_1880_1970;

taux_1pctCO2=squeeze(nanmean(trend_tauxcmo,3));
P_1pctCO2=squeeze(nanmean(trend_pcmo,3));

for i=1:360
    for j=1:180
        taux_1pctCO2_std(i,j)=std(squeeze(trend_tauxcmo(i,j,:)));
        P_1pctCO2_std(i,j)=std(squeeze(trend_pcmo(i,j,:)));
    end
end
taux_1pctCO2=taux_1pctCO2*100*1200;
taux_1pctCO2_std=taux_1pctCO2_std*100*1200;

P_1pctCO2=P_1pctCO2*1200;
P_1pctCO2_std=P_1pctCO2_std*1200;


load ColormapFor1pctTaux.mat
nx=[1:71 76:360];
figure;  hold on;
m_proj('stereographic','lat',5,'long',125,'radius',50);
m_pcolor(long,latg,taux_1pctCO2');
shading flat;
for i=1:360
    for j=1:180
        if taux_1pctCO2(i,j)>taux_1pctCO2_std(i,j)*0.5
            m_plot(long(i),latg(j),'marker','.','markersize',2,'color','k');
        end
    end
end
m_contour(long,latg,taux_1pctCO2',-3:0.5:4,'color','w','linewidth',2);
[c,h]=m_contour(long,latg,taux_1pctCO2',[-3:0.5:-0.5 0.5:0.5:4],'color','k','linewidth',0.5); clabel(c,h);
[c,h]=m_contour(long,latg,taux_1pctCO2',[0 0],'color','k','linewidth',1); clabel(c,h);
m_coast('patch',[.6 .6 .6]);
m_grid('linestyle','-','xticklabels',[],'yticklabels',[],'ytick',[-80:10:80],'xtick',[0:20:360]);
caxis([-2 2]); colormap(cc);
colorbar('Position',[0.87 0.35 0.01 0.3],'TickDirection','in','Box','on',...
	'FontName','Arial','FontSize',11);
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 9.5 9]);
set(gca,'Position',[.03 .1 .83 .85]);


load ColormapFor1pctPrec.mat
figure;  hold on;
m_proj('stereographic','lat',5,'long',125,'radius',50);
m_pcolor(long,latg,P_1pctCO2'); shading flat;
for i=40:180
    for j=40:141
        if P_1pctCO2(i,j)>P_1pctCO2_std(i,j)*0.5
            m_plot(long(i),latg(j),'marker','.','markersize',2,'color','k');
        end
    end
end
m_contour(long,latg,P_1pctCO2',-90:10:90,'color','w','linewidth',2);
[c,h]=m_contour(long,latg,P_1pctCO2',[-90:10:-10 10:10:90],'color','k','linewidth',0.5); clabel(c,h);
[c,h]=m_contour(long,latg,P_1pctCO2',[0 0],'color','k','linewidth',1); clabel(c,h);
m_coast('patch',[.6 .6 .6]);
m_grid('linestyle','-','xticklabels',[],'yticklabels',[],'ytick',[-80:10:80],'xtick',[0:20:360]);
caxis([-60 60]); colormap(cc);
colorbar('Position',[0.87 0.35 0.01 0.3],'TickDirection','in','Box','on',...
	'FontName','Arial','FontSize',11);
% % set figure position
set(gcf,'unit','centimeters','position',[2 2 9.5 9]);
set(gca,'Position',[.03 .1 .83 .85]);
