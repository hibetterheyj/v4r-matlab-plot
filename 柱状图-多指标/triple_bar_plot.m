%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% TODO
% ����������ɫ�л�
% 0.01, 0.44, 0.75
% 0.88, 0.46, 0.40
% 0.04, 0.56, 0.64


%% ˵��
% �����������һ��ָ�꣨���л����������ݼ��ķ���

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

% ���ݣ��޸Ĵ˴�
metrix = 'prec'; % prec succ
saveFileName = 'triple_bar_plot_';
saveFileType = 'png'; % pdf/png

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 400]);

if metrix == 'prec'
    prec=[0.359 0.464 0.246;0.455 0.551 0.454; 0.539 0.599 0.552;];
    yRange = [0.20, 0.65];
    plotVariable = prec;
    yLabelName1 = 'Precision';
elseif metrix == 'succ'
    succ=[0.239 0.322 0.144;0.317 0.379 0.271; 0.384 0.413 0.352;];
    yRange = [0.10, 0.48];
    plotVariable = succ;
    yLabelName1 = 'Success rate';
end
% �������εĿ������Ϊ�����ο����ܿռ�� 80%��
barWidth = 0.8;
bar(plotVariable, barWidth);

% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

%����x�᷶Χ�Ϳ̶�
% set(gca,'XLim',[1, 5]);%X���������ʾ��Χ
% set(gca,'XTick',[0:1:10]);%����Ҫ��ʾ����̶�
set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
% set(gca,'XTickLabel',{'ReCF-N','ReCF-RCA','ReCF-HRR','TACF3','\textbf{TACF}'})
set(gca,'XTickLabel',{'ReCF-N','ReCF-RCA','\textbf{ReCF-HRR}'})
% xlabel('')
%����y�᷶Χ�Ϳ̶�
set(gca,'YLim',yRange);%X���������ʾ��Χ
if metrix == 'prec'
    set(gca,'YTick',[0.20:0.1:0.65]);%����Ҫ��ʾ����̶�
    set(gca,'YTickLabel',{'20.0','30.0','40.0','50.0','60.0'});%������ӱ�ǩ
elseif metrix == 'succ'
    set(gca,'YTick',[0.10:0.1:0.45]);%����Ҫ��ʾ����̶�
    set(gca,'YTickLabel',{'10.0','20.0','30.0','40.0'});%������ӱ�ǩ
end
% ���ñ�ǩ������λ��
legend('UAV123@10fps','DTB70','UAVDT','Location','northwest');

fontSize = 12;
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

% �ֶ�����������ֱ�ǩ
verticalOffset = 0.015;
for i = 1 : size(plotVariable, 1)-1
    text(i - 0.35*barWidth, plotVariable(i,1) + verticalOffset, string(100*plotVariable(i,1)),'fontname','Times New Roman');
    text(i - 0.07*barWidth, plotVariable(i,2) + verticalOffset, string(100*plotVariable(i,2)),'fontname','Times New Roman');
    text(i + 0.21*barWidth, plotVariable(i,3) + verticalOffset, string(100*plotVariable(i,3)),'fontname','Times New Roman');
end
% �������
i = size(plotVariable, 1);
text(i - 0.35*barWidth, plotVariable(i,1) + verticalOffset, string(100*plotVariable(i,1)),'fontname','Times New Roman','fontweight','bold');
text(i - 0.07*barWidth, plotVariable(i,2) + verticalOffset, string(100*plotVariable(i,2)),'fontname','Times New Roman','fontweight','bold');
text(i + 0.21*barWidth, plotVariable(i,3) + verticalOffset, string(100*plotVariable(i,3)),'fontname','Times New Roman','fontweight','bold');

tightfig;

% �������
switch saveFileType
    case 'pdf'
        saveas(gcf,[saveFileName metrix '.pdf']); % pdf
    case 'png'
        saveas(gcf,[saveFileName metrix],'png'); % png
    otherwise
        disp('Type error !')
end