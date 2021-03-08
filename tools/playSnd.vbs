sound = "C:\Windows\Media\Alarm01.wav"
sound2 = "C:\Windows\Media\Ring02.wav"
' mp3は非対応 のようだ(SAPI)  sound3 = "C:\Users\thirai\Downloads\鳩時計（12回分）.mp3"

Set objVoice = CreateObject("SAPI.SpVoice")
Set objFile = CreateObject("SAPI.SpFileStream.1")

objFile.Open sound3
objVoice.Speakstream objFile
'objVoice.Speak("メールだよ")
