%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242
% 2. matlab - legend
% https://ww2.mathworks.cn/help/matlab/ref/legend.html

%% ����
y=[0.389 0.374;0.432 0.421; 0.425 0.407; 0.423 0.398; 0.437 0.456;];
b=bar(y);
grid on;

%����x�᷶Χ�Ϳ̶�
set(gca,'XTickLabel',{'KCC','TACF1','TACF2','TACF3','\textbf{TACF}'})
% set(gca,'XTick',[0:1:10]);%����Ҫ��ʾ����̶�
% set(gca,'XTickLabel',[0:1:10]);%������ӱ�ǩ 
% xlabel('')
%����y�᷶Χ�Ϳ̶�
set(gca,'YLim',[0.35, 0.50]);%X���������ʾ��Χ
% set(gca,'YTick',[95:1:101]);%����Ҫ��ʾ����̶�
% set(gca,'YTickLabel',[95:1:101]);%������ӱ�ǩ 
ylabel('Success Rate');
% ���ñ�ǩ������λ��
legend('UAVDT','UAV123@10fps','Location','northwest');