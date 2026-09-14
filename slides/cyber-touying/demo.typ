#import "cyber.typ": *

#show: cyber-theme.with(
  aspect-ratio: "16-9",
  classification: "TLP:AMBER",
  config-info(
    title: [Exploitation d'une chaîne SSRF → RCE],
    subtitle: [Audit interne — périmètre applicatif Cloudbox],
    author: [Lisa HURTAUD],
    institution: [Oteria Cyber School],
    date: [12 septembre 2026],
    logo: image("assets/logo.svg", height: 1.4em),
  ),
)

#title-slide(extra: [Version 1.2 — diffusion restreinte comité sécurité])

#outline-slide()

= Contexte et périmètre

== Ce que couvre l'audit

Le périmètre porte sur l'application de partage de fichiers et sur les services
qu'elle interroge en interne. Trois environnements ont été testés, en boîte
grise, entre le 2 et le 9 septembre.

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  stat("14", "vulnérabilités"),
  stat("3", "critiques", accent: palette.red),
  stat("92%", "correctifs validés", accent: palette.green),
)

== Menace avant contre-mesure

#threat(title: [Sans filtrage de l'URL sortante])[
  Le service de prévisualisation accepte n'importe quelle URL fournie par
  l'utilisateur. Un attaquant atteint le service de métadonnées du cloud et
  récupère des identifiants #bad[valides pendant 6 heures].
]

#defense(title: [Après mise en place de l'allow-list])[
  Seuls trois domaines sont joignables. La tentative retourne un `403` et
  génère une alerte SIEM en #good[moins de 4 secondes].
]

#note(title: [Référentiel])[
  ANSSI-PG-078, R29 — validation systématique des URL fournies par un tiers.
]

= Exploitation

== La requête vulnérable

```py
import requests
from urllib.parse import urlparse

def fetch_preview(url: str) -> bytes:
    """Récupère la miniature d'un document distant."""
    parsed = urlparse(url)          # aucun contrôle sur le schéma
    if parsed.scheme not in ("http", "https"):
        raise ValueError("schéma non supporté")
    # L'hôte n'est jamais vérifié : SSRF possible
    return requests.get(url, timeout=5).content
```

== Le correctif, ligne par ligne

#code(title: "preview/fetcher.py", highlight: (5, 6, 7))[
  ```py
  ALLOWED = {"cdn.cloudbox.internal", "static.cloudbox.io"}

  def fetch_preview(url: str) -> bytes:
      parsed = urlparse(url)
      if parsed.hostname not in ALLOWED:
          audit.log("ssrf_attempt", url=url)
          raise PermissionError("hôte non autorisé")
      return requests.get(url, timeout=5).content
  ```
]

== Preuve d'exploitation

#terminal(title: "attaquant@kali")[
  ```
  $ curl -s 'https://app.cloudbox.io/preview?u=http://169.254.169.254/latest/meta-data/iam/'
  AccessKeyId     : ASIA4XKMPLQ7ZC3RV2NE
  SecretAccessKey : wJalr...
  Expiration      : 2026-09-08T14:22:31Z
  ```
]

#v(0.4em)

Les identifiants obtenus donnent un accès en lecture au bucket de sauvegarde,
soit #bad[2,3 To de données clients].

= Résultats

== Synthèse des découvertes

#table(
  columns: (auto, 1fr, auto, auto),
  align: (left, left, center, center),
  table.header([Réf.], [Vulnérabilité], [Criticité], [Statut]),
  [CBX-01], [SSRF sur le service de prévisualisation], sev("critique"), good[Corrigé],
  [CBX-02], [Jetons de session sans attribut `Secure`], sev("haute"), good[Corrigé],
  [CBX-03], [Énumération d'utilisateurs sur `/login`], sev("moyenne"), bad[Ouvert],
  [CBX-04], [En-tête `X-Frame-Options` absent], sev("basse"), good[Corrigé],
)

== Fiche détaillée

#finding(id: "CBX-01", severity: "critique")[
  SSRF sur le service de prévisualisation
][
  L'absence de validation de l'hôte permet d'atteindre le service de métadonnées
  de l'hébergeur et d'obtenir des identifiants temporaires. Exploitation
  confirmée en environnement de recette, non rejouée en production.

  *Correctif* — allow-list stricte, journalisation des tentatives, rotation des
  rôles IAM ramenée à 1 heure.
]

== Architecture ciblée

#slide(composer: (1fr, 1fr))[
  Le point d'entrée est public. Le service de prévisualisation, lui, se trouve
  dans le même sous-réseau que le point de métadonnées : rien ne les sépare.

  - Passerelle publique
  - Service de prévisualisation
  - Point de métadonnées #bad[joignable]
][
  #screenshot(
    "assets/schema.svg",
    caption: [Chemin d'attaque reconstitué depuis les journaux],
  )
]

== Ce qui reste à faire

+ Segmenter le réseau du service de prévisualisation
+ Généraliser la revue de code sur les appels sortants
+ Rejouer le test après la migration prévue en novembre

#focus-slide[
  Une allow-list n'est pas une défense en profondeur.
]

#ending-slide(title: [Questions ?])[
  lisa.hurtaud\@example.org — clé PGP : `9F2A 41C7 ... 0E5B`
]
