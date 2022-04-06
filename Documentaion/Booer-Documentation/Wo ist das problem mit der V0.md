## Überblick

die V0 ist die vesion die in Jahre 2021 entwickelt wurde.
Features: 
- Hinzufügen eines Buches per OpenBooks API 
- Erstellen einer Challenge mit Page Streak
- Basic Bookmanagemet (Libary, Reading, Done)

### Architektur: 
Das projekt ist in 3. Packet aufgeteilt, iOS, MacOS und Shared. Innerhalb der parkete wurde MVVM genutzt (Model View ViewModel). Die Daten wurden in CoreData gespeichert
Das Problem bei der Achitektur ist das sie zu grob ist, es muss pro View ein eigener crycle angelegt werden. Das erleichtert das Testen und erhöht die unabhänigkeit der Module.
Auch sollte MacOS und iOS daher nicht so getrennt werden, lieber die app in eigene Scenen (Seiten) aufteilen die dann aus den views für macOS und iOS bestehen wo jede view auch sein eigens Model hat. 
Aktuell wird auch direkt mit der OpenBooks API komuiziert was die app zertören wird sobald openbooks die API minimal anpasst. Da muss ein Server dazwischengeschaltet werden.

### UI/ UX:
Die UI bassiert kommplett auf den default iOS desigen von apple, das lässt die App unter iOS 14 veraltet aussehen.
Die UX ist schlecht, der nutzer landet auf einer leeren seite. Die seite bleibt solange leer bis ein buch hinzugefügt wurde und in reading status gesetzt wurde, die challenges gehen auch unter und der nutzer findet diese zu spät. 


### Testing 
Leider hat die app eine furschtbare testabdeckung ist auch nicht dafür gebaut Mocks zu generieren, dafür braucht man protocolle die nicht vorhanden sind. Das wird füher oder später wird das probleme machen.


