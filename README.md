# How to use in your thesis

Clone repo into your thesis directory.

```typst
#import "typst-aalto-bsc-template/lib.typ": *

#show: styling

#intro(
  "Aalto bachelor's thesis template for Typst",
  "Teemu Teekkari",
  "Textile engineering",
  "SCI1234",
  "Leslie Lamport",
  "Jaakko Turpela",
  lorem(100),
  ("Typst", "typesetting"),
  "English",
  (("NTSC", "Never The Same Color"), ("PAL", "Perfect At Last")),
  datetime.today(),
)
```
