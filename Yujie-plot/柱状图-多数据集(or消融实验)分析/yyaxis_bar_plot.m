%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html
% 3. matlab - yyaxis
% https://ww2.mathworks.cn/help/matlab/ref/yyaxis.html
% 4. matlab - text
% https://ww2.mathworks.cn/help/matlab/ref/text.html
% 5. MATLAB Answers - Black axes for yyaxis (not default blue and orange)
% https://www.mathworks.com/matlabcentral/answers/451917-black-axes-for-yyaxis-not-default-blue-and-orange

%% ˵��
% �����������һ��ָ���������ݼ��ķ���

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

saveFileName = 'yyaxis_bar_plot';
saveFileType = 'png'; % pdf/png
addText = true; % true/false
fontSize = 12;

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 450]);

% ����
y=[0.4540 0.7173;0.4620 0.7287;0.4699 0.7377;];
x=1:size(y,1);
% �������εĿ������Ϊ�����ο����ܿռ�� 80%��
barWidth = 0.26;
centerOffset = 0.16;
xlim([0.5 3.5])
%% ���
yyaxis left
b=bar(x-centerOffset, y(:,1), barWidth);
ylim([0.44 0.48])
set(gca,'yTickLabel',num2str(get(gca,'yTick')','%.3f'))
yLabelName1 = 'Success rate';
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold','Color','k'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName21,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName2,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����
% �ֶ�����������ֱ�ǩ
% 'HorizontalAlignment' - �����λ�õ�ˮƽ�����ı�������ʹ��'center'��
% 'left' ��Ĭ�ϣ� | 'center' | 'right'
% 'VerticalAlignment' - �����λ�õ�ˮƽ�����ı�������ʹ��'bottom'��
% 'middle' ��Ĭ�ϣ� | 'top' | 'bottom' | 'baseline' | 'cap'
if addText
    for i = 1 : size(y, 1)
        if i == size(y, 1)
            text(x(i)-centerOffset, y(i,1), num2str(y(i,1)','%.3f'),...
                'fontname','Times New Roman','fontweight','bold','HorizontalAlignment','center','VerticalAlignment','bottom');
        else
            text(x(i)-centerOffset, y(i,1), num2str(y(i,1)','%.3f'),...
                'fontname','Times New Roman','HorizontalAlignment','center','VerticalAlignment','bottom');
        end
    end
end

%% �ұ�
yyaxis right
b=bar(x+centerOffset, y(:,2), barWidth);
ylim([0.70 0.74])
%����y�᷶Χ�Ϳ̶�
set(gca,'yTickLabel',num2str(get(gca,'yTick')','%.3f'))
yLabelName2 = 'Precision';
% Times ����
ylabel(yLabelName2,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold','Color','k'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName2,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����
% �ֶ�����������ֱ�ǩ
if addText
    for i = 1 : size(y, 1)
        if i == size(y, 1)
            text(x(i)+centerOffset, y(i,2), num2str(y(i,2)','%.3f'),...
                'fontname','Times New Roman','fontweight','bold','HorizontalAlignment','center','VerticalAlignment','bottom');
        else
            text(x(i)+centerOffset, y(i,2), num2str(y(i,2)','%.3f'),...
                'fontname','Times New Roman','HorizontalAlignment','center','VerticalAlignment','bottom');
        end
    end
end

%% ����
% �޸�Ĭ����ɫ
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

%����x�᷶Χ�Ϳ̶�
% set(gca,'XLim',[1, 5]);%X���������ʾ��Χ
set(gca,'XTick',[1:3]);%����Ҫ��ʾ����̶�
set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
set(gca,'XTickLabel',{'IBRI (w/o MF+DA)','IBRI (w/o DA)','\textbf{IBRI}'})
% xlabel('')
% ���ñ�ǩ������λ��
legend('Success rate','Precision','Location','northwest');

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