%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html
% 3. matlab��һ���ֲ��Ŵ��ͼ��ͼ
% https://blog.csdn.net/wangh0802/article/details/70237118
% 4. matlab - axes
% https://ww2.mathworks.cn/help/matlab/ref/axes.html
% 5. matlab - rectangle ���Σ�Բ�Ǿ��Σ���Բ
% https://ww2.mathworks.cn/help/matlab/ref/rectangle.html

%% ����
% ���tightfig
clc;clear;close all;
% ���tightfig
addpath('../');

% ��������
load('ReCF_succ_data.mat');
data = ReCF_succ_data.gI;
gI = data(:,1);
gH = data(:,2);
succ = data(:,4);
% ȡ�������м�����
data2 = data;
% 9:79.5 10:80
% data2(9,:) = [];
% data2(10:15,:) = [];
% gI2 = data2(:,1);
% gH2 = data2(:,2);
% succ2 = data2(:,4);

figure33_1 = figure(301);
set(figure33_1,'position',[0 0 1000 400]);
h1=plot(gI, succ, 'o-',...
    'Color',[0,0.4,0.74],...
    'LineWidth',1.5,...
    'MarkerSize',5,...
    'MarkerEdgeColor',[0,0.45,0.74]); % [0,0.45,0.74]
    ...'MarkerFaceColor',[0.5,0.5,0.5]
hold on
% ��ǰ��Χ
% rectangle('Position',[81 0.448 1 0.01],'LineWidth',1.5)
% rectangle('Position',[79 0.451 4 0.012],'LineWidth',1.5)
% Բ��
rectangle('Position',[78.5 0.444 5.5 0.02],'LineWidth',1.5,'Curvature',[1 1]);

% ����ĺ���
% hold on
% plot(gamma, min(prec) * baseline, 'r--','LineWidth',2);

% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

axis([0 100 0.350 0.47]);
yLabelName1 = 'Success rate';

fontSize = 13;
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

% ��ʾͼ��߿�
set(gca,'box','on')

% set(legend1, 'Fontname', 'Times New Roman','FontWeight','normal'); % ����legend����

% ����ytickȫΪ������λС��
set(gca,'ytick',(0.35:0.02:0.47))
set(gca,'yTickLabel',num2str(get(gca,'yTick')','%.3f'))
% �Զ���xtick
% xticks(0:0.05:0.4);
% xticklabels({'0','0.05','0.10','0.15','0.20','0.25','0.30','0.35','0.40'});

lineWidth = 5; % ���ߵ��ߴ�
xLabelName = '\gamma_I';
% xlabel(xLabelName,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
xlabel(xLabelName,'fontsize',fontSize); % ��������

% ���½�λ�ڵ� (0.5,0.2) ������Ⱥ͸߶�Ϊ (0.28,0.25)
axes('Position',[0.58,0.2,0.3,0.26]); % ������ͼ   
startIndex = 9;endIndex = 16; % startIndex:endIndex
chooseIndex = 13;
h2=plot(gI(startIndex:endIndex), succ(startIndex:endIndex), 'o-',...
    'Color',[0,0.4,0.74],...
    'LineWidth',2,...
    'MarkerSize',8,...
    'MarkerEdgeColor',[0,0.45,0.74]); % [0,0.45,0.74]
    ...'MarkerFaceColor',[0.5,0.5,0.5]
% ������ͼ�����᷶Χ 
hold on
lineX = [81.5, 81.5];lineY = [0.448,succ(chooseIndex)];
plot(lineX,lineY,'r--','LineWidth',1.5);
% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���
% ����������ֵ����
subFontSize = 8;
set(gca,'FontName','Times New Roman','fontSize',subFontSize);
% ����xtickȫΪ������λС��
set(gca,'xtick',(79.5:0.5:83))
set(gca,'xTickLabel',num2str(get(gca,'xTick')','%.1f'))
% ����ytickȫΪ������λС��
set(gca,'ytick',(0.448:0.002:0.458))
set(gca,'yTickLabel',num2str(get(gca,'yTick')','%.3f'))
xlim([min(gI(startIndex:endIndex)),max(gI(startIndex:endIndex))]); 
ylim([0.448,0.458]);

tightfig;

% �������
saveas(gcf,'ReCF_succ_gI.pdf') % pdf
saveas(gcf,'ReCF_succ_gI','png') % png