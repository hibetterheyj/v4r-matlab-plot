%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ����
% ���tightfig
addpath('../');

% ͼ��
figure4D = figure(40);
set(figure4D,'position',[0 0 800 450]);

% ����
y=[0.389 0.374;0.432 0.421; 0.425 0.407; 0.423 0.398; 0.437 0.456;];
% �������εĿ������Ϊ�����ο����ܿռ�� 80%��
b=bar(y, 0.8);
grid on;

%����x�᷶Χ�Ϳ̶�
set(gca,'TickLabelInterpreter','latex'); % ���ý�����Ϊlatex
set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
% set(gca,'XTick',[0:1:10]);%����Ҫ��ʾ����̶�
% set(gca,'XTickLabel',[0:1:10]);%������ӱ�ǩ 
% xlabel('')
%����y�᷶Χ�Ϳ̶�
set(gca,'YLim',[0.35, 0.48]);%X���������ʾ��Χ
% set(gca,'YTick',[95:1:101]);%����Ҫ��ʾ����̶�
% set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ 
yLabelName1 = 'Success Rate';
% ���ñ�ǩ������λ��
legend('UAVDT','UAV123@10fps','Location','northwest');

fontSize = 13;
% Times ����
ylabel(yLabelName1,'fontsize',fontSize,'fontname','Times New Roman','fontweight','bold'); % ��������
set(gca,'FontName','Times New Roman','fontSize',fontSize); % ����������ֵ����
% Ĭ���޳�������
% ylabel(yLabelName1,'fontsize',fontSize,'fontweight','bold'); % ��������
% set(gca,'fontSize',fontSize); % ����������ֵ����

tightfig;

% �������
% saveas(gcf,'example.pdf'); % pdf
saveas(gcf,'example','png'); % png