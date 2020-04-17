%% �ο���
% 1. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ˵��
% ����UAV123ͨ������ͼ����ָ������������õ��ͼ

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

saveFileName = 'UAVDT_att';
saveFileType = 'png'; % pdf/png

fontSize = 24;
fontSizeLegend = 24;
lineWidth = 3; % ���ߵ��ߴ�

UAVDT_TACF = [0.377 0.365 0.439 0.430 0.447 0.424 0.397 0.384 0.572];
UAVDT_best = [0.364 0.352 0.406 0.421 0.443 0.399 0.385 0.361 0.573];
UAVDT_KCC = [0.332 0.304 0.398 0.390 0.431 0.340 0.351 0.322 0.480];
x = 1:9;
figure41 = figure(401);
% ֮ǰ��С 0 0 1350 500
set(figure41,'position',[0 0 1350 600]); % 0 0 1350 550
plot(x, UAVDT_TACF, '-ro','LineWidth',lineWidth);
hold on
plot(x, UAVDT_KCC, '--bs','LineWidth',lineWidth);
hold on
plot(x, UAVDT_best, '--gd','LineWidth',lineWidth);
hold on


xticks(1:9)
xtickangle(45)
xticklabels({'Background clutter','Large occlusion','Object blur',...
    'Small object','Illumination variation','Scale variations',...
    'Camera motion','Object motion','Long-term tracking'})

yLabelName = 'AUC';

axis([0.5 9.5 0.3 0.6])

% set(gca,'ytick',[],'yticklabel',[])
ylabel(yLabelName,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
legend({'TACF','KCC (Baseline)','Best of other trackers'},...
    'Location','northwest','FontSize',fontSize);
% title('UAVDT','fontsize',fontSize,'fontname','Times New Roman','fontweight','bold');
% �Ƿ�grid
set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

tightfig;

% �������
switch saveFileType
    case 'pdf'
        saveas(gcf,[saveFileName '.pdf']); % pdf
    case 'png'
        saveas(gcf,saveFileName,'png'); % png
    otherwise
        disp('Type error !')
end