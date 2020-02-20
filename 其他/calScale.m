% �ļ��нṹ
% ..
% .
% anno/
% scaledata/
% calScale.m

% ��ȡ��namelist �ĸ�ʽΪ
% name -- filename
% date -- modification date
% bytes -- number of bytes allocated to the file
% isdir -- 1 if name is a directory and 0 if not
clc;clear;close all;
% DTB70 UAV20L UAV123 UAV123_10fps UAVDT
datasetName = 'UAV123_10fps';
% folder = ['./' datasetName '/'];
annoFolder = ['./anno/' datasetName '/'];
resultFolder = ['./scaledata/' datasetName '/'];
namelist = dir([annoFolder '*.txt']);
len = length(namelist);
for i = 1:len
    file_name{i}=namelist(i).name;
end

%% �ߴ�仯���ӻ�
vis = 0; % �Ƿ���ӻ�
visNum = 2; % ���ӻ�N������
if vis
    for i = 1:visNum
        read_data = dlmread([annoFolder file_name{i}]);
        seqLen = max(size(read_data));
        % beforeScale = read_data(1:len-1,3:4);
        % ��ʼ����
        ratio0 = read_data(1,4) / read_data(1,3);
        beforeScale = read_data(1,3:4);
        beforeScale = repmat(beforeScale,seqLen-1,1);
        afterScale = read_data(2:seqLen,3:4);
        scaleChange = afterScale ./ beforeScale;
        [m,n]=find(isnan(scaleChange)==1);
        scaleChange(m,:)=[];
        figure(100+i);
        scatter(scaleChange(:,1), scaleChange(:,2));
        axis equal
        title([file_name{i}(1:end-4) ' height/width: ' num2str(ratio0)]);
        hold on
        minX = min(scaleChange(:,1));
        maxX = max(scaleChange(:,1));
        x = minX:0.01:maxX;
        y = x;
        plot(x, y);
    end
end

%% �ߴ�仯���ӻ�����������
visStep = 0; % �Ƿ���ӻ�
visStepNum = 1; % ���ӻ�N������
stepSize = 1.02; % ����
% log1.02(8)=log10(8)/log10(1.02)
if visStep
    for i = 1:visStepNum
        read_data = dlmread([annoFolder file_name{i}]);
        seqLen = max(size(read_data));
        % beforeScale = read_data(1:len-1,3:4);
        % ��ʼ����
        ratio0 = read_data(1,4) / read_data(1,3);
        beforeScale = read_data(1,3:4);
        beforeScale = repmat(beforeScale,seqLen-1,1);
        afterScale = read_data(2:seqLen,3:4);
        scaleChange = afterScale ./ beforeScale;
        [m,n]=find(isnan(scaleChange)==1);
        scaleChange(m,:)=[];
        logscaleChange = log10(scaleChange)/log10(stepSize);
        figure(200+i);
        scatter(logscaleChange(:,1), logscaleChange(:,2));
        axis equal
        title([file_name{i}(1:end-4) ' height/width: ' num2str(ratio0)]);
%         hold on
%         minX = min(scaleChange(:,1));
%         maxX = max(scaleChange(:,1));
%         x = minX:0.01:maxX;
%         y = x;
%         plot(x, y);
    end
end

%% ͳ��h>w�����
calFrame = 0; % �Ƿ���㲢���
calNum = len; % д�� len
table_name = [datasetName '_scale_data.xlsx'];
txt_name = [datasetName '_scale_data.txt'];
if calFrame
    for i = 1:calNum
        read_data = dlmread([annoFolder file_name{i}]);
        seqLen = max(size(read_data));
        % ����һ֡�Ƚ�
        % beforeScale = read_data(1:len-1,3:4); 
        % ���һ֡�Ƚ�
        beforeScale = read_data(1,3:4);
        beforeScale = repmat(beforeScale,seqLen-1,1);
        afterScale = read_data(2:seqLen,3:4);
        scaleChange = afterScale ./ beforeScale;
        [m,n]=find(isnan(scaleChange)==1);
        scaleChange(m,:)=[];
        % w��h���֡��
        wFrame = sum(scaleChange(:,1) > scaleChange(:,2), 1);
        % h��w���֡��
        hFrame = sum(scaleChange(:,1) < scaleChange(:,2), 1);
        % һ�����֡��
        eFrame = sum(scaleChange(:,1) == scaleChange(:,2), 1);
        % NaN֡�� = (��֡��-1) - w��h���֡�� - h��w���֡�� - һ�����֡��
        nanFrame = seqLen - 1 - wFrame - hFrame - eFrame; % ��һ֡������
        % ������
        seqName = file_name{i}(1:end-4);
        % ��ʼ����
        ratio0 = read_data(1,4) / read_data(1,3);
        % wFrame >= hFrame
        % maxW
        % minW
        % maxH
        % minH
        % TO DO ������������
        write_data = [seqName ',' num2str(wFrame) ',' num2str(hFrame) ',' ...
            num2str(eFrame) ',' num2str(nanFrame) ',' num2str(ratio0)];
        % �����ļ�������ж�
        if exist(resultFolder)==0 %���ļ��в����ڣ���ֱ�Ӵ���
            mkdir(resultFolder);
        else %���ļ��д��ڣ�����ɾ���ٴ���
            rmdir(resultFolder, 's'); %���ļ�������û���ļ�����
            mkdir(resultFolder);
        end
        fid=fopen([resultFolder txt_name],'a'); % validation training
        fprintf(fid,'%s\n',write_data);
        fclose(fid);
    end
    dt=importdata([resultFolder txt_name]); 
    T=table(dt.rowheaders,dt.data(:,1),dt.data(:,2),...
        dt.data(:,3),dt.data(:,4),dt.data(:,5));
    T.Properties.VariableNames = {'Seq','wbigger','hbigger','whequal','nan','initial_ratio'};
    writetable(T,[resultFolder table_name]);
end

%% ����߶ȱ仯����
