// ============================================================================
//  CYBER — thème Touying pour présentations de cybersécurité
//  Fond sombre · accents rouge & vert · texte blanc
//  Compatible Touying 0.7.x / Typst 0.13+
// ============================================================================

#import "@preview/touying:0.7.4": *

// ----------------------------------------------------------------------------
// 1. PALETTE
//    Tout part d'ici. Changer une valeur suffit à repeindre le thème entier.
// ----------------------------------------------------------------------------

#let palette = (
  bg: rgb("#0B0F14"), // fond des slides
  surface: rgb("#141B23"), // encadrés, lignes paires des tableaux
  surface-2: rgb("#1B2430"), // lignes impaires, en-tête de code
  code-bg: rgb("#10161D"), // fond des blocs de code (= tmTheme)
  line: rgb("#2A3541"), // filets, bordures
  fg: rgb("#E8EEF4"), // texte courant
  muted: rgb("#8A97A6"), // texte secondaire, numéros de ligne
  red: rgb("#FF4D4D"), // accent 1 — menace, attaque, échec
  red-soft: rgb("#FF9E9E"),
  red-deep: rgb("#5C1414"), // fond des encadrés rouges
  green: rgb("#35D07F"), // accent 2 — défense, succès, validé
  green-soft: rgb("#7CE3AC"),
  green-deep: rgb("#0F3D26"), // fond des encadrés verts
  amber: rgb("#E5B84B"), // criticité moyenne uniquement
)

// Marges de page. Utilisées à la fois par `config-page` et pour réaligner
// l'en-tête et le pied, que Touying étale sur toute la largeur de la page.
#let margin-x = 50pt
#let margin-top = 78pt
#let margin-bottom = 46pt

// Polices : listes de repli. La première installée sur la machine gagne.
#let font-sans = ("Lato", "Fira Sans", "Inter", "Helvetica Neue", "DejaVu Sans")
#let font-mono = (
  "JetBrains Mono",
  "Fira Code",
  "Cascadia Code",
  "DejaVu Sans Mono",
)

// ----------------------------------------------------------------------------
// 2. BLOCS DE CODE
//    Un seul moteur de rendu, utilisé par la règle globale ET par `#code(...)`.
// ----------------------------------------------------------------------------

#let _lang-label = (
  py: "Python",
  python: "Python",
  sh: "Shell",
  bash: "Bash",
  zsh: "Zsh",
  ps1: "PowerShell",
  powershell: "PowerShell",
  c: "C",
  cpp: "C++",
  rs: "Rust",
  go: "Go",
  js: "JavaScript",
  ts: "TypeScript",
  java: "Java",
  php: "PHP",
  rb: "Ruby",
  sql: "SQL",
  yaml: "YAML",
  yml: "YAML",
  json: "JSON",
  xml: "XML",
  html: "HTML",
  toml: "TOML",
  ini: "INI",
  nginx: "nginx",
  dockerfile: "Dockerfile",
  diff: "diff",
  asm: "Assembly",
  typ: "Typst",
)

#let _render-code(
  it,
  title: none,
  numbering: true,
  highlight: (),
  accent: palette.green,
) = {
  let lang = if it.lang == none { none } else {
    _lang-label.at(lower(it.lang), default: upper(it.lang))
  }
  let caption = if title != none { title } else { lang }

  block(
    width: 100%,
    fill: palette.code-bg,
    radius: 4pt,
    stroke: 0.5pt + palette.line,
    clip: true,
    breakable: false,
    {
      set block(spacing: 0pt)
      set par(spacing: 0pt)
      // --- barre de titre ---------------------------------------------------
      if caption != none {
        block(
          width: 100%,
          fill: palette.surface-2,
          inset: (x: 0.7em, y: 0.4em),
          {
            set text(size: 0.62em, fill: palette.muted, font: font-mono)
            box(
              circle(radius: 0.28em, fill: palette.red.transparentize(35%)),
            )
            h(0.35em)
            box(circle(radius: 0.28em, fill: palette.amber.transparentize(35%)))
            h(0.35em)
            box(circle(radius: 0.28em, fill: palette.green.transparentize(35%)))
            h(0.8em)
            caption
            if title != none and lang != none {
              h(1fr)
              text(fill: accent, lang)
            }
          },
        )
      }

      // --- corps ------------------------------------------------------------
      block(
        width: 100%,
        inset: (x: 0.7em, y: 0.6em),
        {
          set std.align(left)
          set text(font: font-mono, size: 0.72em, fill: palette.fg)
          set par(leading: 0.62em, justify: false)
          grid(
            columns: if numbering { (1.8em, 1fr) } else { (1fr,) },
            column-gutter: 0.6em,
            row-gutter: 0pt,
            ..it
              .lines
              .map(l => {
                let hl = l.number in highlight
                let cells = ()
                if numbering {
                  cells.push(block(
                    width: 100%,
                    fill: if hl { accent.transparentize(85%) },
                    inset: (y: 0.1em),
                    align(
                      right,
                      text(
                        fill: if hl { accent } else { palette.muted },
                        str(l.number),
                      ),
                    ),
                  ))
                }
                cells.push(block(
                  width: 100%,
                  fill: if hl { accent.transparentize(88%) },
                  inset: (y: 0.1em, left: 0.2em),
                  l.body,
                ))
                cells
              })
              .flatten()
          )
        },
      )
    },
  )
}

/// Bloc de code avec barre de titre personnalisée et lignes surlignables.
///
/// ```typ
/// #code(title: "exploit.py", highlight: (4, 5))[
///   ```py
///   ...
///   ```
/// ]
/// ```
#let code(
  title: none,
  numbering: true,
  highlight: (),
  accent: palette.green,
  it,
) = {
  show raw.where(block: true): e => _render-code(
    e,
    title: title,
    numbering: numbering,
    highlight: highlight,
    accent: accent,
  )
  it
}

/// Sortie de terminal : ni coloration, ni numéros de ligne.
#let terminal(title: "shell", it) = {
  show raw.where(block: true): e => _render-code(e, title: title, numbering: false)
  it
}

// ----------------------------------------------------------------------------
// 3. COMPOSANTS MÉTIER
// ----------------------------------------------------------------------------

/// Badge de criticité : #sev("critique") / "haute" / "moyenne" / "basse" / "info"
#let sev(niveau) = {
  let c = (
    critique: palette.red,
    haute: rgb("#FF8A3D"),
    moyenne: palette.amber,
    basse: palette.green,
    info: palette.muted,
  ).at(lower(niveau), default: palette.muted)
  box(
    fill: c.transparentize(80%),
    stroke: 0.6pt + c,
    inset: (x: 0.45em, y: 0.22em),
    radius: 2pt,
    baseline: 0.15em,
    text(size: 0.6em, weight: "bold", fill: c, tracking: 0.06em, upper(niveau)),
  )
}

// Encadré générique
#let _callout(accent, icon, title, body) = block(
  width: 100%,
  fill: accent.transparentize(90%),
  stroke: (left: 3pt + accent),
  radius: (right: 3pt),
  inset: (x: 0.8em, y: 0.6em),
  {
    if title != none {
      text(fill: accent, weight: "bold")[#icon #h(0.3em) #title]
      v(0.3em, weak: true)
    }
    body
  },
)

/// Encadré rouge — menace, vulnérabilité, mauvaise pratique.
#let threat(title: none, body) = _callout(palette.red, text(weight: "bold")[!], title, body)

/// Encadré vert — contre-mesure, bonne pratique, résultat validé.
#let defense(title: none, body) = _callout(
  palette.green,
  sym.checkmark.heavy,
  title,
  body,
)

/// Encadré neutre — remarque, rappel, référentiel.
#let note(title: none, body) = _callout(palette.muted, text(weight: "bold")[i], title, body)

/// Fiche de vulnérabilité complète.
#let finding(id: none, severity: "moyenne", title, body) = block(
  width: 100%,
  fill: palette.surface,
  stroke: 0.5pt + palette.line,
  radius: 4pt,
  inset: 0.8em,
  {
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      {
        if id != none {
          text(size: 0.65em, font: font-mono, fill: palette.muted, id)
          linebreak()
        }
        text(weight: "bold", fill: palette.fg, title)
      },
      sev(severity),
    )
    v(0.45em, weak: true)
    line(length: 100%, stroke: 0.5pt + palette.line)
    v(0.45em, weak: true)
    set text(size: 0.85em)
    body
  },
)

/// Chiffre-clé mis en avant.
#let stat(value, label, accent: palette.red) = block(
  width: 100%,
  fill: palette.surface,
  stroke: (bottom: 2pt + accent),
  radius: (top: 3pt),
  inset: (x: 0.7em, y: 0.7em),
  align(
    center,
    {
      text(size: 1.8em, weight: "bold", fill: accent, value)
      linebreak()
      text(size: 0.7em, fill: palette.muted, label)
    },
  ),
)

/// Texte en rouge (alerte) et en vert (validation).
#let bad(body) = text(fill: palette.red, weight: "bold", body)
#let good(body) = text(fill: palette.green, weight: "bold", body)

/// Capture d'écran encadrée, avec légende optionnelle.
#let screenshot(path, caption: none, width: 100%) = figure(
  block(
    stroke: 0.5pt + palette.line,
    radius: 3pt,
    clip: true,
    image(path, width: width),
  ),
  caption: caption,
)

// ----------------------------------------------------------------------------
// 4. SLIDES
// ----------------------------------------------------------------------------

#let slide(
  title: auto,
  header: auto,
  footer: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto { self.store.align = align }
  if title != auto { self.store.title = title }
  if header != auto { self.store.header = header }
  if footer != auto { self.store.footer = footer }
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

/// Slide de titre.
#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(self, config, config-page(
      margin: (x: margin-x, y: 52pt),
      header: none,
      footer: none,
    ))
    self.store.title = none
    let info = self.info + args.named()

    let body = {
      // Filet décoratif rouge → vert
      place(top + left, dy: -0.6em, line(
        length: 100%,
        stroke: 2pt
          + gradient.linear(palette.red, palette.green, palette.bg, angle: 0deg),
      ))
      if info.logo != none {
        place(top + right, dy: 0.6em, info.logo)
      }

      set std.align(left + horizon)
      block(width: 82%, {
        if info.institution != none {
          text(
            size: 0.62em,
            fill: palette.green,
            font: font-mono,
            tracking: 0.18em,
            upper(info.institution),
          )
          v(0.7em, weak: true)
        }
        block(
          width: 100%,
          above: 0pt,
          below: 0pt,
          par(
            leading: 0.42em,
            text(size: 1.8em, weight: "bold", fill: palette.fg, info.title),
          ),
        )
        if info.subtitle != none {
          v(0.45em, weak: true)
          block(width: 100%, above: 0pt, below: 0pt, par(
            leading: 0.55em,
            text(size: 0.95em, fill: palette.muted, info.subtitle),
          ))
        }
        v(1em)
        block(width: 42%, line(length: 100%, stroke: 1.5pt + palette.red))
        v(0.7em)
        set text(size: 0.72em, fill: palette.muted)
        let authors = if type(info.author) == array { info.author } else {
          (info.author,)
        }
        text(fill: palette.fg, authors.join(" · "))
        if info.date != none {
          [ #h(0.6em) #sym.bullet #h(0.6em) #utils.display-info-date(self) ]
        }
        if extra != none {
          linebreak()
          v(0.2em, weak: true)
          extra
        }
      })
    }
    touying-slide(self: self, body)
  },
)

/// Compteur de sections, indépendant du compteur de titres.
#let section-counter = counter("cyber-section")

/// Slide de section : gros numéro rouge + intitulé.
#let new-section-slide(config: (:), ..args, body) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(
      self,
      config,
      config-page(margin: (x: margin-x, y: 60pt), header: none),
    )
    self.store.title = none
    let content = {
      set std.align(left + horizon)
      section-counter.step()
      block({
        context text(
          size: 3.4em,
          weight: "bold",
          fill: palette.red.transparentize(60%),
          font: font-mono,
          section-counter.display(n => if n < 10 { "0" + str(n) } else {
            str(n)
          }),
        )
        v(-0.35em)
        text(
          size: 1.5em,
          weight: "bold",
          fill: palette.fg,
          utils.display-current-heading(level: 1, numbered: false),
        )
        v(0.5em)
        block(width: 30%, line(length: 100%, stroke: 1.5pt + palette.green))
      })
    }
    touying-slide(self: self, config: config, content)
  },
)

/// Sommaire : numéros rouges, intitulés de niveau 1.
#let outline-slide(config: (:), title: [Sommaire], ..args) = (
  touying-slide-wrapper(self => {
    self.store.title = title
    let content = context {
      show link: it => it // pas de soulignement dans le sommaire
      let sections = query(heading.where(level: 1))
      grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 0.9em,
        ..sections
          .enumerate()
          .map(((i, h)) => (
            text(
              font: font-mono,
              weight: "bold",
              fill: palette.red,
              if i < 9 { "0" + str(i + 1) } else { str(i + 1) },
            ),
            link(h.location(), text(fill: palette.fg, h.body)),
          ))
          .flatten()
      )
    }
    touying-slide(
      self: self,
      config: config,
      std.align(self.store.align, content),
    )
  })
)

/// Slide d'accroche pleine page (fond rouge par défaut).
#let focus-slide(config: (:), fill: palette.red-deep, accent: palette.red, body) = (
  touying-slide-wrapper(self => {
    self = utils.merge-dicts(
      self,
      config-common(freeze-slide-counter: true),
      config-page(fill: fill, margin: 60pt, header: none, footer: none),
    )
    set text(fill: white, weight: "bold", size: 1.5em)
    touying-slide(
      self: self,
      config: config,
      std.align(horizon + center, body),
    )
  })
)

/// Slide de fin.
#let ending-slide(config: (:), title: none, body) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(self, config-page(header: none, footer: none))
    self.store.title = none
    let content = {
      set std.align(center + horizon)
      if title != none {
        text(size: 2em, weight: "bold", fill: palette.fg, title)
        v(0.4em)
        block(width: 18%, line(length: 100%, stroke: 1.5pt + palette.green))
        v(0.6em)
      }
      set text(fill: palette.muted, size: 0.85em)
      body
    }
    touying-slide(self: self, config: config, content)
  },
)

// ----------------------------------------------------------------------------
// 5. LE THÈME
// ----------------------------------------------------------------------------

/// Thème Cyber.
///
/// ```typ
/// #show: cyber-theme.with(
///   aspect-ratio: "16-9",
///   classification: "TLP:AMBER",
///   config-info(title: [...], author: [...], logo: image("assets/logo.svg")),
/// )
/// ```
#let cyber-theme(
  aspect-ratio: "16-9",
  align: top + left,
  // texte affiché en bas au centre (marquage de confidentialité)
  classification: none,
  // barre de progression verte en bas de slide
  progress-bar: true,
  // logo affiché en haut à droite de chaque slide de contenu
  header-right: self => self.info.logo,
  // titre courant, par défaut le titre de la slide
  title: self => utils.display-current-heading(depth: self.slide-level),
  footer-left: self => if self.info.short-title == auto {
    self.info.title
  } else { self.info.short-title },
  ..args,
  body,
) = {
  // -------- en-tête : titre à gauche, logo à droite, filet dégradé ----------
  let header(self) = {
    set std.align(top)
    if self.store.title != none {
      pad(x: margin-x, block(width: 100%, {
        grid(
          columns: (1fr, auto),
          column-gutter: 1em,
          align: (left + horizon, right + horizon),
          text(
            size: 1.25em,
            weight: "bold",
            fill: palette.fg,
            utils.call-or-display(self, self.store.title),
          ),
          block(height: 1.6em, utils.call-or-display(
            self,
            self.store.header-right,
          )),
        )
        v(0.35em, weak: true)
        line(
          length: 100%,
          stroke: 1.2pt
            + gradient.linear(
              palette.red,
              palette.green,
              palette.line,
              angle: 0deg,
            ),
        )
      }))
    }
  }

  // -------- pied : source à gauche, classification au centre, page à droite -
  let footer(self) = {
    set std.align(bottom)
    block(width: 100%, {
      pad(x: margin-x, {
        set text(size: 0.5em, fill: palette.muted)
        grid(
          columns: (1fr, auto, 1fr),
          align: (left + horizon, center + horizon, right + horizon),
          utils.call-or-display(self, self.store.footer-left),
          if self.store.classification != none {
            box(
              stroke: 0.5pt + palette.line,
              inset: (x: 0.5em, y: 0.2em),
              radius: 2pt,
              text(
                fill: palette.green,
                font: font-mono,
                tracking: 0.1em,
                self.store.classification,
              ),
            )
          },
          text(font: font-mono, context {
            text(fill: palette.fg, weight: "bold", str(
              utils.slide-counter.get().first(),
            ))
            text(fill: palette.muted, " / " + utils.last-slide-number)
          }),
        )
      })
      v(0.6em, weak: true)
      if self.store.progress-bar {
        components.progress-bar(
          height: 2pt,
          gradient.linear(palette.red, palette.green),
          palette.line,
        )
      }
    })
  }

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      fill: palette.bg,
      header: header,
      footer: footer,
      header-ascent: 22pt,
      footer-descent: 14pt,
      margin: (
        top: margin-top,
        bottom: margin-bottom,
        left: margin-x,
        right: margin-x,
      ),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      // `*gras*` reste blanc ; pour du rouge, utiliser #alert[...] ou #bad[...]
      show-strong-with-alert: false,
    ),
    config-colors(
      primary: palette.red,
      secondary: palette.green,
      tertiary: palette.surface,
      neutral-lightest: palette.fg,
      neutral-darkest: palette.bg,
    ),
    config-methods(
      init: (self: none, body) => {
        // --- typographie -----------------------------------------------------
        set text(font: font-sans, size: 20pt, fill: palette.fg, lang: "fr")
        set par(justify: false, leading: 0.72em, spacing: 1.1em)
        set strong(delta: 200)
        show strong: set text(fill: white)

        // --- coloration syntaxique -------------------------------------------
        set raw(theme: "cyber-dark.tmTheme")
        show raw.where(block: false): it => box(
          fill: palette.surface-2,
          inset: (x: 0.35em, y: 0.15em),
          outset: (y: 0.2em),
          radius: 2pt,
          text(font: font-mono, size: 0.85em, fill: palette.green-soft, it),
        )
        show raw.where(block: true): it => _render-code(it)

        // --- listes ----------------------------------------------------------
        set list(marker: (
          text(fill: palette.red, sym.triangle.filled.small.r),
          text(fill: palette.green, sym.circle.filled.small),
          text(fill: palette.muted, sym.dash.en),
        ))
        set enum(numbering: n => text(fill: palette.red, weight: "bold", str(n) + "."))

        // --- titres ----------------------------------------------------------
        show heading: set text(fill: palette.fg)
        show heading.where(level: 3): set text(size: 1.0em)

        // --- liens -----------------------------------------------------------
        // Liens : colorés, non soulignés (le soulignement alourdit une slide).
        show link: it => text(fill: palette.green-soft, it)

        // --- tableaux --------------------------------------------------------
        set table(
          stroke: (x, y) => (
            top: if y == 0 { 0pt } else { 0.5pt + palette.line },
            bottom: 0.5pt + palette.line,
          ),
          fill: (x, y) => if y == 0 { palette.surface-2 } else if calc.odd(y) {
            palette.bg
          } else { palette.surface },
          inset: (x: 0.6em, y: 0.45em),
        )
        show table.cell.where(y: 0): set text(
          weight: "bold",
          fill: palette.red,
          size: 0.9em,
        )
        show table: set text(size: 0.8em)

        // --- figures ---------------------------------------------------------
        show figure.caption: set text(size: 0.6em, fill: palette.muted)
        show figure.where(kind: table): set figure.caption(position: top)
        show footnote.entry: set text(size: 0.6em, fill: palette.muted)

        // --- citations -------------------------------------------------------
        show quote.where(block: true): it => block(
          width: 100%,
          inset: (left: 1em),
          stroke: (left: 2pt + palette.green),
          text(style: "italic", fill: palette.muted, it.body),
        )

        body
      },
      alert: (self: none, body) => bad(body),
    ),
    config-store(
      align: align,
      title: title,
      header: auto,
      header-right: header-right,
      footer: none,
      footer-left: footer-left,
      classification: classification,
      progress-bar: progress-bar,
    ),
    ..args,
  )

  body
}
