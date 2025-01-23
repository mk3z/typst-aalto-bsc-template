#import "@preview/abbr:0.1.1"

#let styling(it) = {
  import "@preview/abbr:0.1.1"

  set text(font: "New Computer Modern", 12pt)

  set page(numbering: (..numbers) => {
    if numbers.pos().at(0) != 1 {
      numbering("1", numbers.pos().at(0))
    }
  })

  set par(leading: 0.8em)

  set heading(numbering: "1.")

  it
}

#let header = {
  [
    Aalto University\
    School of science\
    Bachelor's~Programme~in~Science~and~Technology
  ]
}

#let intro(
  title,
  author,
  major,
  code,
  teacher,
  supervisor,
  summary,
  keywords,
  language,
  abbreviations,
  date,
) = {
  let date = date.display("[day]. [month repr:long] [year]")

  header

  align(center + horizon)[
    #text(size: 22pt)[
      *#title*
      \ \ \ \
    ]
    #text(size: 18pt)[
      *Bachelor's thesis*
      \ \ \
      *#date*
      \ \ \ \ \ \
      *#author*
    ]]

  pagebreak()

  grid(
    columns: (50%, 50%),
    align: (left, right),
    header, [BACHELOR'S THESIS\ SUMMARY],
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
    [Author], author,
    [Thesis title], title,
    [Date], date,
    [No. of pages], context [ #counter(page).final().at(0) ],
    [Major], major,
    [Course code], code,
    [Main teacher], teacher,
    [Supervisor], supervisor,
    table.cell(colspan: 2, summary),
    [Keywords], keywords.join(", "),
    [Language], language
  )

  pagebreak()

  show outline.entry: it => {
    if it.level == 1 {
      strong(it.body)
    } else {
      [#it.body #box(width: 1fr, it.fill) #it.page]
    }
  }


  outline(indent: auto, fill: repeat(". "))

  pagebreak()

  abbr.list()
  abbr.make(abbreviations)

  pagebreak()
}
