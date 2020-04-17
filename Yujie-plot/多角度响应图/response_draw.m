% Ŀ�ģ�����'response.mat')��Ȼ����Ʋ�ͬ�Ƕ���Ӧͼ
%% �ο���
% 1. . matlab - surf
% https://ww2.mathworks.cn/help/matlab/ref/surf.html

%% ����
% ���tightfig
addpath('../');

% ����
% ���ӣ�TACF_group1_1_res415 KCC_group1_1_res415
name = 'KCC_group1_1_res415'; 
load([name '.mat']);

% FaceAlphaΪ͸���ȣ���ֵԽСԽ͸��
S = surf(response,'FaceAlpha',0.9);
% ������
% S.EdgeColor = 'none'; % ��
% S.EdgeColor = [1 1 1]; % ��ɫ
S.EdgeColor = [0.18 0.36 0.56];

% ��ȫ����
az = 0;
el = 90;
% ��ת�븩��
% az = 45; % Z����ת��
% el = 30; % ���ӽ�
view(az, el);
tightfig;
% S.EdgeColor = 'none';
axis off
% axis equal

% �������ͬ��ͼƬ
% saveas(gcf,'example.pdf'); % pdf
saveas(gcf,[name '_����'],'png'); % png