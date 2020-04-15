%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html
% 3. matlab - text
% https://ww2.mathworks.cn/help/matlab/ref/text.html

%% ˵��
% ����������ڵ�һָ���������

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

saveFileName = 'single_bar_plot';
saveFileType = 'png'; % pdf/png

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 450]);

% ����
y=[0.71526 0.45648;
    0.71595 0.45722;
    0.71597 0.45733;
    0.71539 0.45684;
    0.71618 0.45833;
    0.71735 0.45957;];
% �������εĿ������Ϊ�����ο����ܿռ�� 80%��
prec = y(:,1);
succ = y(:,2);
index = succ; % prec/succ
barWidth = 0.6;
b=bar(index, barWidth);
% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

fontSize = 12;
%����x�᷶Χ�Ϳ̶�
% set(gca,'XLim',[1, 5]);%X���������ʾ��Χ
set(gca,'XTick',[1:1:6]);%����Ҫ��ʾ����̶�
% set(gca,'XTickLabel',num2str(get(gca,'XTick')','%.2f'))
% set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
% set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
xLabelName1 = '\it{\Delta k}';
% Times ����
xlabel(xLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

%����y�᷶Χ�Ϳ̶�
set(gca,'YLim',[0.44, 0.465]);%X���������ʾ��Χ
% set(gca,'YTick',[95:1:101]);%����Ҫ��ʾ����̶�
% set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
yLabelName1 = 'Success Rate';
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

% ���ñ�ǩ������λ��
% legend('UAVDT','UAV123@10fps','Location','northwest');

% �ֶ�����������ֱ�ǩ
% 'HorizontalAlignment' - �����λ�õ�ˮƽ�����ı�
% 'left' ��Ĭ�ϣ� | 'center' | 'right'
verticalOffset = 0.001;
for i = 1 : size(y, 1)
    if i == size(y, 1)
        text(i, index(i) + verticalOffset, num2str(index(i),'%.3f'),...
            'fontname','Times New Roman','fontweight','bold','HorizontalAlignment','center');
    else
        text(i, index(i) + verticalOffset, num2str(index(i),'%.3f'),...
            'fontname','Times New Roman','HorizontalAlignment','center');
    end
end

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