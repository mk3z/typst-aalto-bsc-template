# How to use in your thesis

Clone repo into your thesis directory.

```typst
#import "typst-aalto-bsc-template/lib.typ": *

#show: styling

#intro(
  title: "Aalto bachelor's thesis template for Typst",
  author: "Teemu Teekkari",
  major: "Textile engineering",
  code: "SCI1234",
  teacher: "Leslie Lamport",
  supervisor: "Jaakko Turpela",
  summary: lorem(100),
  keywords: ("Typst", "typesetting"),
  language: "English",
  abbreviations: (("NTSC", "Never The Same Color"), ("PAL", "Perfect At Last")),
  date: datetime.today(),
)

= Introduction

= Foo

= Bar

== Baz

= Conclusion

#show: appendix

= Appendix
```
