 RESIZE
 funzione che si occupa di fare una resize dell'immagine in modo da rendere più veloce e più scalabile tutta la computazione.
 diminuisce tutte le immagini a un massimo di dimensioni dei 2 lati di 1042 px tenendo le proporzioni originali.
 input: immagine del dataset di immagini da analizzare 
 output: array di due elementi , immagine di nuove dimensione , scala usata per le immagini
 
 TESTRESIZE
 classe di test per la funzione resize
 i titoli non funzionano come dovrebbero perchè matlab non vuole farli funzionare 
 vengono salvate in variabili separate le dimensioni dell'immagine originale, immagine resized e scala
 in un boolean test viene verificato stia funzionando correttasmente la 'scalata'
