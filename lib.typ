#import "@preview/abbr:0.1.1"
#import "@preview/linguify:0.4.1": *

#let lang-data = toml("lang.toml")

#let l(key) = linguify(key, from: lang-data)

#let styling(it) = {
  import "@preview/abbr:0.1.1"

  set text(font: "New Computer Modern", 12pt)

  set page(numbering: (..numbers) => {
    if numbers.pos().at(0) != 1 {
      numbering("1", numbers.pos().at(0))
    }
  })

  set par(leading: 0.8em, justify: true)

  set heading(numbering: "1.")
  show heading: set block(below: 1.5em, above: 2em)

  it
}

#let header = {
  [
    #l("aalto")\
    #l("sci")\
    #l("program")
  ]
}

#let intro(
  title: "Title",
  author: "Jaakko Turpela",
  major: "Major",
  code: "SCI1234",
  teacher: "Teacher",
  supervisor: "Supervisor",
  summary: lorem(100),
  keywords: (),
  language: "English",
  abbreviations: (),
  date: datetime.today(),
) = {
  let date = date.display("[day]. ") + l(
    lower(date.display("[month repr:long]")),
  ) + date.display(" [year]")

  header

  align(center + horizon)[
    #text(size: 22pt)[
      *#title*
      \ \ \ \
    ]
    #text(size: 18pt)[
      *#l("thesis")*
      \ \ \
      *#date*
      \ \ \ \ \ \
      *#author*
    ]]

  pagebreak()

  grid(
    columns: (50%, 50%),
    align: (left, right),
    header, [#l("summary")],
  )

  show table.cell: it => {
    if it.x == 0 and it.colspan == 1 {
      strong(it)
    } else {
      it
    }
  }

  set table(stroke: (x, y) => (
    left: if x == 0 {
      0.5pt
    } else {
      0pt
    },
    right: 0.5pt,
    top: if y == 5 or y == 7 {
      0.0pt
    } else {
      0.5pt
    },
    bottom: 0.5pt,
  ))

  table(
    columns: (25%, 75%),
    [#l("author")], author,
    [#l("title")], title,
    [#l("date")], date,
    [#l("nof_pages")], context [ #counter(page).final().at(0) ],
    [#l("major")], major,
    [#l("course_code")], code,
    [#l("main_teacher")], teacher,
    [#l("supervisor")], supervisor,
    table.cell(colspan: 2, summary),
    [#l("keywords")], keywords.join(", "),
    [#l("language")], language
  )

  pagebreak()

  show outline.entry: it => {
    if it.level == 1 {
      v(22pt, weak: true)
      [#strong(it.body) #box(width: 1fr) #strong(it.page)]
    } else {
      [#it.body #box(width: 1fr, it.fill) #it.page]
    }
  }

  outline(indent: auto, fill: repeat(". "))

  abbr.list()
  abbr.make(..abbreviations)

  pagebreak()
}

#let end(bibfile, appendix) = {
  pagebreak()

  bibliography(bibfile)

  pagebreak()

  counter(heading).update(0)
  set heading(numbering: "A")

  appendix
}
