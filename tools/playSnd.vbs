sound = "C:\Windows\Media\Alarm01.wav"
sound2 = "C:\Windows\Media\Ring02.wav"
' mp3�͔�Ή� �̂悤��(SAPI)  sound3 = "C:\Users\thirai\Downloads\�����v�i12�񕪁j.mp3"

Set objVoice = CreateObject("SAPI.SpVoice")
Set objFile = CreateObject("SAPI.SpFileStream.1")

objFile.Open sound3
objVoice.Speakstream objFile
'objVoice.Speak("���[������")
