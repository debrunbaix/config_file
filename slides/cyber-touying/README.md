# Thème Cyber pour Touying

Thème de présentation Typst pour la cybersécurité : fond sombre, accents rouge
et vert, texte blanc. Code colorisé, tableaux, images, numérotation des pages et
logo fixe en haut à droite.

Testé avec **Typst 0.15** et **Touying 0.7.4**.

---

## 1. Installation

### Typst

```bash
# macOS
brew install typst
# Windows
winget install --id Typst.Typst
# Linux (ou n'importe où) — binaire autonome
curl -fsSL https://typst.community/typst-install/install.sh | sh
```

Vérifier : `typst --version`.

Touying n'a pas besoin d'être installé : Typst télécharge le paquet tout seul à
la première compilation, à partir de la ligne `#import "@preview/touying:0.7.4"`
qui se trouve en tête de `cyber.typ`.

### Arborescence

Garder les fichiers ensemble, les chemins sont relatifs :

```
mon-deck/
├── cyber.typ            ← le thème
├── cyber-dark.tmTheme   ← les couleurs de la coloration syntaxique
├── test.typ             ← deck de test, une slide par fonctionnalité
├── demo.typ             ← deck d'exemple complet (audit SSRF)
└── assets/
    ├── logo.svg         ← à remplacer par ton logo
    └── schema.svg       ← image d'exemple
```

`cyber-dark.tmTheme` **doit** rester à côté de `cyber.typ` : sans lui, Typst
applique son thème de coloration clair, illisible sur fond sombre.

---

## 2. Compiler

```bash
typst compile test.typ            # produit test.pdf
typst watch test.typ              # recompile à chaque sauvegarde
typst compile test.typ deck.pdf   # nom de sortie explicite
typst compile test.typ "img/{p}.png" --ppi 150   # une image par slide
```

Dans VS Code, l'extension **Tinymist Typst** donne l'aperçu en direct
(`Ctrl+K V`). Pour présenter, n'importe quel lecteur PDF en plein écran fait
l'affaire ; `pdfpc` gère en plus l'écran présentateur.

---

## 3. Squelette minimal

```typst
#import "cyber.typ": *

#show: cyber-theme.with(
  aspect-ratio: "16-9",
  classification: "TLP:AMBER",
  config-info(
    title: [Titre de la présentation],
    subtitle: [Sous-titre],
    author: [Prénom NOM],
    institution: [Mon organisation],
    date: [5 septembre 2026],
    short-title: [Titre court],
    logo: image("assets/logo.svg", height: 1.4em),
  ),
)

#title-slide()
#outline-slide()

= Ma première section     // → slide de section automatique, numérotée 01

== Ma première slide      // → slide de contenu, titre en en-tête

Du contenu.
```

La structure du deck suit les titres : `=` crée une **section** (slide pleine
page avec le gros numéro rouge), `==` crée une **slide de contenu** dont le
titre part dans l'en-tête. Pas besoin d'appeler `#slide` à la main.

---

## 4. Les fonctionnalités

### Code colorisé

Un bloc entre trois accents graves est mis en forme automatiquement. Le langage
placé après les accents pilote la coloration et l'étiquette affichée.

````typst
```py
def check(host): return host in ALLOWED
```
````

Pour un titre de fichier et des lignes surlignées :

```typst
#code(title: "config/nginx.conf", highlight: (3, 4))[
  ```nginx
  ...
  ```
]
```

Options de `#code` : `title`, `highlight: (3, 4)`, `numbering: false`,
`accent: palette.red`.

Pour une sortie de commande, sans coloration ni numéros de ligne :

```typst
#terminal(title: "root@debian")[
  ```
  $ nmap -sV -p 443 cible.local
  ```
]
```

### Encadrés

```typst
#threat(title: [Menace])[ Ce qui casse sans la mesure. ]
#defense(title: [Contre-mesure])[ Ce qui est en place, et la preuve. ]
#note(title: [Référentiel])[ ANSSI-PG-078, R29. ]
```

### Constats et criticités

```typst
#sev("critique")   // badge : critique / haute / moyenne / basse / info

#finding(id: "T-01", severity: "critique")[
  Intitulé du constat
][
  Description, impact, correctif.
]
```

### Tableaux

Un `#table` standard est déjà stylé : en-tête rouge, lignes alternées, filets
discrets. Rien à configurer.

```typst
#table(
  columns: (auto, 1fr, auto),
  table.header([Réf.], [Constat], [Criticité]),
  [T-01], [Premier constat], sev("critique"),
)
```

### Images

```typst
#screenshot("assets/schema.svg", caption: [Légende])   // encadrée + légende
#image("assets/schema.svg", width: 70%)                // brute
```

### Deux colonnes

```typst
#slide(composer: (1fr, 1fr))[
  Colonne de gauche
][
  Colonne de droite
]
```

### Chiffres-clés, emphases, apparitions

```typst
#stat("3", "critiques", accent: palette.red)
#bad[texte rouge]   #good[texte vert]   #alert[équivalent de #bad]
Premier point #pause Deuxième point     // apparition au clic
```

### Slides spéciales

```typst
#focus-slide[ Une phrase seule à l'écran. ]
#focus-slide(fill: palette.green-deep)[ La même, en vert. ]
#ending-slide(title: [Merci])[ prenom.nom\@example.org ]
```

---

## 5. Personnaliser

### Les couleurs

Tout part du dictionnaire `palette`, en tête de `cyber.typ` :

```typst
#let palette = (
  bg: rgb("#0B0F14"),      // fond des slides
  surface: rgb("#141B23"), // encadrés, lignes de tableau
  code-bg: rgb("#10161D"), // fond des blocs de code
  fg: rgb("#E8EEF4"),      // texte
  muted: rgb("#8A97A6"),   // texte secondaire
  red: rgb("#FF4D4D"),     // accent 1
  green: rgb("#35D07F"),   // accent 2
  ...
)
```

Changer une valeur repeint le deck entier. Deux exceptions : le fond des blocs
de code et les couleurs des mots-clés sont aussi définis dans
`cyber-dark.tmTheme`, à ajuster en parallèle si tu changes `code-bg` ou les
accents.

### Les polices

En dessous de la palette :

```typst
#let font-sans = ("Lato", "Fira Sans", "Inter", "Helvetica Neue", "DejaVu Sans")
#let font-mono = ("JetBrains Mono", "Fira Code", "Cascadia Code", "DejaVu Sans Mono")
```

C'est une liste de repli : la première police installée sur la machine gagne.
Mettre la tienne en tête. `typst fonts` liste ce qui est disponible.

### Le logo

Remplacer `assets/logo.svg`. Il est affiché en haut à droite de chaque slide de
contenu et sur la slide de titre, à la hauteur donnée dans `config-info` :

```typst
logo: image("assets/logo.png", height: 1.4em)
```

Pour l'enlever : ne pas passer `logo`, ou `header-right: none` dans
`cyber-theme.with(...)`.

### Le pied de page

| Paramètre de `cyber-theme` | Effet |
|---|---|
| `classification: "TLP:AMBER"` | encadré central ; `none` pour l'enlever |
| `progress-bar: false` | supprime la barre de progression |
| `footer-left: self => [...]` | remplace le titre court en bas à gauche |
| `title: self => [...]` | remplace le titre courant dans l'en-tête |

La numérotation `3 / 15` est à droite. Pour la modifier, éditer la fonction
`footer` dans la section 5 de `cyber.typ`.

### Les marges

Trois constantes en tête de fichier : `margin-x`, `margin-top`,
`margin-bottom`. Elles sont volontairement en points absolus, parce que Touying
étale l'en-tête et le pied sur toute la largeur de la page et qu'il faut les
réaligner exactement sur ces valeurs.

---

## 6. Format 4/3

```typst
#show: cyber-theme.with(aspect-ratio: "4-3", ...)
```

---

## 7. Notes de compatibilité

- Les blocs `#code(...)` et `#terminal(...)` passent par une règle `show` locale
  parce que le champ `.lines` d'un `raw` n'est pas lisible sur un élément non
  réalisé. C'est la raison pour laquelle ces fonctions prennent un bloc de code
  entre crochets et non une chaîne.
- `*gras*` reste blanc. Touying colore le gras en rouge par défaut ; ce
  comportement est désactivé via `show-strong-with-alert: false`. Pour du rouge,
  utiliser `#bad[...]` ou `#alert[...]`.
- La numérotation des sections utilise un compteur dédié (`section-counter`) :
  au moment où la slide de section est générée, le compteur de titres de Typst
  vaut encore 0.
