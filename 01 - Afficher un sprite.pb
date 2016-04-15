;Afficher un sprite

;
;Objectif de cet exercice
;   Afficher un vaisseau en bas de l'ecran

EnableExplicit

Enumeration Window
  #MainForm
EndEnumeration

;Vaisseau
Global Ship

;Evenement et compteur de boucles
Global Event, CountLoop

;Dossier des médias
Global FolderImages.s = "assets\/images\/"

;Initialisation de l'environnement 2D
InitSprite() 
InitKeyboard()

;Creation de la surface de jeu
OpenWindow(#MainForm, 0, 0, 800, 600, "", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
OpenWindowedScreen(WindowID(#MainForm), 0, 0, 800, 600)

;-Chargement du sprite

;On va utiliser des sprites au format PNG
UsePNGImageDecoder()

;Important : Le point d'affichage d'un sprite est toujours le coin haut gauche
;
; X & Y  
;   O--------
;   |      /|
;   |    /  |
;   |  /    |
;   |/      |
;   ---------
; 

;Le sprite Ship ayant des pixels transparents, on va utiliser l'option #PB_Sprite_AlphaBlending

;Taille des sprites
;   ship.png  100 x 82

Ship  = LoadSprite(#PB_Any, FolderImages + "ship.png", #PB_Sprite_AlphaBlending)

;-Boucle evenementielle
Repeat  ;Evenement du jeu
  Repeat;Evenement window
    Event = WindowEvent()
    
    Select Event    
      Case #PB_Event_CloseWindow
        End
    EndSelect  
  Until Event=0
  
  ; 1 - Effacer l'ecran avec une couleur avant d'afficher les sprites
  ClearScreen(RGB(0, 0, 0)) 
  
  ; 2 - Affichage du sprite
  DisplayTransparentSprite(Ship, 350, 500)
     
  ; 3 - Examinons si une touche du clavier est préssée
  ExamineKeyboard()
    
  ;DEBUG
  ;Le jeu s'éxécute dans une boucle infini. La touche Escape permet de quitter cette boucle
  ;Affichons le compteur de boucles   
  CountLoop + 1
  SetWindowTitle(#MainForm, "Nombre de boucles : " + CountLoop)  
  
  
  ; 4 - Inversion des buffers d'affichage
  ;Pendant qu'une image est affiché la suivante se prépare dans une zone invisible.
  ;FlipBuffers() permet d'alterner entre l'image affichée et celle en cours de préparation.
  ;La zone invisible est désormais visible et vice versa, 
  FlipBuffers()
  
Until KeyboardPushed(#PB_Key_Escape) ;La touche Escape permet de quitter le jeu
; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 69
; FirstLine = 30
; EnableUnicode
; EnableXP