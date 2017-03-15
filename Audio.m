clc
clear
audio = miraudio('Muskurane (Citylights) - Arijit Singh (DjPunjab.Com).mp3','Extract',212,214);

rms = mirrms(audio);
brightness = mirbrightness(audio);
roughness = mirroughness(audio);
rolloff = mirrolloff(audio);
skewness = mirskewness(audio);
flatness = mirflatness(audio);
mfcc = mirmfcc(audio);
centroid = mircentroid(audio);

mirexport('data.txt',rms,brightness,roughness,rolloff,skewness,flatness,mfcc,centroid);