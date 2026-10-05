#import "@local/oteria-report:1.0.0": oteria-report

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

= First chapter
== Section 1

```c
#include <stdio.h>

int main()
{
    printf("Hey Oteria!");
    return 0;
}
```

#lorem(200) @Oteria

== Section 2

#lorem(200) @book-assembly

= Second chapter

#lorem(800)
