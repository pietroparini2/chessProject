# chessProject
progetto esame elaborazione delle immagini febbraio 2018


## Documentazione delle funzioni del progetto 

#### readImages(aux)
* **input** due valori interi che indicano l'intervallo delle immaggini da analizzare
* **output** void
 funzione che carica le immagini nell'intervallo specificato


### resizeImage
 funzione che si occupa di fare una resize dell'immagine in modo da rendere più veloce e più scalabile tutta la computazione.
 diminuisce tutte le immagini a un massimo di dimensioni dei 2 lati di 1042 px tenendo le proporzioni originali. (42 -->numero perfetto)
 * **input:** immagine del dataset di immagini da analizzare 
 * **output:** array di due elementi , immagine di nuove dimensione , scala usata per le immagini
 * **test**: testResize
 
#### test/testResize
 script di  test per la funzione resize
 i titoli non funzionano come dovrebbero perchè matlab non vuole farli funzionare 
 vengono salvate in variabili separate le dimensioni dell'immagine originale, immagine resized e scala
 in un array boolean test viene verificato stia funzionando correttasmente la 'scalata' di tutte le immagini
 * **funzioni invocate:** readImages

### elaborationOne
 funzione, prima possibilità di elaborazione
 porta l'immagine a livelli di grigi se necessario, elabora tramite equalizzazione dell istogramma e sogliatura immagine con soglia individuata tramite Otsu.
 * **input:** immagine già nella dimensione stabilita per l'elaborazione
 * **output:** immagine in bianco e nero pronta per il riconoscimento delle componenti
 * **test:** testElaborationOne

#### testElaboratioOne
 script di test per la funzione elaborationOne
 vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
* **funzione invocate:** readImages
