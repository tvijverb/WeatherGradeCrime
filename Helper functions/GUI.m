function [] = GUI()
% Demonstrate how to save and load the state of a GUI system.
% Creates a GUI which allows the user to plot one of four types of
% polynomials.  When the pushbutton is pressed, a new GUI is created which
% displays the coefficients used to create the polynomial, and another
% figure is made which plots the polynomial over a simple range.  The main
% GUI has two menus which allow the user to save the state of the system
% and load the state of the system.
%
% Suggested exercise:  Modify the code so that the coefficients in the 
% second GUI can be user defined.  You will have to ensure that the
% radiobutton in the first GUI accurately reflects the user's choice, and
% the plot gets updated after the edit.
%
%
% Author:  Matt Fig
% Date: 7/30/09
S.Webometrics = load('Webometrics');
S.X = -10:.01:10;  % The X values for plotting.
S.L{3} = 65;
S.P = 1;
S.fh = figure('units','pixels',...
              'position',[50 50 1000 600],...
              'menubar','none',...
              'name','Weather Grade Crime',...
              'numbertitle','off',...
              'resize','off',...
              'closerequestfcn',{@fh_crfcn});
set (S.fh, 'Color', [0.3 1 0.6] )

%% Text
S.tx2 = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[10 450 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string','Webometrics Rank influence:');
S.tx3 = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[10 300 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string','Temperature Rank influence:');
          
S.tx4 = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[10 150 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string','Temperature Deviation Rank influence:');
S.tx5 = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[50 210 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string',{'Ideal temperature: 65'});
          
          
%% Select dataset dropdown
S.tx = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[10 570 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string','Select Dataset');
S.pp = uicontrol('style','pop',...
                 'unit','pix',...
                 'position',[25 530 280 20],...
                 'backgroundc',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string',{'Webometrics & NOAA NCEI'},'value',1);          
set(S.pp,'callback',{@pp_call,S});  % Set the callback.

%% Select Region dropdown
S.tx6 = uicontrol('style','tex',...
                 'unit','pix',...
                 'position',[300 570 280 20],...
                 'backgroundcolor',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string','Select Region');
S.pp2 = uicontrol('style','pop',...
                 'unit','pix',...
                 'position',[320 530 280 20],...
                 'backgroundc',get(S.fh,'color'),...
                 'fontsize',12,'fontweight','bold',... 
                 'string',{'All Regions','Europe','North America','South America','Asia'},'value',1);          
set(S.pp2,'callback',{@pp_call2,S});  % Set the callback.   

%% Select 4-box Webometrics RANK              
S.bg = uibuttongroup('units','pix',...
                     'pos',[350 410 210 90]);
S.rd(1) = uicontrol(S.bg,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 50 70 30],...
                    'string','None');
S.SEL = 1;  % The selectedobject property of S.bg
S.rd(2) = uicontrol(S.bg,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 10 70 30],...
                    'string','Slightly');
S.rd(3) = uicontrol(S.bg,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 50 70 30],...
                    'string','Standard');
S.rd(4) = uicontrol(S.bg,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 10 70 30],...
                    'string','High'); 
                
%% Select 4-box Webometrics 2 TEMPERATURE             
S.bg2 = uibuttongroup('units','pix',...
                     'pos',[350 260 210 90]);
S.rd2(1) = uicontrol(S.bg2,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 50 70 30],...
                    'string','None');
S.SEL = 1;  % The selectedobject property of S.bg
S.rd2(2) = uicontrol(S.bg2,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 10 70 30],...
                    'string','Slightly');
S.rd2(3) = uicontrol(S.bg2,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 50 70 30],...
                    'string','Standard');
S.rd2(4) = uicontrol(S.bg2,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 10 70 30],...
                    'string','High'); 

%% Select 4-box Webometrics 3  TEMPERATURE DEVIATION           
S.bg3 = uibuttongroup('units','pix',...
                     'pos',[350 110 210 90]);
S.rd3(1) = uicontrol(S.bg3,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 50 70 30],...
                    'string','None');
S.SEL = 1;  % The selectedobject property of S.bg
S.rd3(2) = uicontrol(S.bg3,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[20 10 70 30],...
                    'string','Slightly');
S.rd3(3) = uicontrol(S.bg3,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 50 70 30],...
                    'string','Standard');
S.rd3(4) = uicontrol(S.bg3,...
                    'style','rad',...
                    'unit','pix',...
                    'position',[120 10 70 30],...
                    'string','High'); 
                
%% Final Push button
S.pb = uicontrol('style','push',...
                 'unit','pix',...
                 'position',[150 20 100 30],...
                 'string','GET GOODIES',...
                 'callback',{@pb_call,S,S.Webometrics});   

%% Slider
S.sl = uicontrol('style','slide',...
                 'unit','pix',...
                 'position',[110 250 150 40],...
                 'min',40,'max',80,'val',65,...
                 'SliderStep',[1/7 1/7]); 
set(S.sl,'call',{@sl_call,S});  % Shared Callback.
S.ax = axes('units','pix','pos',[110 250 150 40]);  
set(S.ax, 'YTick', [], 'XTickLabel',{'40', '60', '80'})

%% Callback Functions
    function [] = sl_call(varargin)
        % Callback for the slider.
S.L = get(S.sl,{'min','max','value'});  % Get the slider's info.
set(S.tx5,'string',strcat('Ideal temperature: ',num2str(S.L{3})));
    end

    function [] = pb_call(varargin)
    % Callback for the pushbutton.
%    S = varargin{3};  % Get the structure.
      %Button group 1
        switch findobj(get(S.bg,'selectedobject'))
            case S.rd(1) % None
                    S.RANK = zeros(500,1)';
            case S.rd(2)  % Slightly
               for i = 2:501
                    S.RANK(i-1) = vertcat(varargin{1,4}.Webometrics(i,1).WORLDRANK)*0.5;
               end
            case S.rd(3)  % Medium
               for i = 2:501
                    S.RANK(i-1) = vertcat(varargin{1,4}.Webometrics(i,1).WORLDRANK);
               end
            case S.rd(4)  % Heavy
               for i = 2:501
                    S.RANK(i-1) = vertcat(varargin{1,4}.Webometrics(i,1).WORLDRANK)*1.2;
               end
            otherwise
                % Very unlikely I think.
        end 
      %Button group 2   
        switch findobj(get(S.bg2,'selectedobject'))
            case S.rd2(1) % None
                S.TEMPSCORE = zeros(500,1)';
            case S.rd2(2)  % Slightly
               for i = 2:501
                    S.TEMPSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,14).AvgTempF-S.L{3})*2;
               end
            case S.rd2(3)  % Medium
                for i = 2:501
                    S.TEMPSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,14).AvgTempF-S.L{3})*5;
               end
            case S.rd2(4)  % Heavy
                for i = 2:501
                    S.TEMPSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,14).AvgTempF-S.L{3})*10;
               end
            otherwise
                % Very unlikely I think.
        end 
      %Button group 3   
         switch findobj(get(S.bg3,'selectedobject'))
            case S.rd3(1) % None
                S.TEMPDEVSCORE = zeros(500,1)';
            case S.rd3(2)  % Slightly
                for i = 2:501
                    S.TEMPDEVSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,15).StdvF)*2;
               end
            case S.rd3(3)  % Medium
                for i = 2:501
                    S.TEMPDEVSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,15).StdvF)*5;
               end
            case S.rd3(4)  % Heavy
                for i = 2:501
                    S.TEMPDEVSCORE(i-1) = abs(varargin{1,4}.Webometrics(i,15).StdvF)*10;
               end
            otherwise
                % Very unlikely I think.
         end 
         
         %Create the ranking
         S.SCORE = S.RANK + S.TEMPSCORE + S.TEMPDEVSCORE;
         
         % Create the column and row names in cell arrays 
         cnames = {'University','Score'};
         rnames = {'First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Ninth','Tenth'};
         
         

         
         if S.P == 1
             S.reg_ind = ones(501,1);
         elseif S.P == 2
             S.reg_ind = ismember(varargin{1,4}.Webometrics(:,5).REGION,'EU');
         elseif S.P == 3
             S.reg_ind = ismember(varargin{1,4}.Webometrics(:,5).REGION,'NA');
         elseif S.P == 4
             S.reg_ind = ismember(varargin{1,4}.Webometrics(:,5).REGION,'IBC');
         elseif S.P == 5
             S.reg_ind = ismember(varargin{1,4}.Webometrics(:,5).REGION,'AS');
         end
         
         S.reg_ind_n = unique((1:501)' .* S.reg_ind);
         
         [~,S.ind] = sort(S.SCORE);
         S.ind = S.ind + 1;
         S.ind = S.ind(ismember(S.ind,S.reg_ind_n));
         
%         f = figure('Position', [100 100 752 250]);
         if length(S.ind) <10
            t = uitable('Position', [600 300 400 202], 'Data', vertcat(varargin{1,4}.Webometrics(S.ind,2).NAME),'ColumnName', cnames, 'RowName', rnames, 'ColumnWidth', {230,74}); 
         else
            t = uitable('Position', [600 300 400 202], 'Data', vertcat(varargin{1,4}.Webometrics(S.ind(1:10),2).NAME),'ColumnName', cnames, 'RowName', rnames, 'ColumnWidth', {230,74});
         end
     end


function [Webometrics] = pp_call(varargin)
% Callback for popupmenu.
S = varargin{3};  % Get the structure.
P = get(S.pp,'val'); % Get the users choice from the popup.
if( P == 1)
     load('Webometrics.mat');
end
set(S.pp,'callback',{@pp_call,S});  % Save the new count.
end

function [] = pp_call2(varargin)
% Callback for popupmenu.
S.P = get(S.pp2,'val'); % Get the users choice from the popup.
set(S.pp2,'callback',{@pp_call2,S});  % Save the new count.
end


    function [] = fh_crfcn(varargin)
    % Closerequestfcn for figures.
       delete(S.fh) % Delete all figures stored in structure. 
    end
end
             