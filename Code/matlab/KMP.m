%{
function table = kmp_table(w)
    table = [-1];
    cnd = 1;
    pos = 2;

    while pos < length(w)
        pos
        cnd
        if(w(pos) == w(cnd))
            table(pos) = table(cnd);
        else
            table(pos) = cnd;
            while(cnd >= 0 && w(pos) ~= w(cnd))
                cnd = table(cnd);
            end
        end
        cnd = cnd + 1;
    end

    table(length(w)) = cnd;
end


function [p, n] = kmp(s, w)
    n = 1;
    k = 1;
    j = 1;
    p = [];
    T = kmp_table(w);
    while j < length(s)
        if(w(j) == s(j))
            j = j+1;
            k = k+1;
            if(k == length(w))
                p(n) = j - k;
                n = n+1;
                k = T(k);
            end
        else
            k = T(k);
            if(k < 0)
                j = j+1;
                k = k+1;
            end
        end
    end
end

sequence = [5, 2, 7, 9, 5, 7, 2, 3 ,6, 7, 7, 88, a];
words = [3];

%[p, n] = kmp(sequence, words);
%p
%n

kmp_table(sequence)


%}

function indices = KMP(pattern, text)
    % Preprocess pattern to create the longest prefix suffix (LPS) array
    lps = computeLPS(pattern);
    m = length(pattern);
    n = length(text);
    indices = []; % To store starting indices of matches
    
    i = 1; % Pointer for text
    j = 1; % Pointer for pattern

    while i <= n
        if pattern(j) == text(i)
            i = i + 1;
            j = j + 1;
        end

        if j > m
            indices = [indices, i - m];
            j = lps(j - 1) + 1; % Adjusted for 1-based indexing
        elseif i <= n && pattern(j) ~= text(i)
            if j > 1
                j = lps(j - 1) + 1; % Adjusted for 1-based indexing
            else
                i = i + 1;
            end
        end
    end
end

function lps = computeLPS(pattern)
    m = length(pattern);
    lps = zeros(1, m);
    j = 0; % Length of the previous longest prefix suffix

    for i = 2:m
        while j > 0 && pattern(j + 1) ~= pattern(i)
            j = lps(j); % Adjusted for 1-based indexing
        end
        if pattern(j + 1) == pattern(i)
            j = j + 1;
        end
        lps(i) = j;
    end
end
