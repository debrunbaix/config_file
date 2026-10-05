#let white-oteria = rgb("#FFFFFF")
#let black-oteria = rgb("#1C1C1C")
#let red-oteria = rgb("#FF2E66")
#let light-red-oteria = rgb("#FFEAEF")
#let light-gray-oteria = rgb("#ECECEC")

#let oteria-report(
  title: "",
  subtitle: "",
  lang: "fr",
  paper-size: "a4",
  authors: (),
  mentors: (),
  place: "",
  logo: none,
  date: "",
  table-of-contents: true,
  bibliography: none, 
  doc,
) = {
  if type(authors) == str {
    authors = (authors,)
  }
  if type(mentors) == str {
    mentors = (mentors,)
  }

  set document(
    title: title,
    author: authors.join(",")
  )
  set page(
    paper: paper-size,
    numbering: "1",
  )
  set par(
    leading: 0.8em,
    spacing: 1em,
    first-line-indent: 2em, 
    justify: true
  )
  set text(
    font: "IBM Plex Serif",
    lang: lang
  )
  set heading(numbering: "1.1.a")
  show heading.where(level: 1): set text(fill: red-oteria)
  show heading: set block(above: 1.8em, below: 1em)
  show heading: set text(font: "Changa One", fill: red-oteria)

  show raw.where(block: true): it => {
    set text(font: "IBM Plex Mono", size: 9.5pt)
    block(
      fill: light-gray-oteria,
      stroke: (left: 2.5pt + red-oteria),
      inset: (left: 12pt, top: 10pt, bottom: 10pt, right: 10pt),
      radius: 3pt,
      width: 100%,
      it
    )
  }

  show raw.where(block: false): it => {
    box(
      fill: light-red-oteria,
      inset: (x: 4pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      it
    )
  }

  page(
    numbering: none,
    {
      if(logo == none) {
        image("assets/oteria_cyber_school_logo.jpg", height: 50pt)
      } else {
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          image("assets/oteria_cyber_school_logo.jpg", height: 50pt),
          logo
        )
      }

      set align(center + horizon)
      line(length: 100%)
      //pad(y: 15pt, text(30pt, fill: red-oteria)[#title])
      pad(y: 15pt, text(30pt, font: "Changa One", fill: red-oteria)[#title])
      line(length: 100%)

      pad(top: 15pt, text(15pt, fill: black)[#subtitle])

      set align(center)
      if(authors != none and authors.len() >= 1) {
        if(authors.len() == 1 and lang == "en") {
          pad(top: 30pt, strong("Author"))
        } else if(authors.len() == 1 and lang == "fr"){
          pad(top: 30pt, strong("Auteur"))
        } else if(authors.len() != 1 and lang == "en"){
          pad(top: 30pt, strong("Authors"))
        } else if(authors.len() != 1 and lang == "fr"){
          pad(top: 30pt, strong("Auteurs"))
        }
        pad(top: 5pt,
          grid(
            columns: authors.len(),
            gutter: 10%,
            ..for author in authors { (author,) }
          )
        )
      }

      if(mentors != none and mentors.len() >= 1) {
        if(mentors.len() == 1 and lang == "en") {
          pad(top: 10pt, strong("Mentor"))
        } else if(mentors.len() == 1 and lang == "fr"){
          pad(top: 10pt, strong("Encadrant"))
        } else if(mentors.len() != 1 and lang == "en"){
          pad(top: 10pt, strong("Mentors"))
        } else if(mentors.len() != 1 and lang == "fr"){
          pad(top: 10pt, strong("Encadrants"))
        }
        pad(top: 5pt,
          grid(
            columns: mentors.len(),
            gutter: 10%,
            ..for author in mentors { (author,) }
          )
        )
      }

      set align(center + bottom)
      text()[#place \ #date]
    }
  )

  if(table-of-contents == true) {
    outline()
    pagebreak()
  }

  doc

  if(bibliography != none) {
    bibliography
  }
}
