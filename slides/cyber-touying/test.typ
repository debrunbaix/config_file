// ============================================================================
//  test.typ — deck minimal qui teste chaque brique du thème, une par une.
//  Compiler :  typst watch test.typ
// ============================================================================

#import "cyber.typ": *

#show: cyber-theme.with(
  aspect-ratio: "16-9", // ou "4-3"
  classification: "TLP:CLEAR", // texte au centre du pied ; none pour l'enlever
  config-info(
    title: [Titre de la présentation],
    subtitle: [Sous-titre optionnel],
    author: [Prénom NOM],
    institution: [Mon organisation],
    date: [5 septembre 2026],
    short-title: [Titre court], // affiché en bas à gauche
    logo: image("assets/logo.svg", height: 1.4em), // logo en haut à droite
  ),
)

// --- 1. Slide de titre ------------------------------------------------------
#title-slide()

// --- 2. Sommaire (généré depuis les titres de niveau 1) ---------------------
#outline-slide()

// --- 3. Une section : chaque `=` produit une slide de section automatique ---
= Texte et mise en forme

// --- 4. Une slide : chaque `==` produit une slide de contenu ----------------
== Texte, listes, emphases

Du texte courant, du *gras* blanc, de l'#emph[italique], du `code inline`,
un #link("https://typst.app")[lien], du #bad[rouge d'alerte] et du
#good[vert de validation].

- Puce de premier niveau
  - Puce de deuxième niveau
+ Liste numérotée
+ Deuxième élément

== Encadrés

#threat(title: [Menace])[
  Ce qui casse si la mesure n'est pas en place.
]

#defense(title: [Contre-mesure])[
  Ce qui est mis en place, et la preuve que ça tient.
]

#note(title: [Référentiel])[
  ANSSI-PG-078, R29.
]

= Code

== Bloc de code automatique

Tout bloc délimité par trois accents graves est stylé tout seul. Le langage
indiqué après les accents pilote la coloration et l'étiquette.

```py
def check(host: str) -> bool:
    """Vérifie l'hôte contre l'allow-list."""
    return host in ALLOWED   # commentaire
```

== Bloc de code avec titre et lignes surlignées

#code(title: "config/nginx.conf", highlight: (3, 4))[
  ```nginx
  server {
      listen 443 ssl;
      add_header Strict-Transport-Security "max-age=31536000";
      add_header X-Frame-Options DENY;
  }
  ```
]

== Sortie de terminal

#terminal(title: "root@debian")[
  ```
  $ nmap -sV -p 443 cible.local
  PORT    STATE SERVICE  VERSION
  443/tcp open  ssl/http nginx 1.24.0
  ```
]

= Données et visuels

== Tableau

#table(
  columns: (auto, 1fr, auto, auto),
  align: (left, left, center, center),
  table.header([Réf.], [Constat], [Criticité], [Statut]),
  [T-01], [Premier constat], sev("critique"), good[Corrigé],
  [T-02], [Deuxième constat], sev("haute"), good[Corrigé],
  [T-03], [Troisième constat], sev("moyenne"), bad[Ouvert],
  [T-04], [Quatrième constat], sev("basse"), bad[Ouvert],
)

== Chiffres-clés

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  stat("12", "constats"),
  stat("3", "critiques", accent: palette.red),
  stat("85%", "corrigés", accent: palette.green),
)

== Fiche de constat

#finding(id: "T-01", severity: "critique")[
  Intitulé du constat
][
  Description, impact, conditions d'exploitation.

  *Correctif* — la mesure retenue et sa validation.
]

== Image et deux colonnes

#slide(composer: (1fr, 1fr))[
  La colonne de gauche reçoit le premier bloc de contenu, celle de droite le
  second. Les proportions se règlent dans `composer`.
][
  #screenshot("assets/schema.svg", caption: [Légende de la figure])
]

== Apparition progressive

Premier point visible d'emblée.

#pause

Deuxième point, après un clic.

#pause

Troisième point.

// --- 5. Slides spéciales ----------------------------------------------------
#focus-slide[
  Une phrase qu'on veut voir seule à l'écran.
]

#focus-slide(fill: palette.green-deep)[
  La même chose, en vert.
]

#ending-slide(title: [Merci])[
  prenom.nom\@example.org
]
