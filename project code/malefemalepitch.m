file = uigetfile({'*.m4a;*.mp3 ;*.wav'},'Select Your Voice');
[man , ~] = audioread(file);
f0 = freq(man);
b=mean(f0);
if b>165
fprintf("Female Voice");
else
fprintf('Male Voice');
end