# chessProject
progetto esame elaborazione delle immagini Giugno 2018

# to do:
* aggiungere nella doc le chiamate alle funzioni esterne e studiarsele un attimo
* ricordarsi che c'è la funzione sauvola messa a caso
* implemntare il controllo sulle diagonali, e su pitagora
* implementare un secondo tipo di elaborazione (elaborationTwo) da lanciare se dopo il controllo delle diagonali non rimangono  candidati plausibili

## Documentazione delle funzioni del progetto

# prima parte progetto
La prima parte del progetto si occupa di estrarre dall'immagine originale la scacchiera.

#### readImages(aux)
funzione che carica le immagini nell'intervallo specificato
* **input** due valori interi che indicano l'intervallo delle immaggini da analizzare
* **output** void
* **parametri:** 0
* **invocata da:** tutte le funzioni di test  


### resizeImage
 funzione che si occupa di fare una resize dell'immagine in modo da rendere più veloce e più scalabile tutta la computazione, e di lavorare in un formato standardizzato.
 diminuisce tutte le immagini a un massimo di dimensioni dei 2 lati di 1042 px tenendo le proporzioni originali. (42 -->numero perfetto)
 * **input:** immagine del dataset di immagini da analizzare
 * **output:** array di due elementi , immagine di nuove dimensione , scala usata per le immagini
 * **parametri:** misura massima degli assi  dell'immagine= 1000+42
 * **test**: testResize

#### testResize
 script di  test per la funzione resize
  vengono salvate in variabili separate le dimensioni dell'immagine originale, immagine resized e scala
 in un array boolean test viene verificato stia funzionando correttasmente la 'scalata' di tutte le immagini tramite il calcolo inverso
 * **funzioni invocate:** readImages

### elaborationOne
 funzione, prima possibilità di elaborazione
 porta l'immagine a livelli di grigi se necessario, elabora tramite equalizzazione dell istogramma e sogliatura immagine con soglia individuata tramite Otsu.
 * **input:** immagine già nella dimensione stabilita per l'elaborazione
 * **output:** immagine in bianco e nero pronta per il riconoscimento delle componenti
 * **parametri:** misura disco =6= per tentativi dopo aver stimato sulle prime 10 immagini che doveva essere 4,6,8 o 10 (!!!scrivere il perchè in due parole)
 * **test:** testElaborationOne

#### testElaboratioOne
 script di test per la funzione elaborationOne
 vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
 * **funzione invocate:** readImages, resizeImage, elaborationOne

#### elaborationTwo
 funzione, seconda possibilità di elaborazione
 !!! da implementare, per ora è a caso... deve fornire un alternativa/complementare ad elaborationOne

#### testElaborationTwo
 script di test per la funzione elaborationTwo
 vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
 * **funzione invocate:** readImages, rersizeImage, elaborationTwo

### chessDiscover
 funzione che si occupa di individuare la scacchiera.
 sfruttando le bounding box va a cercare le bounding box quadrate, con un errore del 20%,  per poi selezionare quella più grande. (da aggiungere un controllo sulle diagonali =, forse anche pitagora)
 * **input:** immagine elaborata(per ora da elaborationOne), la scala dell'immagine elaborata(output di resizeImage), immagine originale.
 * **output:** la probabile chessboard sotto forma di struct contenente boundingbox, convexarea, convexImage ed scacchiera ritagliata dall'immagine originale
 * **parametri:**  errore di approssimazione dei lati = 0.20= stimato sulle prime 10 immagini, considerando che è solo un primo passaggio il secondo verrà poi implementato (dopo si può un po' abbassare )
 * **test:** testChessDiscover

#### testChessDiscover
script di test per la funzione chessDiscover
vengono caricate, elaborate, e mostratre a video, le immagini originale tagliate e la maschera dell'immagine binaria tagliata
* **funzione invocate:** readImages, resizeImage, elaborationOne, chessDiscover

#### cornersMask(aux)
  funzione che si occupa di individuare i 4 corner di una maschera binaria che riceve in input.
  * **input:** maschera binaria figura bianco su sfondo nero
  * **output:** matrice con i 4 corner
  * **invocata da:** straightnessChess, (la userò anche per  controllare le diagonali)

### straightensChess
  funzione che si occupa di raddrizzare la scacchiera all'interno della boundingBox che la contiene.
  * **input:** immagine boundingBox da raddrizzare , maschera immagine boundingbox da raddrizzare
  * **output:** immagine raddrizzata
  * **prametri:** 0
  * **test:** testStraightensChess

#### testStraightensChess
  script di test per la funzione testStraightensChess
  vengono mostrate a video le immagini,() interne alla più grossa boundingbox quadrata ) rispettivamente prima di essere raddrizate e successivamente
  * **funzioni invocate:**   readImages, resizeImage, elaborationOne, chessDiscover,  straightensChess

#### testFirstHalfPipe
  test che accorpora tutti i test sviluppati fino a questo punto, mostrando in successione tutti i risultati dii ogni test.
  * **funzioni invocate:**   readImages, resizeImage, elaborationOne, chessDiscover,  straightensChess.

  fine prima parte progetto--------------------------------------------------------------------------------
