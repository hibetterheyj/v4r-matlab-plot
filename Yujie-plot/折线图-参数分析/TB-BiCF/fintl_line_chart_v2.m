%% 参考：
% 1. matlab画柱状图
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% 说明
% 用于参数分析的折线图v2
% - 可以直接读入excel文件（TODO）

%% 正文
clear;clc;close all;
% 添加tightfig
addpath('../');

% saveFileName = 'horizontal_line_chart';
saveFileName = 'fintl_analysis';
saveFileType = 'png'; % pdf/png
% text_or_not = true; % true/false

%% 数据
% 手动输入
% 读取xlsx，res_record_gamma.xlsx基本结构：
% lr	gamma	fintl	UAV123_10fps_Prec.	UAV123_10fps_Succ.
C = readcell('../res_record_fintl.xlsx');
start = 5; plot_length = 8; % 选择数量
fintl = cell2mat(C(start:start+plot_length-1,3));
prec = cell2mat(C(start:start+plot_length-1,4));
succ = cell2mat(C(start:start+plot_length-1,5));

% 所选指标
x_param = fintl;
y_param = prec; % prec/succ

% 最高点
peak_prec = 8;
peak_succ = 8;
peak_vline_color = [217, 83, 25]/255;

%% 正式画图
figureHCL = figure(301);
set(figureHCL,'position',[0 0 700 160]);
lineWidth = 2.5; % 画线的线粗
fontSize = 14;
tickFontSize = 12;
h1=plot(x_param, y_param(1:end), 'o-',...
    'Color',[0,0.4,0.74],...
    'LineWidth',lineWidth,...
    'MarkerSize',8,...
    'MarkerEdgeColor',[0,0.45,0.74]); % [0,0.45,0.74]
...'MarkerFaceColor',[0.5,0.5,0.5]
    

%设置x轴范围和刻度
set(gca,'XLim',[min(x_param), max(x_param)]);%X轴的数据显示范围
% set(gca,'XTick',[1:plot_length]);%设置要显示坐标刻度
% set(gca,'XTickLabel',num2str(x_param,'%.2f'));
% set(gca,'TickLabelInterpreter','latex'); % 设置解析器为latex
% set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
xLabelName1 = '{\Delta}\it{k}';

%设置y轴范围和刻度
if y_param == succ
    % succ [0.4768 0.4904] 0.475/0.465 0.491
    set(gca,'YLim',[0.478 0.492]);%X轴的数据显示范围
%     set(gca,'YTick',[0.475:0.005:0.490]);%设置要显示坐标刻度
    % set(gca,'YTickLabel',[95:1:101]);%给坐标加标签
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    yLabelName1 = 'Success rate';
    hold on
    plot([peak_succ peak_succ], [0 max(succ(:))],'--','Color',peak_vline_color, 'LineWidth', lineWidth);
elseif y_param == prec
    % prec [0.6606 0.6863] 0.660/0.655 0.689
    set(gca,'YLim',[0.665 0.688]);%X轴的数据显示范围
%     set(gca,'YTick',[0.655:0.005:0.690]);%设置要显示坐标刻度
    set(gca,'YTickLabel',num2str(get(gca,'YTick')','%.3f'))
    % set(gca,'YTickLabel',[95:1:101]);%给坐标加标签
    yLabelName1 = 'Precision';
    hold on
    plot([peak_prec peak_prec], [0 max(prec(:))],'--','Color',peak_vline_color, 'LineWidth', lineWidth);
end

% Times 字体
set(gca,'FontName','Times New Roman','fontSize',tickFontSize); % 设置坐标轴值字体
xlabel(xLabelName1,'fontsize',fontSize,'fontname','Times New Roman'); % 纵轴名称
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % 纵轴名称
% 默认无衬线字体
% set(gca,'fontSize',fontSize); % 设置坐标轴值字体
% xlabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % 纵轴名称
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % 纵轴名称


% 是否grid
set(gca,'Xgrid','on'); % 出现竖线
set(gca,'Ygrid','on'); % 出现横线
set(gca,'box','on')

tightfig;

if y_param == succ
    saveFileName = [saveFileName '_succ'];
elseif y_param == prec
    saveFileName = [saveFileName '_prec'];
end

% 输出保存
switch saveFileType
    case 'pdf'
        saveas(gcf,[saveFileName '.pdf']); % pdf
    case 'png'
        saveas(gcf,saveFileName,'png'); % png
    otherwise
        disp('Type error !')
end