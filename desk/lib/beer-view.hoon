/-  *beer
/+  icons=frfr-icons, sigil
|_  [%0 bar=(map @p @)]
::
++  reals
  ^-  (list [@p @])
  (skim ~(tap by bar) |=([* val=@] =(1 val)))
::
++  fakes
  ^-  (list [@p @])
  (skim ~(tap by bar) |=([* val=@] =(0 val)))
::
++  toast
  |=  [whom=@p val=@]
  =/  real=?  ?:(=(0 val) %.n %.y)
  ^-  manx
  ;sidebar-l.toast(space "var(--s-3)", side "right", sideWidth "20%", style "align-items: center;")
    ;stack-l(space "var(--s-3)")
      ;center-l(intrinsic "")
        ;+  %.  whom
            %_  sigil
              size    48
              fg      "var(--sigil-color)"
              bg      "var(--background-color)"
              margin  |
              icon    |
            ==
        ;code(style "text-align: center; text-wrap: wrap; font-size: 70%; max-width: 7.1ch;")
          ; {<whom>}
        ==
      ==
    ==
    ;form
      =name  "toggle"
      ;input(name "whom", type "hidden", value "{<whom>}");
      ;button
        =hx-post    ?:(real "/apps/beer/fake" "/apps/beer/real")
        ::  redirects to main when successful
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ;+  ?:  real
              (thumbs-down.icons 15 15)
            (thumbs-up.icons 15 15)
      ==
      ;b;
      ;button
        =hx-delete  "/apps/beer/delete"
        ::  redirects to main when successful
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ;div(style "transform: rotate(-45deg); color: peru;")
          ;+  (plus.icons 15 15)
        ==
      ==
    ==
  ==
::
++  main
  ^-  manx
  ;div#beer
    ;h2
      ; The
      ;code: %beer
      ;+  ;/  " Bar"
    ==
    ;div.add
      ;form
        =name       "add-beer"
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ;div.joined-input
          ;button
            =hx-post  "/apps/beer/real"
            ;div(style "transform: rotateY(-180deg)")
              ;+  (thumbs-up.icons 18 18)
            ==
          ==
          ;b;
          ;input
            =name         "whom"
            =placeholder  "~sumwon-sumwer"
            =hx-post      "/apps/beer/validate"
            =hx-target    "next .error"
            =hx-swap      "innerHTML"
            =hx-trigger   "change, keyup delay:200ms"
            =required     "";
          ;b;
          ;button
            =hx-post  "/apps/beer/fake"
            ;div(style "transform: rotateY(-180deg)")
              ;+  (thumbs-down.icons 18 18)
            ==
          ==
        ==
      ==
    ==
    ;center-l(intrinsic "")
      ;div.error:""
    ==
    ;+
    ?:  =(0 ~(wyt by bar))
      ;center-l(intrinsic "", andText "")
        ;h3
          ;+  ;/  "You haven't toasted anybody yet. Use the controls above to toast."
        ==
        ;span
          ;+  ;/  "Thumbs up @ps you've met in person. Thumbs down @ps you haven't."
        ==
      ==
    ;sidebar-l.bar(side "right", sideWidth "45%", contentMin "45%", space "var(--s0)")
      ;div.reals
        ;h3: Reals
        ;cluster-l(space "var(--s-1)")
          ;*  (turn reals toast)
        ==
      ==
      ;div.fakes
        ;h3(style "text-align: end"): Fakes
        ;cluster-l(space "var(--s-1)", style "flex-direction: row-reverse;")
          ;*  (turn fakes toast)
        ==
      ==
    ==
  ==
::
--
