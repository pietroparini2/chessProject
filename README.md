![imagechess](imDOC/titleImage.jpg)


# chessProject
progetto esame elaborazione delle immagini Giugno 2018

## Documentazione delle funzioni del progetto

# prima parte progetto
La prima parte del progetto si occupa di estrarre dall'immagine originale la scacchiera.

#### readImages(aux)
  funzione che carica le immagini nell'intervallo specificato, trasforma in double
  * **input** due valori interi che indicano l'intervallo delle immaggini da analizzare
  * **output** void
  * **parametri:** 0
  * **matlab functions:** [im2double](https://it.mathworks.com/help/matlab/ref/im2double.html?searchHighlight=im2double&s_tid=doc_srchtitle),
  [imread](https://it.mathworks.com/help/matlab/ref/imread.html?searchHighlight=imread&s_tid=doc_srchtitle),
  [sprintf](https://it.mathworks.com/help/matlab/ref/sprintf.html?searchHighlight=sprintf&s_tid=doc_srchtitle)
  * **invocata da:** tutti gli script di test, script main


### resizeImage
   funzione che si occupa di fare una resize dell'immagine in modo da rendere più veloce e più scalabile tutta la computazione, e di lavorare in un formato standardizzato.
   diminuisce tutte le immagini a un massimo di dimensioni dei 2 lati di 1042 px tenendo le proporzioni originali.
   importante che imresize mantiene le proporzioni
   * **input:** immagine del dataset di immagini da analizzare
   * **output:** array di due elementi , immagine di nuove dimensione , scala usata per le immagini
   * **parametri:** misura massima degli assi  dell'immagine= 1000+42
   * **matlab functions:**
    [size](https://it.mathworks.com/help/matlab/ref/size.html?searchHighlight=size&s_tid=doc_srchtitle), [imresize](https://it.mathworks.com/help/matlab/ref/imresize.html?searchHighlight=imresize&s_tid=doc_srchtitle)
   * **test**: testResize

#### testResizeImage
   script di  test per la funzione resize
   vengono salvate in variabili separate le dimensioni dell'immagine originale, immagine resized e scala
   in un array boolean test viene verificato stia funzionando correttasmente la 'scalata' di tutte le immagini tramite il calcolo inverso.
   * **funzioni invocate:** readImages

### primaryElaboration
   funzione, seconda possibilità di elaborazione
   sviluppata in modo complementare alla secondaryElaboration, per poter individuare le scacchiere la dove c'è la presenza di uno sfondo a texture
   * **input:** immagine già nella dimensione stabilita per l'elaborazione
   * **output:** immagine in bianco e nero pronta per il riconoscimento dei componenti
   * **parametri:** misure dischi (!!!scrivere il perchè dopo aver fatto il ripasso)
   * **matlab functions:** [size](https://it.mathworks.com/help/matlab/ref/size.html?searchHighlight=size&s_tid=doc_srchtitle), [rgb2gray](https://it.mathworks.com/help/matlab/ref/rgb2gray.html?searchHighlight=rgb2gray&s_tid=doc_srchtitle), [im2double](https://it.mathworks.com/help/matlab/ref/im2double.html?searchHighlight=im2double&s_tid=doc_srchtitle), [imopen](https://it.mathworks.com/help/images/ref/imopen.html?searchHighlight=imopen&s_tid=doc_srchtitle),
   [imclose](https://it.mathworks.com/help/images/ref/imclose.html?searchHighlight=imclose&s_tid=doc_srchtitle), [strel](https://it.mathworks.com/help/images/ref/strel.html?searchHighlight=strel&s_tid=doc_srchtitle),
   [imbinarize](https://it.mathworks.com/help/images/ref/imbinarize.html?searchHighlight=imbinarize&s_tid=doc_srchtitle)
   * **test:** testPrimaryElaboration
![imageTextureElaboration](imDOC/textureElaboration.png)


#### testPrimaryElaboration
   script di test per la funzione primaryElaboration
   vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
   * **funzione invocate:** readImages, rersizeImage, textureElaboration
![imageTestTextureElaboration](imDOC/testTextureElaboration.png)

### secondaryElaboration
   funzione, prima possibilità di elaborazione
   porta l'immagine a livelli di grigi se necessario, elabora tramite equalizzazione dell istogramma e sogliatura immagine con soglia individuata tramite Otsu.
   * **input:** immagine già nella dimensione stabilita per l'elaborazione, boolean per il testing
   * **output:** immagine in bianco e nero pronta per il riconoscimento delle componenti
   * **parametri:** misura disco =6= per tentativi dopo aver stimato sulle prime 20 immagini che doveva essere 4,6,8 o 10 (!!!scrivere il perchè in due parole)
   * **matlab functions:** [size](https://it.mathworks.com/help/matlab/ref/size.html?searchHighlight=size&s_tid=doc_srchtitle), [rgb2gray](https://it.mathworks.com/help/matlab/ref/rgb2gray.html?searchHighlight=rgb2gray&s_tid=doc_srchtitle), [adapthisteq](https://it.mathworks.com/help/images/ref/adapthisteq.html?searchHighlight=adapthisteq&s_tid=doc_srchtitle), [imclose](https://it.mathworks.com/help/images/ref/imclose.html?searchHighlight=imclose&s_tid=doc_srchtitle), [strel](https://it.mathworks.com/help/images/ref/strel.html?searchHighlight=strel&s_tid=doc_srchtitle), [graythresh](https://it.mathworks.com/help/images/ref/graythresh.html?searchHighlight=graythresh&s_tid=doc_srchtitle), [imbinarize](https://it.mathworks.com/help/images/ref/imbinarize.html?searchHighlight=imbinarize&s_tid=doc_srchtitle)
   * **test:** testSecondaryElaboration  
![imageMainElaboration](imDOC/secondaryElaboration.png)

#### testSecondaryElaboration
   script di test per la funzione secondaryElaboration
   vengono caricate, elaborate, e mostratre a video, le immagini originali e quelle elaboborate
   * **funzione invocate:** readImages, resizeImage, secondaryElaboration
![imageTestMainElaboration](imDOC/testMainElaboration.png)


### chessDiscover
   funzione che si occupa di individuare la scacchiera.
   sfruttando le bounding box va a cercare le bounding box quadrate, con un errore del 20%,  per poi selezionare quella più grande. (da aggiungere un controllo sulle diagonali =, forse anche pitagora)
   * **input:** immagine elaborata(per ora da elaborationOne), la scala dell'immagine elaborata(output di resizeImage), immagine originale.
   * **output:** la probabile chessboard sotto forma di struct contenente boundingbox, convexarea, convexImage ed scacchiera ritagliata dall'immagine originale
   * **parametri:**  errore di approssimazione dei lati = 0.20= stimato sulle prime 10 immagini, considerando che è solo un primo passaggio il secondo verrà poi implementato (dopo si può un po' abbassare )
   * **matlab functions:** [regionprops](https://it.mathworks.com/help/images/ref/regionprops.html?searchHighlight=regionprops&s_tid=doc_srchtitle),
   [sort](https://it.mathworks.com/help/matlab/ref/sort.html?searchHighlight=sort&s_tid=doc_srchtitle),
   [fliplr](https://it.mathworks.com/help/matlab/ref/fliplr.html?searchHighlight=fliplr&s_tid=doc_srchtitle) (guardare anche le funzioni invocate per il test)
   * **test:** testChessDiscover
![imageChessDiscover](imDOC/chessDiscover.png)


#### testChessDiscover
  script di test per la funzione chessDiscover
  vengono caricate, elaborate, e mostratre a video, le immagini originale tagliate e la maschera dell'immagine binaria tagliata
  * **funzione invocate:** readImages, resizeImage, elaborationOne, chessDiscover
![imageTestChessDiscover](imDOC/testChessDiscover.png)


#### cornersMask(aux)
  funzione che si occupa di individuare i 4 corner di una maschera binaria che riceve in input.
  * **input:** maschera binaria figura bianco su sfondo nero
  * **output:** matrice con i 4 corner
  * **parametri:** 0
  * **matlab functions:** [find](https://it.mathworks.com/help/matlab/ref/find.html?searchHighlight=find&s_tid=doc_srchtitle)
  * **invocata da:** straightnessChess, (la userò anche per  controllare le diagonali)

### straightensChess
  funzione che si occupa di raddrizzare la scacchiera all'interno della boundingBox che la contiene.
  * **input:** immagine boundingBox da raddrizzare , maschera immagine boundingbox da raddrizzare
  * **output:** immagine raddrizzata
  * **prametri:** 0
  * **matlab functions:**
  [size](https://it.mathworks.com/help/matlab/ref/size.html?searchHighlight=size&s_tid=doc_srchtitle), [imresize](https://it.mathworks.com/help/matlab/ref/imresize.html?searchHighlight=imresize&s_tid=doc_srchtitle),
  [fitgeotrans](https://it.mathworks.com/help/images/ref/fitgeotrans.html?s_tid=doc_ta) ,
  [imwarp](https://it.mathworks.com/help/images/ref/imwarp.html?searchHighlight=imwarp&s_tid=doc_srchtitle),
  [regionprops](https://it.mathworks.com/help/images/ref/regionprops.html?searchHighlight=regionprops&s_tid=doc_srchtitle),
  [imcrop](https://it.mathworks.com/help/images/ref/imcrop.html?searchHighlight=imcrop&s_tid=doc_srchtitle)
  * **test:** testStraightensChess

#### testStraightensChess
  script di test per la funzione testStraightensChess
  vengono mostrate a video le immagini,() interne alla più grossa boundingbox quadrata ) rispettivamente prima di essere raddrizate e successivamente
  * **funzioni invocate:**   readImages, resizeImage, elaborationOne, chessDiscover,  straightensChess
![imageStraightensChess](imDOC/straightensChess.png)

### isChessBoard
  funzione che si occupa di stimare una percentuale che indica la probabilità che l'immagine passata sia effivamente una scacchiera.
  * **input:** immagine (presunta scacchiera)
  * **output:** valore numerico 0<x<1
  * **parametri:** disco di dimensione 3 (!!! scrivere perchè dopo il ripasso)
  * **matlab functions:** [rgb2gray](https://it.mathworks.com/help/matlab/ref/rgb2gray.html?searchHighlight=rgb2gray&s_tid=doc_srchtitle),
  [size](https://it.mathworks.com/help/matlab/ref/size.html?searchHighlight=size&s_tid=doc_srchtitle),
  [imread](https://it.mathworks.com/help/matlab/ref/imread.html?searchHighlight=imread&s_tid=doc_srchtitle),
  [rgb2gray](https://it.mathworks.com/help/matlab/ref/rgb2gray.html?searchHighlight=rgb2gray&s_tid=doc_srchtitle),
  [imbinarize](https://it.mathworks.com/help/images/ref/imbinarize.html?searchHighlight=imbinarize&s_tid=doc_srchtitle), [imopen](https://it.mathworks.com/help/images/ref/imopen.html?searchHighlight=imopen&s_tid=doc_srchtitle),
  [imresize](https://it.mathworks.com/help/matlab/ref/imresize.html?searchHighlight=imresize&s_tid=doc_srchtitle),
  [corr2](https://it.mathworks.com/help/images/ref/corr2.html?searchHighlight=corr2&s_tid=doc_srchtitle)
  * **test:** testIsChessboard

#### testIsChessboard
  script di test per la funzione isChessboard
  * **funzioni invocate:**  isChessboard, readImages, resizeImage, elaborationOne, chessDiscover,  straightensChess.
![imageTestIsChessboard1](imDOC/testIsChessboard1.png)
![imageTestIsChessboard2](imDOC/testIsChessboard2.png)

### chooseElaboration
  funzione che si occupa di stabilire se la presuntaScacchiera trovata con secondaryElaboration è effettivamente una scacchier.
  se è una scacchiera ma viene tagliata male, stabilisce la migliore tra le due elaborazioni.
  * **input:** immagine ridimensionata, scala del ridimensionamento, immagine originale
  * **output:** immagine scacchiera
  * **parametri:** stiama scacchiera=0.60= stimato sulle prime 20 scacchiere

#### testFirstHalfPipe
  test che accorpora tutti i test sviluppati fino a questo punto, mostrando in successione tutti i risultati dii ogni test.
  * **funzioni invocate:**   readImages, resizeImage, chooseElaboration
![imageTestFirstHalfPipe](imDOC/testFirstHalfPipe.png)




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
  * **funzioni invocate:** readImages, makeDataset, resizeImage, secondaryElaboration, chessDiscover, straightensChess, fenGenerator.

