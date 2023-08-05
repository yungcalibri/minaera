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
    ;body(hx-ext "json-enc,include-vals")
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
    ;stack-l(space "var(--s2)")
      ;center-l(intrinsic "")
        ;h1:"%frfr"
      ==
      ;nav
        ;cluster-l(justify "end")
          ;a/"/": Home
        ==
      ==
      ;stack-l
      ::
      ;*  kid
      ::
      ==
    ==
  ==
  ::  end content
  ==
::
++  home
  ^-  manx
  %-  page
  ;*  ;=
  ::  begin content
  ;p
    ; This is
    ;code:"%frfr"
    ; , the first aggregator for
    ;code:"%aera"
    ; .
  ==
  ;p
    ;code:"%frfr"
    ; can attempt to calculate a score for any ship, based on the data
    ; available in
    ;code:"%alfie"
    ; and
    ;code:"%beer"
    ; . A score is calculated like this:
    ;br;
    ;code: confidence(%beer) * (sum_me(feels) + 0.5 * sum_peers(feels))
    ;br;
    ; The confidence value comes from %beer, while the feels value is 
    ; calculated by %alfie, subtracting the number of negative reacts
    ; from the number of positive reacts it has collected.
  ==
  ;div
    ;h2: Scores
    ;sidebar-l(sideWidth "12rem", noStretch "")
      ;form
        =name       "compute"
        =hx-post    "/apps/frfr/compute"
        =hx-target  "#scores"
        =hx-swap    "beforeend"
        ;h3: Compute a Score
        ;label(for "who"): Target Ship
        ;input
          =type         "text"
          =name         "who"
          =placeholder  "~sumwon-sumwer"
          =required     "";
        ;button(disabled ""): Compute
      ==
      ;table#scores
        ;thead
          ;tr
            ;th(scope "col"): Ship
            ;th(scope "col"): Score
          ==
        ==
        ;tbody
          ;*  %+  turn
            ~(tap by scores)
          |=  [who=@p m=(map @ score)]
          =/  latest-key=@
            %+  reel
              ~(tap by m)
            |=  [[sap=@ =score] acc=@]
            ?:  (gth sap acc)
              sap
            acc
          =/  latest=score  (~(got by m) latest-key)
          ^-  manx
          ;tr
            ;td
              ;+  ;/  "{<who>}"
            ==
            ;td
              ;+  ;/  "{(scow %rs score.latest)}"
            ==
          ==
        ==
        ;caption: Latest Computed Scores
      ==
    ==
  ==
  ;div
    ;h2: Neighbors
    ;sidebar-l(sideWidth "12rem", noStretch "")
      ;form
        =name       "add-edge"
        =hx-post    "/apps/frfr/add-edge"
        =hx-target  "#neighbors"
        =hx-swap    "beforeend"
        ;h3: Add a Neighbor
        ;label(for "who"): Target Ship
        ;input
          =type         "text"
          =name         "who"
          =placeholder  "~sumwon-sumwer"
          =required     "";
        ;button(disabled ""): Add
      ==
      ;table#neighbors
        ;thead
          ;tr
            ;th(scope "col"): Neighbor
            ;th(scope "col"): Controls
          ==
        ==
        ;tbody
          ;*  %+  turn
            ~(tap in neighbors)
          |=  who=@p
          ;tr
            ;td: {<who>}
            ;td
              ;form
                =name        "del-edge"
                =hx-delete   "/apps/frfr/del-edge"
                =hx-confirm  "Are you sure you want to remove {<who>} from your neighbors?"
                =hx-target   "#neighbors"
                =hx-swap     "beforeend"
                ;input(type "hidden", name "who", value "{<who>}");
                ;button(disabled ""): Delete Edge
              ==
            ==
          ==
        ==
        ;caption: Neighbors
      ==
    ==
  ==
  ::  end content
  ==
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 80ch;
  }
  p code {
    padding-inline: 1ch;
  }
  hr, nav {
    width: 100%;
  }
  table {
    border: var(--s-4) double black;
    border-collapse: collapse;
  }
  caption {
    caption-side: bottom;
    text-align: end;
    font-style: italic;
  }
  th, td {
    padding-block: var(--s-3);
    padding-inline: var(--s-1);
    border: 1px solid black;
    text-align: center;
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
