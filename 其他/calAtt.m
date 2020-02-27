%% �ο�
% 1. writematrix (2019a)
% https://ww2.mathworks.cn/help/matlab/ref/writematrix.html
% 2. writematrix (2019a)
% https://ww2.mathworks.cn/help/matlab/ref/writetable.html

%% �ļ��нṹ
% ..
% .
% anno/
% scaledata/
% calScale.m
% calAtt.m
% ���������������Ҫ�� scaledata/ ��ԭ���ļ�ɾ��

%% ����
clc;clear;close all;
% UAV20L UAV123 UAV123_10fps UAVDT DTB70
dataset = 'DTB70';

% ����ļ���
attFolder = ['./anno/' dataset '/att/'];
annoFolder = ['./anno/' dataset '/'];
xlsxFolder = './datasetAttTable/';

% ��ȡ��namelist �ĸ�ʽΪ
% name -- filename
% date -- modification date
% bytes -- number of bytes allocated to the file
% isdir -- 1 if name is a directory and 0 if not
namelist = dir([attFolder '*.txt']);
len = length(namelist);
dataset_num = cell(len,1);
for i = 1:len
    dataset_num{i,1}=namelist(i).name;
    dataSeq{i,1} = dataset_num{i,1}(1:end-4);
end

%% ���ݼ�ָ��

% ���ݼ���Ӧָ��
switch dataset
    case {'UAV123_10fps', 'UAV123', 'UAV20L'}
        attName = {'Aspect ratio change','Background clutter','Camera motion','Fast motion','Full occlusion','Illumination variation','Low resolution','Out-of-view','Partial occlusion','Scale variation','Similar object','Viewpoint change'};
        attName_abbr = {'ARC','BC','CM','FM','FOC','IV','LR','OV','POC','SV','SOB','VC'}; % �б���д
        attNum = 12;
    case 'UAVDT'
        attName = {'Background clutter','Camera motion','Illumination variations','Large occlusion','Long-term tracking','Object blur','Object motion','Scale variations','Small object'};
        attName_abbr = {'BC','CM','IV','LO','LTT','OB','OM','SV','SO'}; % �б���д
        attNum = 9;
    case 'DTB70'
        attName = {'Scale variation','Aspect ratio variation','Occlusion','Deformation','Fast camera motion','In-plane rotation','Out-of-plane rotation','Out-of-view','Background clutter','Similar objects around','Motion blur'};
        attName_abbr = {'ARV','BC','DEF','FCM','IPR','MB','OCC','OPR','OV','SV','SOA'}; % �б���д
        attNum = 11;
end

% ������������
attMatrix = zeros(len, attNum);
frameNum = zeros(len, 1);
for i = 1:len
    % ��TXT�ĵ�load��matlab�Ĺ���������
    att=load([attFolder dataset_num{i}]);
    % Ҳ����ȡָ�����к���
    attMatrix(i,:) = att(1,:);%��ȡ�����У��Լ�2-3��
    % ����ÿ�����еĳ���
    gt =load([annoFolder dataset_num{i}]);
    frameNum(i) = size(gt,1);
end
fileName = [dataset '_att.xlsx'];
% д�����
% writematrix(attMatrix,fileName);
% д����
% ���̧ͷ
% dataSeq   frameNum <ָ����д>
% ���ݼ�     ֡��     <ָ��ȫ��>
T1 = table(dataSeq, frameNum);writetable(T1, [xlsxFolder fileName], 'Range','A1');
% corner [char('A'+1) '1']
for j = 1:attNum
    T = table(attMatrix(:,j));
    T.Properties.VariableNames = {attName_abbr{j}};
    writetable(T, [xlsxFolder fileName], 'Range',[char('B'+j) '1']);
end

disp('End !')