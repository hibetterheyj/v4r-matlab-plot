%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ˵��
% ���ڲ�������������ͼv2
% - ����ֱ�Ӷ���excel�ļ���TODO��

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

% saveFileName = 'horizontal_line_chart';
saveFileName = 'IRI_analysis';
saveFileType = 'png'; % pdf/png
% text_or_not = true; % true/false

%% ����
% �ֶ�����
% ��ȡxlsx��TGRS-IBRI-MF.xlsx�����ṹ��
% frame	mu	lambda	gamma	Lrate	success	precision
C = readcell('./IRI0429.xls');
peakNum = 4;
start = 2; plot_length = 11; % ѡ������
frame = cell2mat(C(start:start+plot_length-1,1));
prec = cell2mat(C(start:start+plot_length-1,7));
succ = cell2mat(C(start:start+plot_length-1,6));

% ��ѡָ��
x_param = frame;
y_param = succ; % prec/succ

% ��ߵ�
% peak_prec = 8;
% peak_succ = 8;
% peak_vline_color = [217, 83, 25]/255;
baseline_color = [217, 83, 25]/255;

%% ��ʽ��ͼ
figureHCL = figure(301);
set(figureHCL,'position',[0 0 700 240]);
lineWidth = 2.5; % ���ߵ��ߴ�
fontSize = 14;
tickFontSize = 12;
barWidth = 0.5;
h1=bar(x_param, y_param(1:end),barWidth,...
    'EdgeColor',[0.90,0.90,0.90],...
    'FaceColor',[0.90,0.90,0.90]); % ǳ��
    ...'EdgeColor',[0.99,0.70,0.90],...
    ...'FaceColor',[0.99,0.70,0.90]); % ǳ��
    ...'EdgeColor',[0.99,0.97,0.60],...
    ...'FaceColor',[0.99,0.97,0.60]); % ǳ��
h1.FaceColor = 'flat';
% [0.89,0.76,0.70]; ǳ��
h1.CData(peakNum,:) = [0.89,0.76,0.70]; 
hold on
% h1=plot(x_param, y_param(1:end), 'o-',...
%     'Color',[0,0.4,0.74],...
%     'LineWidth',lineWidth,...
%     'MarkerSize',8,...
%     'MarkerEdgeColor',[0,0.45,0.74]);
h2=plot(x_param, y_param(1:end), '-',...
     'Color',[0.93,0.49,0.18],...
    'LineWidth',lineWidth);
    

%����x�᷶Χ�Ϳ̶�
set(gca,'XLim',[min(x_param)-0.5, max(x_param)+0.5]);%X���������ʾ��Χ
% set(gca,'XTick',[1:plot_length]);%����Ҫ��ʾ����̶�
% set(gca,'XTickLabel',num2str(x_param,'%.2f'));
% set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
% set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
xLabelName1 = '\it{F}';

%����y�᷶Χ�Ϳ̶�
if y_param == succ
    % succ [0.4511 0.4699] 0.475/0.465 0.491
    set(gca,'YLim',[0.430 0.480]);%X���������ʾ��Χ
%     set(gca,'YTick',[0.475:0.005:0.490]);%����Ҫ��ʾ����̶�
    % set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    yLabelName1 = 'Success rate';
elseif y_param == prec
    % prec [0.7045 0.7377] 0.660/0.655 0.689
    set(gca,'YLim',[0.700 0.740]);%X���������ʾ��Χ
    set(gca,'YTick',[0.690:0.01:0.750]);%����Ҫ��ʾ����̶�
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    % set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
    yLabelName1 = 'Precision';
end

% Times ����
set(gca,'FontName','Times New Roman','fontSize',tickFontSize); % ����������ֵ����
xlabel(xLabelName1,'fontsize',fontSize,'fontname','Times New Roman'); % ��������
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
% Ĭ���޳�������
% set(gca,'fontSize',fontSize); % ����������ֵ����
% xlabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������


% �Ƿ�grid
set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���
set(gca,'box','on')

tightfig;

if y_param == succ
    saveFileName = [saveFileName '_succ'];
elseif y_param == prec
    saveFileName = [saveFileName '_prec'];
end

% �������
switch saveFileType
    case 'pdf'
        saveas(gcf,[saveFileName '.pdf']); % pdf
    case 'png'
        saveas(gcf,saveFileName,'png'); % png
    otherwise
        disp('Type error !')
end