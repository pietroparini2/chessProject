# Documentazione

La presente è una piccola documentazione che descrive brevemente i file e i programmi
sviluppati per il progetto del corso di Elaborazione delle Immagini.

## Organizzazione delle cartelle

La cartella principale contiene tutti gli script di progetto.
La cartella:
* **immagini** contiene le immagini di dataset forniteci per lo sviluppo del progetto
	**Tale cartella non è stata caricata in questa repository.**
* **cifre** contiene le immagini delle singole cifre usate come knowledge base nel processo di riconoscimento
* **mio_dataset** contiene le immagini di dataset aggiuntive proposte dal sottoscritto. Si nota che queste immagini
    non sono prese in considerazione durante il calcolo della matrice di confusione, la quale si basa esclusivamente
    sul dataset fornito dai professori.
    
Il file:
* **groundtruth.txt** contiene i nomi dei file delle immagini e la stringa delle cifre del sudoku contenuto.
* **images.txt** contiene i nomi dei file che contengono le immagini, presenti nella cartella **immagini**.
* **groundtruth_raw.txt** contiene le strighe delle cifre del sudoku di tutte le immagini presenti nel file **images.txt**,
    nello stesso ordine delle immagini nell'elenco apposito.

###### Una nota sugli script alternativi:

Sono presenti due script alternativi, *enhanceSudokuROI_alternativo.m* e *getSquare_alternativo.m*.
Tali script non sono usati nella pipeline finale di progetto, ma sono degli approcci alternativi (ma non con uguali risultati)
all'individuamento dei lati del sudoku e alla selezione della griglia dall'immagine binaria ottenuta dallo step precedente.

Tali script sono stati inclusi solo per completezza del lavoro svolto e dell'analisi delle tecniche adoperate durante il progetto.
    
________________________________________________________________________________________________________________________

## Dettagli sugli script

### ocrSudoku.m
File principale del progetto, contente gli step generali della pipeline del progetto.
Descritto a pagina 2 delle slide.

La funzione prende come parametri l'immagine dal quale riconscere le cifre del sudoku, il
dataset e una serie di parametri opzionali (che è possibile omettere) di debug, per l'ispezione
dei risultati intermedi.

Restituisce una stringa contenente le cifre riconosiute nel processo di OCR (i punti indicano
le celle vuote) e una matrice che indica i valori di correlazione ottenuti per ogni cella.

A tal proposito il file test.m fornisce un metodo comodo per l'analisi delle singole immagini,
con i risultati ottenuti (OK per riconosciuto con successo o FAIL per fallimento) per ogni immagine
del dataset.

________________________________________________________________________________

### loadDataset.m
Carica le immagini contenute nella cartella **cifre** (da 1.png a 9.png) in un array, ridimensionando
ogni cifra trovata ad un quadrato di lato specificato dal parametro specificato con la funzione.

________________________________________________________________________________

### computeAll.m
Lancia lo script ocrSudoku.m su tutte le immagini del dataset e confronta il risultato
con la knowledge base. Se il flag di debug (specificato come parametro della funzione)
è attivo (posto a 1), per ogni risultato che non coincide con la groundtruth viene
visualizzata l'immagine per un'ispezione del risultato. Chiudendo l'immagine la computazione
riprenderà con il calcolo delle immagini rimanenti.

In output viene ritornata una struct contente:
* il numero di immagini riconosciute
* il numero totale di immagini del dataset
* la matrice di confusione calcolata sulle immagini del dataset
________________________________________________________________________________

### enhanceSudokuROI.m
File che contiene lo script relativo l'edge detection dell'immagine.
Descritto a pagina 5 delle slide.

________________________________________________________________________________

### getSquare.m
File contenente il processo di estrazione del sudoku descritto a pagina 10.

________________________________________________________________________________

### fitSquareTransform.m
Contiene la procedura di registrazione dell'immagine descritta a pagina 13.

________________________________________________________________________________

### getCellsDigit.m
Contiene il processo di estrazione delle cifre dalle celle del sudoku.
Descritta a pagina 16 delle slide.

________________________________________________________________________________

### OcrCells.m
Esegue il processo di OCR sulle celle. Descritto a pagina 20.

________________________________________________________________________________

### Match by correlation.m
Esegue il match fra le cifre e la knowledge base usando la correlazione.
Descritto a pagina 21.

