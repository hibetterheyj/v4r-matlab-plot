%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html
% 3. matlab - text
% https://ww2.mathworks.cn/help/matlab/ref/text.html
% 4. matlab - Bar ����
% https://ww2.mathworks.cn/help/matlab/ref/matlab.graphics.chart.primitive.bar-properties.html

%% ˵��
% ����������ڵ�һָ���������

%% ����
clear;clc;close all;
% ���tightfig
addpath('../');

% saveFileName = 'single_bar_plot';
saveFileName = 'gamma_analysis';
saveFileType = 'png'; % pdf/png
text_or_not = true; % true/false

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 400]);

% gamma��0-0.27 ��0.1����11λ
%% ��ȡxlsx�������ṹ��
% lr	gamma	fintl	UAV123_10fps_Prec.	UAV123_10fps_Succ.
C = readcell('res_record_gamma.xlsx');
plot_length = 16; % ѡ������
gamma = cell2mat(C(2:plot_length+1,2));
prec = cell2mat(C(2:plot_length+1,4));
succ = cell2mat(C(2:plot_length+1,5));

% ��ѡָ��
param = prec; % prec/succ
peak_idx = 11;
normal_faceColor = [0 0.45 0.74];
peak_faceColor = [0.85 0.33 0.10];
barWidth = 0.6;

%% ��ʽ��ͼ
% �������εĿ������Ϊ�����ο����ܿռ�� 60%��
for i = 1:plot_length
    % ԭ��ʹ��bar(y)��ʽ
    % b=bar(param, barWidth);
    % ��ʹ��bar(x,y)��ʽ
    if i == peak_idx
        bar(i, param(i), 'BarWidth', barWidth, 'FaceColor', peak_faceColor);
    else
        bar(i, param(i), 'BarWidth', barWidth, 'FaceColor', normal_faceColor);
    end
    hold on
end

%% ��������
% �Ƿ�grid
% set(gca,'Xgrid','on'); % ��������
set(gca,'Ygrid','on'); % ���ֺ���

fontSize = 14;
tickFontSize = 12;
textFontSize = 9;
%����x�᷶Χ�Ϳ̶�
set(gca,'XLim',[0.2, plot_length+0.8]);%X���������ʾ��Χ
set(gca,'XTick',[1:plot_length]);%����Ҫ��ʾ����̶�
set(gca,'XTickLabel',num2str(gamma,'%.2f'));
% set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
% set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
xLabelName1 = '\it{\gamma}';

%����y�᷶Χ�Ϳ̶�
if param == succ
    % succ [0.4768 0.4904] 0.475/0.465 0.491
    set(gca,'YLim',[0.475 0.491]);%X���������ʾ��Χ
    set(gca,'YTick',[0.475:0.005:0.490]);%����Ҫ��ʾ����̶�
    % set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    yLabelName1 = 'Success rate';
elseif param == prec
    % prec [0.6606 0.6863] 0.660/0.655 0.689
    set(gca,'YLim',[0.655 0.689]);%X���������ʾ��Χ
    set(gca,'YTick',[0.655:0.005:0.690]);%����Ҫ��ʾ����̶�
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    % set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ
    yLabelName1 = 'Precision';
end

% Times ����
set(gca,'FontName','Times New Roman','fontSize',tickFontSize); % ����������ֵ����
xlabel(xLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
% Ĭ���޳�������
% set(gca,'fontSize',fontSize); % ����������ֵ����
% xlabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������

% ���ñ�ǩ������λ��
% legend('UAVDT','UAV123@10fps','Location','northwest');

% �ֶ�����������ֱ�ǩ
% 'HorizontalAlignment' - �����λ�õ�ˮƽ�����ı�
% 'left' ��Ĭ�ϣ� | 'center' | 'right'
if text_or_not
    if param == succ
        verticalOffset = 0.0005;
    elseif param == prec
        verticalOffset = 0.0009;
    end
    for i = 1 : size(param, 1)
        if i == peak_idx
            text(i, param(i) + verticalOffset, num2str(param(i),'%.4f'),...
                'fontname','Times New Roman','fontweight','bold','fontSize',textFontSize,'HorizontalAlignment','center');
        else
            text(i, param(i) + verticalOffset, num2str(param(i),'%.4f'),...
                'fontname','Times New Roman','fontSize',textFontSize,'HorizontalAlignment','center');
        end
    end
end

tightfig;

if param == succ
    saveFileName = [saveFileName '_succ'];
elseif param == prec
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