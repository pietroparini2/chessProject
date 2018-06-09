![imagechess](titleImage.jpg)


# chessProject
progetto esame elaborazione delle immagini Giugno 2018

# to do:
* aggiungere nella doc le chiamate alle funzioni esterne e studiarsele un attimo
* ricordarsi che c'è la funzione sauvola messa a caso
* inserire i test intermedi 
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

### mainElaboration
   funzione, prima possibilità di elaborazione
   porta l'immagine a livelli di grigi se necessario, elabora tramite equalizzazione dell istogramma e sogliatura immagine con soglia individuata tramite Otsu.
   * **input:** immagine già nella dimensione stabilita per l'elaborazione
   * **output:** immagine in bianco e nero pronta per il riconoscimento delle componenti
   * **parametri:** misura disco =6= per tentativi dopo aver stimato sulle prime 10 immagini che doveva essere 4,6,8 o 10 (!!!scrivere il perchè in due parole)
   * **test:** testMainElaboration  

#### testMainElaboration
   script di test per la funzione elaborationOne
   vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
   * **funzione invocate:** readImages, resizeImage, mainElaboration

### textureElaboration
   funzione, seconda possibilità di elaborazione
   sviluppata in modo complementare alla mainElaboration, per poter individuare le scacchiere la dove c'è la presenza di uno sfondo a texture
   * **input:** immagine già nella dimensione stabilita per l'elaborazione 
   * **output:** immagine in bianco e nero pronta per il riconoscimento dei componenti
   * **parametri:** misure dischi (!!!scrivere il perchè dopo aver fatto il ripasso)
   * **test:** testTextureElaboration
 
#### testTextureElaboration
   script di test per la funzione textureElaboration
   vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
   * **funzione invocate:** readImages, rersizeImage, textureElaboration

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
  * **funzioni invocate:**   readImages, resizeImage, chooseElaboration 

### isChessBoard 
  funzione che si occupa di stimare una percentuale che indica la probabilità che l'immagine passata sia effivamente una scacchiera.
  * **input:** immagine (presunta scacchiera)
  * **output:** valore numerico 0<x<1
  * **parametri:** disco di dimensione 3 (!!! scrivere perchè dopo il ripasso)
  * **test:** testIsChessboard 

#### testIsChessboard 
  script di test per la funzione isChessboard
  * **funzioni invocate:**  isChessboard, readImages, resizeImage, elaborationOne, chessDiscover,  straightensChess.

### chooseElaboration
  funzione che si occupa di stabilire se la presuntaScacchiera trovata con mainElaboration è effettivamente una scacchier.
  se è una scacchiera ma viene tagliata male, stabilisce la migliore tra le due elaborazioni.
  * **input:** immagine ridimensionata, scala del ridimensionamento, immagine originale
  * **output:** immagine scacchiera 
  * **parametri:** stiama scacchiera=0.60= stimato sulle prime 20 scacchiere 



  fine prima parte progetto--------------------------------------------------------------------------------

#### fenGenerator
  funzione che si occupa di creare la stringa FEN partendo dall'immagine raddrizzata della scacchiera. Per individuare i pezzi utilizza la correlazione incrociata normalizata.
  * **input:** immagine della scacchiera ritagliata e raddrizzata, dataset dei pezzi per il match.
  * **output:** stringa fen.
  * **parametri:** 0,6 utilizzato come soglia minima per riconoscere tramite la correlazione incrociata normalizzata
  * **funzioni invocate:**   findSquare, fenString.

#### findSquare
  funzione che ritaglia dalla scacchiera le singole celle.
  * **input:** imaggine scacchiera ritagliata e raddrizzata, valore di debug (0/1).
  * **output:** singole celle in oggetto di tipo "cell".
  * **funzione invocata da:** fenGenerator

#### fenString
  funzione che crea la stringa fen partendo dalla matrice degli indici dei pezzi trovata grazie alla funzione fenGenerator.
  * **input:** matrice contenente i vari indici dei pezzi.
  * **output:** stringa fen.
  * **funzione invocata da:** fenGenerator

#### fenStringApp
  funzione che crea la stringa fen partendo dalla matrice con le iniziali dei pezzi.
  * **input:** matrice contenente le iniziali dei pezzi.
  * **output:** stringa fen.
  * **funzione invocata da:** fenString

#### testOCR
  script di test per la parte della creazione della stringa
  * **funzioni invocate:** readImages, makeDataset, resizeImage, mainElaboration, chessDiscover, straightensChess, fenGenerator.

stringhe FEN da controllare:
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [8/4r1n1/8/Q4N2/5k2/3P1N1K/7n/7B]
    [R7/1kN1Q3/2b5/Pn6/4Np2/8/2R4B/7K]
    [1B6/5p2/2pnN1P1/R1N1k3/4p3/8/5Q2/6K]
    [2bb1K2/4p3/5k1n/3QNP2/5R1P/8/8/8]
    [8/8/8/5R2/8/2KPkB1b/8/5R2]
    [4rQB1/6n1/3p4/5b2/N2R4/1P6/2k5/KR6]
    [1B6/8/2Q1P3/3Nr3/4k1BR/1P6/2K5/2n3b1]
    [8/8/4p2Q/2K1p3/4k3/2p2r2/5RRp/7B]
