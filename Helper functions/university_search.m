function [hits] = university_search()
%pubmed_search Search PubMed database and write results to MATLAB structure
% 
% [pmstruct,medlineText] = pubmed_search(searchQuery,varargin);
%
%   INPUTS
%   =========================================
%   searchQuery
%
%   OPTIONAL INPUTS
%   =========================================
%
%   OUTPUTS
%   =========================================
%   pmstruct :
%   medlineText = 
%
%   See Also:
%       getpubmed  %Original function that this is based on ...
%
%   12/5/2012 - format seems to have changed ...
load('Webometrics.mat');
baseSearchURL = 'https://www.google.nl/maps/place/';
MAX_NUM_RECS = 200;

params = {...
    'cmd' 'search'
    'db'  'pubmed'
    'report' 'medline'
    'format' 'text'
    'dispmax' int2str(MAX_NUM_RECS)};
    
params = {...
    'cmd' 'search'
    'report' 'medline'
    'format' 'text'
    'dispmax' int2str(MAX_NUM_RECS)};

for i = 2:height(Webometrics)
    searchterm = Webometrics(i,2).NAME;
    
    e_params = strrep(searchterm,' ','+');
    searchURL = strcat(baseSearchURL,e_params);
    medlineText = urlread(searchURL{1,1});
       
    hits_char = regexp(medlineText,'cacheResponse(.*?]','match');
        [~,hits_integer_index] = regexp(hits_char,',');
    if length(hits_integer_index{1,1}) < 2
        disp('Google maps database has most likely been edited');
    end
        hits(i,1) = str2double(hits_char{1,1}(hits_integer_index{1,1}(1)+1:hits_integer_index{1,1}(2)-1));
        hits(i,2) = str2double(hits_char{1,1}(hits_integer_index{1,1}(2)+1:length(hits_char{1,1})-1));
        disp(['Now evaluating' searchterm]);
end

% baseline = mean(hits);
% baseline2 = repmat(baseline,length(Ctopics),1);
% basel_hits = hits-baseline2;
% 
% for i = 1:length(Ctopics)
%     slope(i,:) = polyfit(1:15,basel_hits(i,:),1);
% end
% 
% %hits = regexp(medlineText,'PMID-.*?(?=PMID|</pre>$)','match');
% 
% %hits = cellfun(@(x) html_encode_decode_amp('decode',x),hits,'un',0);
% 
% %NEED To DEAMPERSAND THE RESULTS ...
% 
% pmstruct = struct(...
%     'raw','', ...
%     'title','', ...
%     'volume','',...
%     'year','',...
%     'pages','',...
%     'authors','',...
%     'journal','',...
%     'journalAbbr','',...
%     'doi','',...
%     'PMID','',...
%     'issn_print','',...
%     'issn_link','');

%"Search Field Descriptions and Tags"
%-> http://www.ncbi.nlm.nih.gov/books/NBK3827/#pubmedhelp.Search_Field_Descrip
%http://www.nlm.nih.gov/bsd/mms/medlineelements.html
% for n = 1:numel(hits)
%     pmstruct(n).raw              = hits{n};
%     
%     temp_title = strtrim(regexp(hits{n},'(?<=TI  - ).*?(?=PG  -|AB  -)','match', 'once')); 
%     
%     pmstruct(n).title = regexprep(temp_title,'\s+',' '); %Remove multiple whitespaces ...
%     
%     
%     if ~isempty(regexpi(pmstruct(n).title,'not available'))
%        pmstruct(n).title = ''; 
%     end
%     
%     pmstruct(n).volume           = deref(regexp(hits{n},'(?:VI  - )([^\s]*)','tokens','once'),'string');
%     pmstruct(n).year             = deref(regexp(hits{n},'(?:DP  - )(\d+)','tokens','once'),'string');
%     pmstruct(n).pages            = deref(regexp(hits{n},'(?:PG  - )([^\s]+)','tokens','once'),'string');
%     pmstruct(n).authors          = regexp(hits{n},'(?<=AU  - ).*?(?=\n)','match');
%     pmstruct(n).journal          = deref(regexp(hits{n},'(?:JT  - )([^\n]*)','tokens','once'),'string');
%     pmstruct(n).journalAbbr      = deref(regexp(hits{n},'(?:TA  - )([^\n]*)','tokens','once'),'string');
%     %AID OR LID
%     %LID - 10.1002/ajmg.a.34034 [doi]
%     %AID - 10.1002/ajmg.a.34034 [doi]
%     pmstruct(n).doi              = deref(regexp(hits{n},'(?:LID - )([^\s]*)(?: \[doi)','tokens','once'),true);
%     if isempty(pmstruct(n).doi)
%         pmstruct(n).doi          = deref(regexp(hits{n},'(?:AID - )([^\s]*)(?: \[doi)','tokens','once'),true);    
%     end
%     if isempty(pmstruct(n).doi)
%         pmstruct(n).doi  = '';
%     end
%     %COULD ADD ISSUE AS WELL
%     pmstruct(n).PMID             = regexp(hits{n},'(?<=PMID- ).*?(?=\n)','match', 'once');
%     
%     %IS  - 0022-2151 (Print)
%     %IS  - 0022-2151 (Linking)
%     pmstruct(n).issn_print       = deref(regexp(hits{n},'(?:IS  - )(\d{4}-\d{4})(?: \(Print\))','tokens'),'string');
%     pmstruct(n).issn_link        = deref(regexp(hits{n},'(?:IS  - )(\d{4}-\d{4})(?: \(Linking\))','tokens'),'string');
% end