
group1 = getNewsGroup("sozcu");
group2 = getNewsGroup("sabah");
test = calculateVector(fileread("news\hurriyet.txt"));
euclidean_distance_to_news_group1 = calculateEuclid(group1, test)
euclidean_distance_to_news_group2 = calculateEuclid(group2, test)

mahalanobis_distance_to_news_group1 = calculateMahal(group1, test)
mahalanobis_distance_to_news_group2 = calculateMahal(group2, test)


function euclid = calculateEuclid(news_matrix, test)
    %test örneðinin gruba euclid uzaklýðýný hesaplamak için
    %grubun her bir elemanýnýn test örneðine uzaklýklarý hesaplanýp
    %ortalamasý alýnmýþtýr. 
    distances = zeros(10,1);
    for i = 1:size(news_matrix,1)
        distances(i) = sqrt(sum((news_matrix(i,:)- test) .^2));
    end
    euclid = mean(distances);
end

function mahalanobis = calculateMahal(news_matrix, test)
    covX = cov(news_matrix);
    mu = mean(news_matrix,1);
    inX = inv(covX);
    mahalanobis = sqrt((test - mu) * inX * (test-mu)');
end

function group_matrix = getNewsGroup(news)
    group_matrix = [];
    for i=1:10
        news_text = fileread("news\" + string(news) + i + ".txt");
        news_matrix = calculateVector(news_text);
        group_matrix = [group_matrix;news_matrix];
    end
end

function result_vector = calculateVector(text)
    text = char(text);
    %kelime bigram/trigramlarýnda kullanýlmak üzere basit metin temizleme yapýldý.
    %kelime sayýsý, ortalama harf sayýsýnda da temizlenmiþ metin kullanýldý.
    %ltext = temizlenmiþ metin
    ltext = lower(text);
    ltext = erasePunctuation(ltext);
    words = string(split(ltext, ' '));
    word_count = length(words);
    avg_letter_count = mean(strlength(words));
    uppercase_count = sum(isstrprop(text, "upper"));
    lovercase_count = sum(isstrprop(text, "lower"));
    digit_count = sum(isstrprop(text, "digit"));
    punctuation_count = sum(isstrprop(text, "punct"));
    special_count = getSpecialCharCount(text);
    char_uppercase_bigrams = getBiGramCount(text, 'upper');
    char_lowercase_bigrams = getBiGramCount(text, 'lower');
    char_uppercase_trigrams = getTriGramCount(text, 'upper');
    char_digit_bigrams = getBiGramCount(text, 'digit');
    char_digit_trigrams = getTriGramCount(text, 'digit');
    char_lowercase_trigrams = getTriGramCount(text, 'lower');
    word_bigrams = getWordBiGram(words);
    word_trigram = getWordTriGram(words);
    result_vector = [word_count avg_letter_count uppercase_count lovercase_count digit_count punctuation_count special_count char_uppercase_bigrams char_lowercase_bigrams char_uppercase_trigrams char_digit_bigrams char_digit_trigrams char_lowercase_trigrams word_bigrams word_trigram];
end
    
function c_spec = getSpecialCharCount(text)
    text = text(isstrprop(text, 'alpha'));%sadece letters içerisinde özel karakter arasýn..
    d_text = double(text);
    c_spec = sum(d_text>191); %UNICODE'da 192ve yukarýsý özel karakterler olduðundan..
end

function char_BG = getBiGramCount(text,  category)
    char_BG =0;
    for i=1:length(text)-1
        if isstrprop(text(i), category)==1
            if text(i) == text(i+1)
                char_BG = char_BG +1;
            end
        end
    end
end

function char_TRG = getTriGramCount(text, category)
    char_TRG = 0;
    for i = 2 : length(text)-2
        if isstrprop(text(i), category)==1
            if text(i-1) ==text(i) && text(i+1) ==text(i)
                char_TRG = char_TRG +1;
            end
        end
    end
end

function word_BG = getWordBiGram(word_vector)
    word_BG = 0;
    for i = 1: length(word_vector)-1
        if word_vector(i) == word_vector(i+1)
            word_BG = word_BG +1;
        end
    end
end

function word_TRG = getWordTriGram(word_vector)
    word_TRG = 0;
    for i = 2: length(word_vector)-2
        if word_vector(i) == word_vector(i+1) && word_vector(i) == word_vector(i-1)
            word_TRG = word_TRG +1;
        end
    end
end

function new_text = erasePunctuation(ltext)
    ltext = replace(ltext,',',' ');
    ltext = replace(ltext,'.',' ');
    ltext = replace(ltext,'?',' ');
    ltext = replace(ltext,'!',' ');
    ltext = replace(ltext,'''',' ');
    ltext = replace(ltext,'-',' ');
    ltext = replace(ltext,')',' ');
    ltext = replace(ltext,'(',' ');
    ltext = replace(ltext,';',' ');
    ltext = replace(ltext,':',' ');
    ltext = replace(ltext,'’',' ');
    ltext = regexprep(ltext, '\s+',' ');
    ltext = replace(ltext,'   ',' ');
    ltext = replace(ltext,'  ',' ');
    new_text = ltext;
end


