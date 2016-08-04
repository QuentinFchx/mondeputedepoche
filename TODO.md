# Onboarding
Code postal -> Circonscription -> Député
Possibilité de suivre des députés

Comment fonctionne l'assemblée?

Choisir son niveau d'engagement
Notifications


================================
# Public
Intelligent & curieux (-militants)


================================
# Contenu
Votes / Scrutins
Amendements (diff)
Questions au gvt (orales, écrites, ss débat)
Agenda ?
Réseaux sociaux / Contact
Actu (hors RSociaux)
Photo
Metier
Casier judiciare / Implication justice / Condamnations
HATVP Déclaration (lien)

Thèmes de prédilection (spider graph?)
Filtrage du contenu par thème
Programme électoral?

## Data-viz
Votes
Présence assemblée (notif si absence prolongée)
Graphe d'obstruction parlementaire (amendements)

Embed activité


================================
# Models
## Député
Nom, Prénom
Age
Parti ?
Circonscription (through mandat)
Professions


## Utilisateur
Token

===============================
# 1st step - Basics
Fetch & Store data from assemblée nationale website
Api for depute
Basic front-end for a depute


===============================
# 2nd step - Generate Feed
%Activity{
    actor: "",
    verb: "",
    object: ""
}

Depute - Vote - Scrutin
Depute - Pose - Question
Depute - Intervient - Question ?
Depute - Depose - Amendement
Assemblée - Adopte - Scrutin
Assemblée - Adopte - Amendement


===============================
# 3rd step - User Handling
%User{
    email/password/oAuth
    follows
}

Save struct in a webtoken?

{
    follows: []
}


===============================
# Description amendement
Amendement:
 -Auteur
 -Cosignataires
