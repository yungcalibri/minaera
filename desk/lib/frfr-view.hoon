/-  *frfr
/+  *mip
|_  [%0 neighbors=(set @p) scores=(mip @p @ score)]
::
++  page
  |=  kid=marl
  ^-  manx
  %-  document
  %-  frame
    kid
::  +document: HTML document with head content including all styles and scripts
++  document
  |=  kid=marl
  ^-  manx
  ;html
    ;head
      ;title:"%frfr"
      ;meta(charset "utf-8");
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/space-mono";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/space-mono/700.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/space-mono/700-italic.css";
      ;script
        =type  "module"
        =src   "https://unpkg.com/@yungcalibri/layout@0.1.5/umd/bundle.js";
      ;script
        =nomodule  ""
        =src       "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.js";
      ;script(src "https://unpkg.com/htmx.org@1.9.0");
      ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/json-enc.js");
      ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/include-vals.js");
      ;script:"htmx.logAll();"
      ;style: {style}
    ==
    ;body(hx-boost "true", hx-ext "include-vals")
    ::
    ;*  kid
    ::
    ==
  ==
::
++  frame
  |=  kid=marl
  ^-  marl
  ;*
  ;=
  ::  begin content
  ;center-l
    ;div
      ;h1(style "font-style: italic;"): MINAERA
    ==
    ;stack-l
    ::
    ;*  kid
    ::
    ==
  ==
  ::  end content
  ==
::
++  home
  ^-  manx
  %-  page
  ;*
  ;=
  ::  begin content
  ;div
    ::
    ;+  scores:.
    ::
  ==
  ;div
    ;h2: Neighbors
    ::
    ;+  neighbors:.
    ::
  ==
  ::  end content
  ==
::
    :: ;form
    ::   =name       "compute"
    ::   =hx-post    "/apps/frfr/compute"
    ::   =hx-target  "#scores"
    ::   ;h3: Compute a Score
    ::   ;label(for "whom"): Target Ship
    ::   ;input
    ::     =type         "text"
    ::     =name         "whom"
    ::     =placeholder  "~sumwon-sumwer"
    ::     =required     "";
    ::   ;button: Compute
    :: ==
::
++  scores
  ^-  manx
  =/  data=(list [whom=ship latest=score alf=[pos=@ud neg=@ud]])
    %+  turn
      ::  ^scores is a (mip @p @ score), cast it to +tap:by it
      `[whom=@p m=(map @ score)]`~(tap by `(map @p (map @ score))`^scores)
    |=  [whom=@p m=(map @ score)]
    =/  latest=score
      ?~  m  *score
      =/  keys  ~(key by m)
      ?~  keys  *score
      %-  ~(got by m)
      (snag 0 (sort keys gth))
    =/  alf=[pos=@ud neg=@ud]
      %+  reel
        ~(val by alfie.latest)
      |=  [v=[@ud @ud] a=[@ud @ud]]
      [(add -.v -.a) (add +.v +.a)]
    [whom latest alf]
  =/  first  i.data
  ;table
    ;tbody
      ;tr
        ;td(headers "ship")
          ;+  ;/  "{<whom.first>}"
        ==
        ;td(headers "score")
          ;+  ;/  "{(scow %rs score.latest.first)}"
        ==
        ;td(headers "real")
          ;+  ;/  "{<weight.beer.latest.first>}"
        ==
        ;td(headers "pos")
          ;+  ;/  ?:  =(0 pos.alf.first)
                    "·"
                  "{<pos.alf.first>}"
        ==
        ;td(headers "neg")
          ;+  ;/  ?:  =(0 neg.alf.first)
                    "·"
                  "{<neg.alf.first>}"
        ==
      ==
      ;tr
        ;td(id "ship"): ship
        ;td(id "score"): score
        ;td(id "real"): real?
        ;td(id "pos"): 👍
        ;td(id "neg"): 👎
      ==
      ;*
      ^-  manx
      ?~  t.data  *manx
      %+  turn
        t.data
      |=  [whom=ship latest=score alf=[pos=@ud neg=@ud]]
      ;tr
        ;td(headers "ship")
          ;+  ;/  "{<whom>}"
        ==
        ;td(headers "score")
          ;+  ;/  "{(scow %rs score.latest)}"
        ==
        ;td(headers "real")
          ;+  ;/  "{<weight.beer.latest>}"
        ==
        ;td(headers "pos")
          ;+  ;/  ?:  =(0 pos.alf)
                    "·"
                  "{<pos.alf>}"
        ==
        ;td(headers "neg")
          ;+  ;/  ?:  =(0 neg.alf)
                    "·"
                  "{<neg.alf>}"
        ==
      ==
    ==
    ;caption: recent queries
  ==
::
++  neighbors
  ^-  manx
  ;sidebar-l#neighbors(sideWidth "12rem", noStretch "")
    ;form
      =name       "add-edge"
      =hx-post    "/apps/frfr/add-edge"
      =hx-target  "#neighbors"
      ;h3: Add a Neighbor
      ;label(for "whom"): Target Ship
      ;input
        =type         "text"
        =name         "whom"
        =placeholder  "~sumwon-sumwer"
        =required     "";
      ;button: Add
    ==
    ;table
      ;thead
        ;tr
          ;th(scope "col"): Neighbor
          ;th(scope "col"): Controls
        ==
      ==
      ;tbody
        ;*  %+  turn
          ~(tap in ^neighbors)
        |=  whom=@p
        ;tr
          ;td: {<whom>}
          ;td
            ;form
              =name        "del-edge"
              =hx-delete   "/apps/frfr/del-edge"
              =hx-confirm  "Are you sure you want to remove {<whom>} from your neighbors?"
              =hx-target   "#neighbors"
              ;input(type "hidden", name "whom", value "{<whom>}");
              ;button: Delete Edge
            ==
          ==
        ==
      ==
      ;caption: Neighbors
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 80ch;

    --beige: #E8E4E2;
    --brass: #9C918D;
    --black: #1C221F;
  }
  body {
    font-family: Arial, sans-serif;
    font-size: 15px;
    font-weight: 300;
    background: var(--beige);
  }
  :is(h1, pre, code), td:first-child {
    font-family: "Space Mono", monospace;
    font-weight: 700;
  }
  p code {
    padding-inline: 1ch;
  }
  hr, nav {
    width: 100%;
  }
  table {
    background: white;
    border-radius: var(--s0);
    border: 1px solid black;
    font-size: inherit;
    padding-inline: 1ch;
    padding-block: 0.5ch;
  }
  caption {
    caption-side: bottom;
    text-align: end;
    font-style: italic;
  }
  th {
    font-weight: bold;
  }
  th, td {
    color: var(--brass);
    padding-block: var(--s-3);
    padding-inline: var(--s-1);
    text-align: end;
  }
  th:first-child, td:first-child {
    text-align: start;
  }
  form {
    display: flex;
    flex-direction: column;
    gap: var(--s-2);
    margin-block-end: 0;
  }
  form > :is(h1, h2, h3, h4, h5, h6):first-child {
    margin-top: 0;
    margin-bottom: 0;
  }
  '''
--
