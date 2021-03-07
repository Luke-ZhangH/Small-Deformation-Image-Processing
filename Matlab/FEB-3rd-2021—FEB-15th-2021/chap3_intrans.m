%% 对数变换函数：压缩图像的动态范围
function g = chap3_intrans(f, varargin)
%provided 'neg', 'log', 'gamma', 'stretch' methods to process the input
%pics.
    narginchk(2, 4)
    classin = class(f);
    if strcmp(class(f), 'double') && max(f(:)) > 1 && strcmp(varargin{1}, 'log')
        f = mat2gray(f);
    else 
        f = im2double(f);
    end
    method = varargin{1};
    switch method
        case 'neg'
            g = imcomplement(f);
        case 'log'
            if length(varargin) == 1
                c = 1;
            elseif length(varargin) == 2
                c = varargin{2};
            elseif length(varargin) == 3
                c = varargin{2};
                classin = varargin{3};
            else 
                error('Incorrect number f inputs for the log option.')
            end
            g = c*(log(1 + double(f)));
        case 'gamma'
            if length(varargin) < 2
                error('Not enough inputs for the gamma option.')
            end
            gam = varargin{2};
            g = imadjust(f, [], [], gam);
        case 'stretch'
            if length(varargin) == 1
                m = mean2(f);
                E = 4.0;
            elseif length(varargin) == 3
                m = varargin{2};
                E = varargin{3};
            else error('Incorrect number of inputs for the stretch option.')
            end 
            g = 1./(1 + m./(f)).^E;
        otherwise 
            error('Unknown enhancement method.')
    end
    %g = changeclass(classin, g);
end 