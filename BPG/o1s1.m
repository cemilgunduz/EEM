text = 'Sabahattin Ali (25 Şubat 1907 - 2 Nisan 1998), Türk yazar ve şair. Edebi kişiliğini toplumcu gerçekçi bir düzleme oturtarak yaşamındaki deneyimlerini okuyucusuna yansıttı ve kendisinden sonraki cumhuriyet dönemi Türk edebiyatını etkileyen bir figür hâline geldi. Daha çok öykü türünde eserler verse de romanlarıyla ön plana çıktı; romanlarında uzun tasvirlerle ele aldığı sevgi ve aşk temasını, zaman zaman siyasi tartışmalarına gönderme yapan anlatılarla zaman zaman da toplumsal aksaklıklara yönelttiği eleştirilerle destekledi. Kuyucaklı Yusuf (1937), İçimizdeki Şeytan (1940) ve Kürk Mantolu Madonna (1943) romanları Türkiyedeki edebiyat çevrelerinin takdirini toplayarak hem 20. yüzyılda hem de 21. yüzyılda etkisini sürdürdü. Eğriderede doğan Ali, ilk hikâye ve şiir denemelerine Balıkeside başladıktan sonra İstanbuldaki edebiyat öğretmeni Ali Canip Yöntemin desteğiyle ilk kez Akbaba ve Çağlayan dergilerinde şiirlerini yayımlattı. Anadoluda kısa süre öğretmenlik yaptıktan sonra Türkiye tarafından dil eğitimi için Almanyaya gönderildi. Ülkesine geri döndüğünde Almanca öğretmeni olarak göreve başlasa da önce komünizm propagandası yaptığı iddiasıyla bir süre tutuklandı, ardından ise ülkesinin yöneticilerini eleştirdiği iddiasıyla tekrar tutuklandı. Bu dönemde memurluktan ihraç edilince görevine geri dönebilmek için Atatürk hakkında bir şiir yazdı ve tekrar devlet kurumlarında görevlendirildi. Ayrıca kendisine yüklenen sosyalist algısını kırmak için de Esirler adlı bir oyun kaleme aldı.'

text = char(text);
uc = sum(isstrprop(text, "upper"));
lc = sum(isstrprop(text, "lower"));
num = sum(isstrprop(text, "digit"));
pnc = sum(isstrprop(text, "punct"));
alph = text(isstrprop(text, 'alpha'));%sadece letters içerisinde özel karakter arasın..
x = getSpecialCharCount(text);
cUpperBi = getBiGramCount(text, 'upper');
cLowerBi = getBiGramCount(text, 'lower');
cNumBi = getBiGramCount(text, 'digit')
getTriGramCount("acscqsdaffr", "lower")

function cSpec = getSpecialCharCount(text)
    d_text = double(text)
    cSpec = sum(d_text>191) %UNICODE'da 192ve yukarısı özel karakterler olduğundan..
end

function cBG = getBiGramCount(text,  category)
    %tried another method by iterating on each character of text
    %found this method is approx 8 times faster than the other method
    binary_vector = isstrprop(text, category); %get uppercase letters
    cBG = 0;
    for i=2:length(binary_vector)-2
        if binary_vector(i) == 1 && binary_vector(i+1)==1%arka arkaya iki büyük harf olması durumunda
            if (text(i) == text(i+1)) && (text(i-1) ~= text(i)) && (text(i+1)~=text(i+2))
                cBG = cBG + 1;
            end
        end
    end
    if (text(1) == text(2)) && (text(2) ~= text(3)) %başta iki aynı olma durumu
        cBG = cBG+1;
    end
    if (text(end-1) == text(end)) && (text(end-2) ~= text(end-1)) %sonda iki aynı olma durumu
        cBG = cBG+1;
    end
end

function cTRG = getTriGramCount(text, category)
    binary_vector = isstrprop(text, category);
    filter = [0 1 1 1 0];
    for i=3:length(binary_vector)-3
        010bv = binary_vector(i-2:i+2);
        if bv == filter
            disp("found trigram");
        end
    end
end