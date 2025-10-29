#import "@preview/abbr:0.2.3"
#import "@preview/linguify:0.4.2": *

#let lang-data = toml("lang.toml")

#let l(key) = linguify(key, from: lang-data)
#let l-fi(key) = linguify(key, from: lang-data, lang: "fi")

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

#let header(l: l) = {
  [
    #l("aalto")\
    #l("sci")\
    #l("program")
  ]
}

#let summary_page(
  title: "Title",
  author: "Jaakko Turpela",
  major: "Major",
  code: "SCI1234",
  teacher: "Teacher",
  supervisor: "Supervisor",
  summary: lorem(100),
  keywords: (),
  language: "English",
  date: datetime.today,
  l: l,
) = {
  grid(
    columns: (70%, 30%),
    align: (left, right),
    header(l: l), [#l("summary")],
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

  let sorted_keywords = keywords.sorted(key: a => lower(a))
  let sorted_capitalized_keywords = (
    for i in range(sorted_keywords.len()) {
      if i == 0 {
        (
          upper(sorted_keywords.at(i).slice(0, 1))
            + sorted_keywords.at(i).slice(1)
        )
      } else {
        ", " + sorted_keywords.at(i)
      }
    }
  )

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
    [#l("keywords")], sorted_capitalized_keywords,
    [#l("language")], language
  )
}

#let intro(
  title: "Title",
  author: "Jaakko Turpela",
  major: "Major",
  major-fi: "Pääaine",
  code: "SCI1234",
  teacher: "Teacher",
  supervisor: "Supervisor",
  summary: lorem(100),
  summary-fi: lorem(100),
  keywords: (),
  keywords-fi: (),
  language: "English",
  language-fi: "Englanti",
  abbreviations: (),
  date: datetime.today(),
) = {
  let date_translated = (
    date.display("[day padding:none]. ")
      + l(lower(date.display("[month repr:long]")))
      + date.display(" [year]")
  )

  header()

  align(center + horizon)[
    #text(size: 22pt)[
      *#title*
      \ \ \ \
    ]
    #text(size: 18pt)[
      *#l("thesis")*
      \ \ \
      *#date_translated*
      \ \ \ \ \ \
      *#author*
    ]]

  if (context text.lang) != "fi" [
    #pagebreak()

    #summary_page(
      title: title,
      author: author,
      major: major-fi,
      code: code,
      teacher: teacher,
      supervisor: supervisor,
      summary: summary-fi,
      keywords: keywords-fi,
      language: language-fi,
      date: date.display("[day padding:none]. ")
        + l-fi(lower(date.display("[month repr:long]")))
        + date.display(" [year]"),
      l: l-fi,
    )
  ]

  pagebreak()

  summary_page(
    title: title,
    author: author,
    major: major,
    code: code,
    teacher: teacher,
    supervisor: supervisor,
    summary: summary,
    keywords: keywords,
    language: language,
    date: date_translated,
  )

  pagebreak()

  // FIXME: remove fill
  show outline.entry.where(level: 1): it => {
    v(22pt, weak: true)
    [#strong(it)]
  }

  outline()

  pagebreak()

  abbr.list(title: l("list_of_abbreviations"))
  abbr.make(..abbreviations)

  pagebreak()
}

#let end(bibfile, appendix) = {
  pagebreak(weak: true)

  show bibliography: bib => {
    show "vsk.": "vol."
    bib
  }

  bibliography(bibfile, style: "ieee-aalto.csl")

  pagebreak(weak: true)

  counter(heading).update(0)
  set heading(numbering: "A1")

  appendix
}
