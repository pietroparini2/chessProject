chassMain : script che avvia il programma

funzioni scritte da me/riscritte:
-chessMain
-bwImage (almeno parzialmente, equivalente a enhanceSudokuROI)
-findSquare (equivalente a getCellsDigits)
-makeChessPiecesDataset (nome brutto, equivalente mezzo copiato di loadDataset)
-readImages 
-resizeChessboard (è inutile... prima o poi è da togliere ed integrare direttamente senza chiamarla)
-resizeImage
-chessTrasform: comprende le funzioni shearBoard e fitSquareTrasform ma è scritta interamente da me 
                (o meglio presa su internet e modificata leggermente per farla funzionare anche per noi) 

funzioni copiate spudoratamente:
-chessDiscover (l'originale è getSquare)


funzioni ancora non viste:
-computeAll
-matchByCorrelation (funzione che ho rinominato correraltionMatch ma in cui non ho ancora scritto nulla)
-ocrChess (gia creata la funzione ocrCells ma non ancora implementata)
-sauvola (funzione ancora non usata dataci dai prof)

funzioni inutili:   (almeno per ora e quindi non ancora cancellate)
-whiteBalance


chessMain:
-chess: immagine della scacchiera non raddrizzata a colori;
-convexImage: maschera della sola scacchiera storta;
-imageFocused: imma