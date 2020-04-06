%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ˵��
% �����������һ��ָ���������ݼ��ķ���

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

saveFileName = 'double_bar_plot';
saveFileType = 'png'; % pdf/png

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 450]);

% ����
y=[0.389 0.374;0.432 0.421; 0.425 0.407; 0.423 0.398; 0.437 0.456;];
% �������εĿ������Ϊ�����ο����ܿռ�� 80%��
barWidth = 0.8;
b=bar(y, barWidth);
% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

%����x�᷶Χ�Ϳ̶�
% set(gca,'XLim',[1, 5]);%X���������ʾ��Χ
% set(gca,'XTick',[0:1:10]);%����Ҫ��ʾ����̶�
set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
% xlabel('')
%����y�᷶Χ�Ϳ̶�
set(gca,'YLim',[0.35, 0.48]);%X���������ʾ��Χ
% set(gca,'YTick',[95:1:101]);%����Ҫ��ʾ����̶�
% set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
yLabelName1 = 'Success Rate';
% ���ñ�ǩ������λ��
legend('UAVDT','UAV123@10fps','Location','northwest');

fontSize = 12;
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

% �ֶ�����������ֱ�ǩ
% 'HorizontalAlignment' - �����λ�õ�ˮƽ�����ı�
% 'left' ��Ĭ�ϣ� | 'center' | 'right'
verticalOffset = 0.0035;
for i = 1 : size(y, 1)
    % ԭ��
%     if i == size(y, 1)
%         text(i - 0.34*barWidth, y(i,1) + verticalOffset, string(y(i,1)),...
%             'fontname','Times New Roman','fontweight','bold');
%         text(i + 0.02*barWidth, y(i,2) + verticalOffset, string(y(i,2)),...
%             'fontname','Times New Roman','fontweight','bold');
%     else
%         text(i - 0.34*barWidth, y(i,1) + verticalOffset, string(y(i,1)),...
%             'fontname','Times New Roman');
%         text(i + 0.02*barWidth, y(i,2) + verticalOffset, string(y(i,2)),...
%             'fontname','Times New Roman');
%     end
    % �°�ֱ�Ӳ��þ��ж��룡
    if i == size(y, 1)
        text(i - 0.18*barWidth, y(i,1) + verticalOffset, string(y(i,1)),...
            'fontname','Times New Roman','fontweight','bold','HorizontalAlignment','center');
        text(i + 0.18*barWidth, y(i,2) + verticalOffset, string(y(i,2)),...
            'fontname','Times New Roman','fontweight','bold','HorizontalAlignment','center');
    else
        text(i - 0.18*barWidth, y(i,1) + verticalOffset, string(y(i,1)),...
            'fontname','Times New Roman','HorizontalAlignment','center');
        text(i + 0.18*barWidth, y(i,2) + verticalOffset, string(y(i,2)),...
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