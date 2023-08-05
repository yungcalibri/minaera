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
  ;div
    ;h2#scores: Scores
    ;table
      ;caption: Latest Computed Scores
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
    ==
  ==
  ;div
    ;h2#neighbors: Neighbors
    ;table
      ;caption: Neighbors
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
              ;input(type "hidden", name "who", value "{<who>}");
              ;button
                =disabled    ""
                =hx-delete   "/apps/frfr/del-edge"
                =hx-confirm  "Are you sure you want to remove {<who>} from your neighbors?"
                ; Delete Edge
              ==
            ==
          ==
        ==
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
  hr, nav {
    width: 100%;
  }
  table {
    border: var(--s-4) double black;
    border-collapse: collapse;
  }
  th, td {
    padding-block: var(--s-3);
    padding-inline: var(--s-1);
    border: 1px solid black;
    text-align: center;
  }
  '''
--
