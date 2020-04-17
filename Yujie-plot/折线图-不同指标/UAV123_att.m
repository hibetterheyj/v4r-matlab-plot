%% �ο���
% 1. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ˵��
% ����UAV123ͨ������ͼ����ָ������������õ��ͼ

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

saveFileName = 'UAV123_att';
saveFileType = 'png'; % pdf/png

fontSize = 24;
fontSizeLegend = 24;
lineWidth = 3; % ���ߵ��ߴ�
UAV123_TACF = [0.343 0.302 0.266 0.304 0.393 0.432 0.445 0.407 0.481 0.403 0.401 0.391];
UAV123_best = [0.339 0.332 0.247 0.299 0.379 0.424 0.449 0.394 0.464 0.400 0.389 0.392];
UAV123_KCC  = [0.237 0.217 0.185 0.214 0.302 0.331 0.331 0.302 0.376 0.326 0.268 0.302];
x = 1:12;
figure41 = figure(401);
set(figure41,'position',[0 0 1350 600]);
plot(x, UAV123_TACF, '-ro','LineWidth',lineWidth);
hold on
plot(x, UAV123_KCC, '--bs','LineWidth',lineWidth);
hold on
plot(x, UAV123_best, '--gd','LineWidth',lineWidth);
hold on

xticks(1:12)
xtickangle(45)
xticklabels({'Background clutter','Fast motion','Full occlusion',...
    'Low resolution','Illumination variation','Scale variations',...
    'Camera motion','Partial occlusion','Similar object',...
    'Viewpoint change', 'Out-of-view', 'Aspect ratio change'})

yLabelName = 'AUC';

axis([0.5 12.5 0.15 0.5])

% set(gca,'ytick',[],'yticklabel',[])
% title('UAV123@10fps','fontsize',fontSize,'fontname','Times New Roman','fontweight','bold');
ylabel(yLabelName,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
legend({'TACF','KCC (Baseline)','Best of other trackers'},...
    'Location','northwest','FontSize',fontSize);

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