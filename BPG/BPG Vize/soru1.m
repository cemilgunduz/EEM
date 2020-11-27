text = 'Sabahattin Ali (25 �uuubat 1907 - 2 2 2 Nisan 1998), T�rk yazar ve �air. Edebi ki�ili�ini toplumcu ger�ek�i bir d�zleme oturtarak ya�am�ndaki deneyimlerini okuyucusuna yans�tt� ve kendisinden sonraki cumhuriyet d�nemi T�rk edebiyat�n� etkileyen bir fig�r h�line geldi. Daha �ok �yk� t�r�nde eserler verse de romanlar�yla �n plana ��kt�; romanlar�nda uzun tasvirlerle ele ald��� sevgi ve a�k temas�n�, zaman zaman siyasi tart��malar�na g�nderme yapan anlat�larla zaman zaman da toplumsal aksakl�klara y�neltti�i ele�tirilerle destekledi. Kuyucakl� Yusuf (1937), ��imizdeki �eytan (1940) ve K�rk Mantolu Madonna (1943) romanlar� T�rkiyedeki edebiyat �evrelerinin takdirini toplayarak hem 20. y�zy�lda hem de 21. y�zy�lda etkisini s�rd�rd�. E�riderede do�an Ali, ilk hik�ye ve �iir denemelerine Bal�keside ba�lad�ktan sonra �stanbuldaki edebiyat ��retmeni Ali Canip Y�ntemin deste�iyle ilk kez Akbaba ve �a�layan dergilerinde �iirlerini yay�mlatt�. Anadoluda k�sa s�re ��retmenlik yapt�ktan sonra T�rkiye taraf�ndan dil e�itimi i�in Almanyaya g�nderildi. �lkesine geri d�nd���nde Almanca ��retmeni olarak g�reve ba�lasa da �nce kom�nizm propagandas� yapt��� iddias�yla bir s�re tutukland�, ard�ndan ise �lkesinin y�neticilerini ele�tirdi�i iddias�yla tekrar tutukland�. Bu d�nemde memurluktan ihra� edilince g�revine geri d�nebilmek i�in Atat�rk hakk�nda bir �iir yazd� ve tekrar devlet kurumlar�nda g�revlendirildi. Ayr�ca kendisine y�klenen sosyalist alg�s�n� k�rmak i�in de Esirler adl� bir oyun kaleme ald�.';

group1 = getNewsGroup("sozcu");
group2 = getNewsGroup("sabah");
test = calculateVector(fileread("news\hurriyet.txt"));
euclidean_distance_to_news_group1 = calculateEuclid(group1, test);
euclidean_distance_to_news_group2 = calculateEuclid(group2, test);

mahalanobis_distance_to_news_group1 = calculateMahal(group1, test);
mahalanobis_distance_to_news_group2 = calculateMahal(group2, test);


function euclid = calculateEuclid(news_matrix, test)
    %test �rne�inin gruba euclid uzakl���n� hesaplamak i�in
    %grubun her bir eleman�n�n test �rne�ine uzakl�klar� hesaplan�p
    %ortalamas� al�nm��t�r. 
    distances = zeros(10,1);
    for i = 1:size(news_matrix,1)
        distances(i) = sqrt(sum((news_matrix(i,:)- test) .^2));
    end
    euclid = mean(distances);
end

function mahalanobis = calculateMahal(news_matrix, test)
    for i=1:size(news_matrix,2)
        if ~any(news_matrix(:, i))
            news_matrix(end, i)=1;
        end 
    end
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
    %kelime bigram/trigramlar�nda kullan�lmak �zere basit metin temizleme.
    %kelime say�s�, ortalama harf say�s�nda da temizlenmi� metin kullan�ld�.
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
    text = text(isstrprop(text, 'alpha'));%sadece letters i�erisinde �zel karakter aras�n..
    d_text = double(text);
    c_spec = sum(d_text>191); %UNICODE'da 192ve yukar�s� �zel karakterler oldu�undan..
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
    ltext = replace(ltext,'�',' ');
    ltext = regexprep(ltext, '\s+',' ');
    ltext = replace(ltext,'   ',' ');
    ltext = replace(ltext,'  ',' ');
    new_text = ltext;
end


