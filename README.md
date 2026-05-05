# Imposteur

**Imposteur** est un jeu social (inspiré d’Undercover) où chaque joueur reçoit secrètement un rôle et, selon son rôle, un mot… ou **aucun mot**.

Le but : discuter, donner des indices, voter et éliminer les joueurs pour faire gagner son camp, sans révéler trop tôt son identité.

> Application iOS (Swift / SwiftUI).

## Principe

Une partie se joue avec plusieurs joueurs autour d’un même téléphone.

- Les **Équipiers** reçoivent tous le **même mot**.
- Les **Imposteurs** reçoivent un **mot proche** (différent, mais dans le même univers) et doivent se fondre dans la masse.
- L’**Agent secret** (équivalent de *Mr White*) ne reçoit **aucun mot** et doit bluffer en se basant sur les indices donnés par les autres.

Les joueurs donnent chacun leur tour un indice (un mot ou une courte expression) lié à leur mot, puis un vote a lieu pour éliminer un joueur.

## Rôles

- **Équipier** : identifier les imposteurs et survivre.
- **Imposteur** : passer pour un équipier, semer le doute, éliminer les équipiers.
- **Agent secret** : survivre sans mot, puis tenter de deviner le mot des équipiers au bon moment.

## Conditions de victoire (résumé)

Les règles exactes peuvent varier selon les paramètres, mais l’esprit est :

- Les **Imposteurs** gagnent s’ils deviennent majoritaires / si les équipiers ne peuvent plus gagner.
- Les **Équipiers** gagnent si tous les imposteurs **et** l’agent secret sont éliminés.
- Si l’**Agent secret** est éliminé, il peut avoir une chance de **deviner le mot** des équipiers :
  - S’il devine correctement, il gagne.
  - Sinon la partie continue (sans agent secret).

## Paramètres de partie

Dans l’écran de création de partie, tu peux configurer :

- le **nombre de joueurs**
- le **nombre d’imposteurs**
- l’activation de l’**Agent secret** (à partir d’un certain nombre de joueurs)

## Séquence d’une partie

1. Création de la partie (paramètres + noms des joueurs)
2. Distribution des rôles (les joueurs récupèrent leur rôle l’un après l’autre)
3. Début de partie : chaque joueur donne un indice
4. Vote et élimination
5. Prochain round, jusqu’à une condition de victoire

## Note d’équilibrage

Pour éviter une situation injuste où le **premier joueur** serait l’Agent secret (sans mot) et devrait jouer à l’aveugle, l’application garantit que **le joueur 1 n’est jamais Agent secret** lors de la distribution des rôles.

## Développement

- Swift / SwiftUI
- Projet Xcode : `Imposteur.xcodeproj`

### Lancer le projet

1. Ouvrir `Imposteur.xcodeproj` dans Xcode
2. Sélectionner une cible iOS Simulator
3. Run (⌘R)

## Licence

À définir.
