clear; close all;

% �Ƿ񱣴�ΪPDF
save_pdf = true; % false, true

% ȷ������
metric = 'succ';

switch metric
    case 'succ'
        att_all = [...
            struct('dataset', 'UAV123@10fps', 'range', 'A21:N37'),...
            struct('dataset', 'DTB70',        'range', 'A97:M113'),...
            struct('dataset', 'UAVDT',        'range', 'A59:K75'),...
            ];
        metric_name = 'Success rate';
    case 'prec'
        
        metric_name = 'Precision';
end

% ȷ��Ҫ�ĸ�����
% ������Լ���tracker��config������, ����legend���������Լ���
trackers = configTrackers(3);
for idx_trk = 1:length(trackers)
    trk_name_cell{idx_trk} = trackers{idx_trk}.name; %#ok<SAGROW> % ��ȡ����������
    trk_namePaper_cell{idx_trk} = trackers{idx_trk}.namePaper; %#ok<SAGROW> % ��ȡ����������
end

for idx_att = 1:length(att_all)
    
    att_range = att_all(idx_att).range;
    
    % ���ر��
    sheet_name = 'att_res_summarized'; % Sheet����
    att_table = readtable('./att_table.xlsx', 'Sheet', sheet_name, 'Range', att_range, 'ReadRowNames', true);
    
    % ��ʾ��������, ��ֹ����
    useful_att_table = att_table(trk_name_cell, :) %#ok<NOPTS>
    
    % barʹ�òο�: https://ww2.mathworks.cn/matlabcentral/fileexchange/35271-matlab-plot-gallery-vertical-bar-plot
    % bar��������
    num_att = length(useful_att_table.Properties.VariableNames) - 1; % ���Ը���, ��Ҫ���һ�е�overall����
    useful_att_data = useful_att_table{:,1:num_att} %#ok<NOPTS> % �������, �б�ʾÿ��������
    % ����bar
    figure;
    att_bar = bar(1:num_att, useful_att_data', 1); % bar������Ϊ����, ÿ���������������ӦΪ������
    % ������������ʾ��Χ
    xlim = [0.4, num_att+0.6]; % ��ֹ���������״ͼ���ű�Ե
    ylim = [0, ceil(max(useful_att_data(:))*10)/10];
    axis([xlim, ylim]);
    % �������塢��С
    font_name = 'Times New Roman';
    font_size = 9;
    % ����tick���ݡ���С������
    set(gca, 'XTickLabel', useful_att_table.Properties.VariableNames(1,1:num_att),'FontSize',font_size,'FontName',font_name);
    % ����y����ʾ���
    set(gca,'yTick',0:0.1:0.6);
    % ���ñ���������������ݡ���С������
    title(['Attributes from ', att_all(idx_att).dataset, ' benchmark']);
%     xlabel('Attributes','FontSize',font_size,'FontName',font_name);
    ylabel(metric_name,'FontSize',font_size,'FontName',font_name,'FontWeight','bold');
    if idx_att == 3
    lgd = legend(trk_namePaper_cell, 'Location', 'southoutside','FontSize',font_size); % ����ͼ��, Ϊ����������
    lgd.NumColumns = 5;
    end
    % ��ʾ����
    grid on;
    % ����ͼ��С, [x,y,w,h]
    width = 1000;
    height = 128;
    x_pos = 100;
    if idx_att == 1
        y_pos = 100;
    else
        y_pos = y_pos+height*1.4;
    end
    if idx_att == 3
        height = 180;
    end
    set(gcf,'Position',[x_pos y_pos width height]);
    
    % bar����ʾ��ֵ
    % xtips1 = att_bar(1).XEndPoints;
    % ytips1 = att_bar(1).YEndPoints;
    % labels1 = string(roundn(att_bar(1).YData, -3));
    % text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom'); % ˮƽ������ֵ
    % text(xtips1,ytips1,labels1,'HorizontalAlignment','left','VerticalAlignment','middle', 'rotation',90); % ��ֱ������ֵ
    
    % ����bar��ɫ
    % 0:Ĭ����ɫ; 1:�붨�Է�������ͼһ����ɫ; 2:С����;
    % 3:����; 4:
    plotDrawStyleAll = plotSetting(3);
    % ����bar������ɫ
    att_bar(1).FaceColor = plotDrawStyleAll{1}.color;
    att_bar(2).FaceColor = plotDrawStyleAll{2}.color;
    att_bar(3).FaceColor = plotDrawStyleAll{3}.color;
    att_bar(4).FaceColor = plotDrawStyleAll{4}.color;
    att_bar(5).FaceColor = plotDrawStyleAll{5}.color;
    % ����bar����ɫ
    % 'None':�ޱ߿�; [1,1,1]:�ױ߿�; [0,0,0]:�ڱ߿�
    bar_edge_color = [0,0,0];
    att_bar(1).EdgeColor = bar_edge_color;
    att_bar(2).EdgeColor = bar_edge_color;
    att_bar(3).EdgeColor = bar_edge_color;
    att_bar(4).EdgeColor = bar_edge_color;
    att_bar(5).EdgeColor = bar_edge_color;
    
    if save_pdf
        save_name = ['./att_bar', '_', att_all(idx_att).dataset, '_', metric, '.pdf'];
        tightfig; % ȥ��ͼƬ�ױ�
        print(gcf,'-dpdf', save_name);
    end
end