%% �ο���
% 1. matlab����״ͼ
% https://blog.csdn.net/it_beecoder/article/details/80168242

%% ���ģ�
data = [20.457, 45.578; 12.016, 22.422];
b = bar(data);
ch = get(b,'children');
set(gca,'XTickLabel',{'ѵ������','���Թ���'})
legend('�������ĵ������ķ����㷨','���bigram�����ĵ����������㷨');
ylabel('����ʱ��(��λ:��)');