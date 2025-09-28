# culture = 'fr-FR'
ConvertFrom-StringData @'
    Footer = Page <!# PageNumber #!>
    Logo = AsBuiltReport Logo
    CoverPageWarning = Impossible d'afficher l'image de couverture. Veuillez définir 'ShowCoverPageImage' sur 'false' dans le fichier de configuration JSON du rapport pour éviter cette erreur.
    CoverPage = Page de couverture
    Author = Auteur:
    Date = Date:
    Version = Version:
    TOC = Table des Matières
'@