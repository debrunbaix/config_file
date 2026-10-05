# Oteria-Report

An unofficial template for Oteria Cyber School report.

## Usage

```typ
#show: oteria-report.with(
  title: "Rendu Oteria",
  subtitle: "Développement d'un malware en Brainrot",
  lang: "fr",
  authors: ("Moi", "Lui"),
  //mentors: ("Prof", "Mentors 2"), //pour vos tuteurs d'alternance
  logo: none,
  place: "Oteria",
  date: "JJ/MM/AAAA",
  table-of-contents: true,
  bibliography: bibliography("refs.yaml"),
)
```

### Options

| Argument          | Type            | Description                                |
|-------------------|-----------------|--------------------------------------------|
| title             | [string](https://typst.app/docs/reference/foundations/str/)          | The title of the internship report         |
| subtitle          | [string](https://typst.app/docs/reference/foundations/str/)          | The subtitle of the internship report      |
| lang              | [string](https://typst.app/docs/reference/foundations/str/)          | French ("fr") or English ("en")            |
| authors           | [string](https://typst.app/docs/reference/foundations/str/) or [array](https://typst.app/docs/reference/foundations/array/) | A string if there is one author and an array if there are many authors |
| mentors           | [string](https://typst.app/docs/reference/foundations/str/) or [array](https://typst.app/docs/reference/foundations/array/) | A string if there is one mentors and an array if there are many mentors |
| logo              | [content](https://typst.app/docs/reference/foundations/content/)  or [none](https://typst.app/docs/reference/foundations/none/)  | The logo, it is recommand to use a height of 50pt
| place             | [string](https://typst.app/docs/reference/foundations/str/)          | The place of the internship                |
| date             | [string](https://typst.app/docs/reference/foundations/str/)          | The date of the internship                |
| table-of-contents | [bool](https://typst.app/docs/reference/foundations/bool/)   | True to display the table of contents      |
| bibliography      | [content](https://typst.app/docs/reference/foundations/content/)  or [none](https://typst.app/docs/reference/foundations/none/)        |  The result of a call to the bibliography function or none |
