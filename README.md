# How to use in your thesis

Clone repo into your thesis directory.

```typst
#import "typst-aalto-bsc-template/lib.typ": *

#show: styling

#set text(lang: "en")

#intro(
  title: "Aalto bachelor's thesis template for Typst",
  author: "Teemu Teekkari",
  major: "Textile engineering",
  major-fi: "Tekstiilitekniikka",
  code: "SCI1234",
  teacher: "Leslie Lamport",
  supervisor: "Jaakko Turpela",
  summary: lorem(100),
  summary-fi: lorem(100),
  keywords: ("Typst", "typesetting"),
  keywords-fi: ("Typst", "ladonta"),
  language: "English",
  language-fi: "Englanti",
  abbreviations: (("NTSC", "Never The Same Color"), ("PAL", "Perfect At Last")),
  date: datetime.today(),
)

= Introduction

= Foo

= Bar

== Baz

= Conclusion

#end(
  "../bibliography.bib",
  [
    #lorem(100)
  ],
)
```

The arguments ending in `-fi` are not required if the document language is Finnish.
