/-  *frfr
/+  *mip, icons=frfr-icons
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
    ;header
      ;+  aera.icons
      ;div
        ;h1(style "font-style: italic;"): MINAERA
      ==
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
    ;+  (scores:.)
    ::
  ==
  ;div
    ;h2: Neighbors
    ::
    ;+  (neighbors:.)
    ::
  ==
  ::  end content
  ==
::
++  score-row
  |=  [whom=@p m=(map @ score)]
  ^-  manx
  =/  latest-key=@
    %+  reel
      ~(tap by m)
    |=  [[sap=@ =score] acc=@]
    ?:  (gth sap acc)
      sap
    acc
  =/  latest=score  (~(got by m) latest-key)
  =/  alf=[pos=@ud neg=@ud]
    %+  reel
      ~(val by alfie.latest)
    |=  [tem=[@ud @ud] acc=[@ud @ud]]
    [(add -.acc -.tem) (add +.acc +.tem)]
  ::
  ;tr
    ;td
      ;+  ;/  "{<whom>}"
      ;form
        =class      "inline"
        =name       "recompute"
        =hx-post    "/apps/frfr/compute"
        =hx-target  "#scores"
        ;input(type "hidden", name "whom", value "{<whom>}");
        ;button: Recompute
      ==
    ==
    ;td
      ;+  ;/  "{(scow %rs score.latest)}"
    ==
    ;td
      ;+  ;/  "{<weight.beer.latest>}"
    ==
    ;td
      ;+  ;/  ?:  =(0 pos.alf)
                "·"
              "{<pos.alf>}"
    ==
    ;td
      ;+  ;/  ?:  =(0 neg.alf)
                "·"
              "{<neg.alf>}"
    ==
  ==
::
++  scores
  |=  error=_""
  ^-  manx
  ;sidebar-l#scores(side "right", sideWidth "9rem")
    ;table
      ;thead
        ;tr
          ;th(scope "col"): ship
          ;th(scope "col"): score
          ;th(scope "col"): real?
          ;th(scope "col")
            ;+  thumbs-up.icons
          ==
          ;th(scope "col")
            ;+  thumbs-down.icons
          ==
        ==
      ==
      ;tbody
        ;*  %+  turn
          ~(tap by ^scores)
        score-row
      ==
      ;caption: recent queries
    ==
    ;form
      =name       "compute"
      =hx-post    "/apps/frfr/compute"
      =hx-target  "#scores"
      =hx-swap    "outerHTML"
      ;label(for "whom"): Target Ship
      ;input
        =name         "whom"
        =placeholder  "~sumwon-sumwer"
        =hx-post      "/apps/frfr/validate"
        =hx-target    "next .error"
        =hx-swap      "innerHTML"
        =hx-trigger   "change, keyup delay:200ms"
        =required     "";
      ;div.error:"{error}"
      ;button: Compute
    ==
  ==
::
++  neighbors
  |=  error=_""
  ^-  manx
  ;sidebar-l#neighbors(side "right", sideWidth "9rem")
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
              =hx-swap     "outerHTML"
              =hx-target   "#neighbors"
              ;input(type "hidden", name "whom", value "{<whom>}");
              ;button: Delete Edge
            ==
          ==
        ==
      ==
      ;caption: Neighbors
    ==
    ;form
      =name       "add-edge"
      =hx-post    "/apps/frfr/add-edge"
      =hx-swap    "outerHTML"
      =hx-target  "#neighbors"
      ;h3: Add a Neighbor
      ;label(for "whom"): Target Ship
      ;input
        =name         "whom"
        =placeholder  "~sumwon-sumwer"
        =hx-post      "/apps/frfr/validate"
        =hx-target    "next .error"
        =hx-swap      "innerHTML"
        =hx-trigger   "change, keyup delay:200ms"
        =required     "";
        ;div.error:"{error}"
      ;button: Add
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
  header {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin-block-end: var(--s3);
  }
  header > div {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
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
    border-collapse: collapse;
    font-size: inherit;
  }
  thead {
    background: var(--beige);
  }
  tbody {
    background: white;
    border-radius: var(--s0);
  }
  caption {
    caption-side: bottom;
    text-align: end;
    font-style: italic;
  }
  th {
    font-weight: bold;
    color: white;
  }
  td {
    color: var(--brass);
  }
  th, td {
    padding-block: var(--s-3);
    padding-inline: var(--s-1);
    text-align: end;
  }
  tr:first-child > td {
    color: var(--black);
  }
  th:first-child, td:first-child {
    text-align: start;
  }
  form {
    display: flex;
    flex-direction: column;
    align-items: end;
    gap: var(--s-2);
    margin-block-end: 0;
  }
  form.inline {
    align-items: flex-start;
  }
  form > :is(h1, h2, h3, h4, h5, h6):first-child {
    margin-top: 0;
    margin-bottom: 0;
  }
  form .error {
    color: red;
    max-width: 100%;
  }
  '''
--
