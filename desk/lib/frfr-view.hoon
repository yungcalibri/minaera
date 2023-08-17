/-  *frfr
/+  *mip, icons=frfr-icons
|_  [%0 neighbors=(set @p) scores=(mip @p @ score)]
::
++  ordered-scores
  ^-  (list [@p score @])
  %+  sort
    %+  turn
      ~(tap by ^scores)
    |=  [whom=@p m=(map @ score)]
    =/  latest-key=@
      %+  reel
        ~(tap by m)
      |=  [[dat=@ =score] acc=@]
      ?:  (gth dat acc)
        dat
      acc
    [whom (~(got by m) latest-key) latest-key]
  |=  [[* * a=@] [* * b=@]]
  (gth a b)
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
      ;title:"Minaera"
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
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/roboto/700.css";
      ;link
        =rel   "stylesheet"
        =href  "https://unpkg.com/@fontsource/roboto/700-italic.css";
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
    ;body(hx-boost "true", hx-ext "include-vals", hx-indicator "header")
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
    ;header(style "margin-block-start: 5vh;")
      ;+  aera.icons
      ;div.title
        ;h1(style "font-style: italic; font-size: 300%; letter-spacing: 5;"): MINAERA
      ==
      ;div.htmx-indicator
        ;+  loader.icons
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
    ;+  ?~  ^neighbors
          ;div;
        (scores:.)
    ::
  ==
  ;div
    ::
    ;+  (neighbors:.)
    ::
  ==
  ;div#beer  ::  swaps in content from /apps/beer/main, see /lib/beer-view.hoon
    =hx-get      "/apps/beer/main"
    =hx-trigger  "load delay:10ms"
    =hx-target   "#beer"
    =hx-swap     "outerHTML";
  ::  end content
  ==
::
++  score-row
  |=  [whom=@p latest=score *]
  ^-  manx
  =/  alf=[pos=@ud neg=@ud]
    %+  reel
      ~(val by alfie.latest)
    |=  [tem=[@ud @ud] acc=[@ud @ud]]
    [(add -.acc -.tem) (add +.acc +.tem)]
  ::
  ;tr
    ;td
      ;div(style "display: flex; justify-content: start; align-items: center; gap: 1ch;")
        ;form
          =name       "recompute"
          =hx-post    "/apps/frfr/compute"
          =hx-target  "#scores"
          ;input(type "hidden", name "whom", value "{<whom>}");
          ;button.refresh
            ;+  (refresh.icons 16 16)
          ==
        ==
        ;span:" {<whom>}"
      ==
    ==
    ;td
      ;+  ;/  "{(scow %rs score.latest)}"
    ==
    ;td
      ;+  ;/  ?:  =(.0.75 weight.beer.latest)
                "·"
              ?:  =(.0 weight.beer.latest)
                "No"
              "Yes"
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
  ;stack-l#scores(space "var(--s-4)")
    ;div(style "display: flex; flex-direction: row; justify-content: space-between;")
      ;h3: recent queries
      ;form
        =name       "compute"
        =hx-post    "/apps/frfr/compute"
        =hx-target  "#scores"
        =hx-swap    "outerHTML"
        ;div.error:"{error}"
        ;div.joined-input
          ;input
            =name         "whom"
            =placeholder  "~sumwon-sumwer"
            =hx-post      "/apps/frfr/validate"
            =hx-target    "previous .error"
            =hx-swap      "innerHTML"
            =hx-trigger   "change, keyup delay:200ms"
            =required     "";
          ;b;  :: draws the line between the input and the button, see css
          ;button
            ;+  (aera-icon.icons)
          ==
        ==
      ==
    ==
    ;+
    ?:  =(0 (lent ordered-scores))
      ;center-l(intrinsic "")
        ;h4: Use the controls above to query your neighbors
      ==
    ;table
      ;thead
        ;tr
          ;th(scope "col"): ship
          ;th(scope "col"): score
          ;th(scope "col"): real?
          ;th(scope "col")
            ;+  (thumbs-up.icons)
          ==
          ;th(scope "col")
            ;+  (thumbs-down.icons)
          ==
        ==
      ==
      ;tbody
        ;*  %+  turn
              ordered-scores
            score-row
      ==
    ==
  ==
::
++  neighbors
  |=  error=_""
  ^-  manx
  ;stack-l#neighbors(space "var(--s-4)")
    ;div(style "display: flex; flex-direction: row; justify-content: space-between;")
      ;h3: neighbors
      ;form
        =name       "add-edge"
        =hx-post    "/apps/frfr/add-edge"
        =hx-swap    "outerHTML"
                    ::  If we add our first neighbor, the backend will
                    ::  redirect to the root page, and we want to
                    ::  replace everything.
        =hx-target  ?:(=(0 (lent ^neighbors)) "body" "#neighbors")
        ;div.error:"{error}"
        ;div.joined-input
          ;input
            =name         "whom"
            =placeholder  "~sumwon-sumwer"
            =hx-post      "/apps/frfr/validate"
            =hx-target    "previous .error"
            =hx-swap      "innerHTML"
            =hx-trigger   "change, keyup delay:200ms"
            =required     "";
          ;b;
          ;button
            ;+  (plus.icons 25 25)
          ==
        ==
      ==
    ==
    ;+
    ?:  =(0 (lent ^neighbors))
      ;center-l(intrinsic "")
        ;h4: Use the controls above to add a neighbor
      ==
    ;table
      ;thead
        ;tr
          ;th(scope "col"): neighbor
          ;th(scope "col"): controls
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
              =style       "display: flex; justify-content: end;"
              =name        "del-edge"
              =hx-delete   "/apps/frfr/del-edge"
              =hx-confirm  "Are you sure you want to remove {<whom>} from your neighbors?"
              =hx-swap     "outerHTML"
              =hx-target   "#neighbors"
              ;input(type "hidden", name "whom", value "{<whom>}");
              ;button(style "display: flex; align-items: center;")
                ;span: Evict
                ;div(style "display: inline-block; transform: rotate(-45deg); margin-inline-start: 1ch;")
                  ;+  (plus.icons 15 15)
                ==
              ==
            ==
          ==
        ==
      ==
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 75ch;

    --beige: #E8E4E2;
    --brass: #9C918D;
    --black: #1C221F;
    --lavender: #D0DAF1;
  }
  body {
    font-family: Roboto, sans-serif;
    font-size: 15px;
    font-weight: 700;
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
  header > div.title {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  header > div.htmx-indicator {
    position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: row-reverse;
    align-items: center;
    color: var(--brass);
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
    vertical-align: middle;
  }
  thead {
    background: var(--beige);
  }
  tbody {
    background: white;
    border-radius: var(--s0);
  }
  caption {
    caption-side: top;
    color: var(--black);
    text-align: start;
    font-style: italic;
    font-size: 150%;
    padding-block: 0.25ch;
  }
  th {
    font-weight: bold;
    color: var(--brass);
  }
  td {
    color: var(--brass);
  }
  th, td {
    padding-block: var(--s-3);
    padding-inline: var(--s-1);
    text-align: end;
  }
  th {
    padding-block-start: 0;
    padding-block-end: var(--s-4);
  }
  tr {
    transition: background-color 80ms ease;
  }
  tr:first-child > td {
    color: var(--black);
  }
  th:first-child, td:first-child {
    text-align: start;
  }
  form {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: var(--s-2);
    margin-block-end: 0;
  }
  form > :is(h1, h2, h3, h4, h5, h6):first-child {
    margin-top: 0;
    margin-bottom: 0;
  }
  .error {
    color: firebrick;
    max-width: 100%;
  }
  form .joined-input {
    display: flex;
    align-items: stretch;
    gap: 0;
  }
  form .joined-input b {
    display: block;
    width: 2ch;
    height: 1px;
    background-color: var(--brass);
    align-self: center;
  }
  input {
    padding-inline: 1.5ch;
    padding-block: 1ch;
    border-radius: var(--s-4);
    border-color: var(--brass);
    border-style: solid;
    border-width: 1px;
  }
  button {
    padding: 0;
    padding-inline: var(--s-4);
    padding-block: var(--s-4);
    border-width: 1px;
    border-radius: var(--s-3);
    border-style: solid;
    border-color: var(--brass);
    background-color: white;
    cursor: pointer;
    transition: filter 80ms ease;
  }
  button:disabled {
  cursor: not-allowed;
  }
  button:hover {
    filter: brightness(70%);
    transition: filter 120ms ease;
  }
  button:active {
    filter: none;
  }
  table button {
    background-color: var(--beige);
  }
  tr:has(button:hover) {
    background-color: var(--lavender);
    transition: background-color 120ms ease;
  }
  button.refresh {
    padding-inline: 1ch;
    padding-block: 0.2ch;
    max-height: 1.1lh;
  }
  table button {
    padding: 1ch;
    background-color: transparent;
    border: none;
  }
  #neighbors table button {
    color: peru;
  }
  #beer .add {
    display: flex;
    justify-content: center;
    align-items: stretch;
  }
  #beer .error {
    margin-top: var(--s-2);
    font-size: 70%;
    min-height: 1lh;
  }
  #beer .add form button {
    width: 6ch;
  }
  #beer .toast {
    color: var(--brass);
    --sigil-color: var(--brass);
    --background-color: var(--beige);
  }
  #beer .toast form {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    row-gap: 0px;
    justify-content: center;
    align-items: center;
  }
  #beer .toast form b {
    display: block;
    background-color: var(--brass);
    height: 1lh;
    width: 1px;
  }
  #beer form button {
    color: var(--brass);
  }
  #beer .bar {
    margin-top: var(--s-3);
  }
  #beer .bar h3 {
    margin-top: 0;
  }
  #beer .bar > div:last-child {
    flex-direction: row-reverse;
  }
  '''
--
