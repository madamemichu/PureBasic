;Invader

;
;Objectif de cet exercice
;   Afficher un vaisseau en bas de l'ecran
;
;   Déplacer le vaisseau avec les touches gauche et droite du clavier

EnableExplicit

Enumeration Window
  #MainForm
EndEnumeration

;Vaisseau
Global Ship, ShipX = 350 ; (Largeur de l'écran / 2) - (largeur du vaisseau / 2)

;Evenement et compteur de boucles
Global Event, CountLoop

;Dossier média
Global FolderImages.s = "assets\/images\/"

;Initialisation de l'environnement 2D
InitSprite() : InitKeyboard()

;Creation de la surface de jeu
OpenWindow(#MainForm, 0, 0, 800, 600, "", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
OpenWindowedScreen(WindowID(#MainForm), 0, 0, 800, 600)

;-Chargement des sprites

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
  ClearScreen(RGB(0, 0, 0)) ;Commenter pour voir ce qu'il se passe
  
  ; 2 - Affichage du sprite  
  DisplayTransparentSprite(Ship, ShipX, 500)
      
  ; 3 - Examinons si une touche du clavier est préssée
  ExamineKeyboard()
  
  ;Déplacement du vaisseau avec les touches droite ou gauche
  ;Le vaisseau ne doit pas sortir des limites gauche et droite de la surface du jeu
  If KeyboardPushed(#PB_Key_Left) And ShipX > 0 
    ShipX - 2 ;Le vaisseau se déplace à gauche de 2 pixels
  EndIf
  
  If KeyboardPushed(#PB_Key_Right) And ShipX < ScreenWidth() - SpriteWidth(Ship)
    ShipX + 2 ;Le vaisseau se déplace à droite de 2 pixels
  EndIf
      
  ;DEBUG
  ;Le jeu s'éxécute dans une boucle infini. La touche Escape permet de quitter cette boucle
  ;Pour se rendre compte de l'évolution de la position x du vaisseau, on va afficher x dans le titre de la fenetre
  ;Affichons aussi le compteur de boucles ainsi que le nombre de vies de l'ennemi
  CountLoop + 1
  SetWindowTitle(#MainForm, "Nombre de boucles : " + CountLoop + " - Position x du vaisseau " + ShipX)  
  
  ; 4 - Inversion des buffers d'affichage  
  ;Pendant qu'une image est affiché la suivant se prépare dans une zone invisible.
  ;FlipBuffers() permet d'alterner entre l'image affichée et celle en cours de préparation.
  ;La zone invisible est désormais visible et vice versa, 
  FlipBuffers()
  
Until KeyboardPushed(#PB_Key_Escape) ;La touche Escape permet de quitter le jeu
; IDE Options = PureBasic 5.42 LTS (Windows - x86)
; CursorPosition = 75
; FirstLine = 55
; EnableUnicode
; EnableXP